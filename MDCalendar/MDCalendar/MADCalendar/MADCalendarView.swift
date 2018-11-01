//
//  MADCalendarView.swift
//  OstrichBlockChain
//
//  Created by 梁宪松 on 2018/10/31.
//  Copyright © 2018 ipzoe. All rights reserved.
//

import UIKit

class MADCalendarView: UIView {

    /// symbols of a day in a week
    let weekTitles = [
        "S", "M", "T", "W", "F", "T", "S",
    ]
    
    /// current month data
    var currentMonthData: MADCalendarMonthModel!

    /// history month data model
    var calendarMonthDataArr = [MADCalendarMonthModel]()
    
    /// calendar header view
    lazy var calendarHeaderView: MADCalendarHeader = {
        
        let view = MADCalendarHeader.init(frame: CGRect.zero)
        return view
    }()
    
    /// collectionview layout
    lazy var flowLayout: UICollectionViewFlowLayout = {
        
        let layout = UICollectionViewFlowLayout.init()
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        return layout
    }()
    
    /// calendar collectionview
    lazy var calenderCollectionView: UICollectionView = {
       
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: self.flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        collectionView.alwaysBounceVertical = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false

        // register collectionview cell
        collectionView.register(MADCalendarCell.self, forCellWithReuseIdentifier: String.init(describing: MADCalendarCell.self))
        
        return collectionView
    }()
    
    // MARK: Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.calendarHeaderView)
        self.addSubview(self.calenderCollectionView)
        
        // add swipe gesture
        let leftSwipe = UISwipeGestureRecognizer.init(target: self, action: #selector(swipeLeft))
        leftSwipe.direction = .left
        let rightSwipe = UISwipeGestureRecognizer.init(target: self, action: #selector(swipeRight))
        rightSwipe.direction = .right
        
        self.calenderCollectionView.addGestureRecognizer(leftSwipe)
        self.calenderCollectionView.addGestureRecognizer(rightSwipe)

        self.setupInitialization()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: initialize
    func setupInitialization() {
        
        self.calendarMonthDataArr.removeAll()
        
        let currentDate = Date()
        
        let previousMonthModel = MADCalendarMonthModel.modelWithDate(date: currentDate.mad_previousMonthDate())
        self.calendarMonthDataArr.append(previousMonthModel)
        
        self.currentMonthData = MADCalendarMonthModel.modelWithDate(date: currentDate)
        self.calendarMonthDataArr.append(self.currentMonthData)
        self.calendarHeaderView.dateButton.setTitle("\(self.currentMonthData.year)年\(self.currentMonthData.month)月", for: .normal)
        
        let nextMonthModel = MADCalendarMonthModel.modelWithDate(date: currentDate.mad_nextMonthDate())
        self.calendarMonthDataArr.append(nextMonthModel)
    }
    
    // MARK: Event Handler
    @objc func swipeLeft(swipte: UISwipeGestureRecognizer) {
        
        let usedIndex = self.monthIndexOf(model: self.currentMonthData)
        guard (usedIndex + 1) < self.calendarMonthDataArr.count,
              usedIndex >= 0 else {
            return
        }
        self.currentMonthData = self.calendarMonthDataArr[usedIndex + 1]
        self.calendarHeaderView.dateButton.setTitle("\(self.currentMonthData.year)年\(self.currentMonthData.month)月", for: .normal)
        self.performSwipeAnimation(subType: kCATransitionFromRight as CATransitionSubtype)
        self.calenderCollectionView.reloadData()
    }
    
    @objc func swipeRight(swipte: UISwipeGestureRecognizer) {
        
        let usedIndex = self.monthIndexOf(model: self.currentMonthData)
        guard (usedIndex - 1) >= 0 else {
            return
        }
        self.currentMonthData = self.calendarMonthDataArr[usedIndex - 1]
        self.calendarHeaderView.dateButton.setTitle("\(self.currentMonthData.year)年\(self.currentMonthData.month)月", for: .normal)
        self.performSwipeAnimation(subType: kCATransitionFromLeft as CATransitionSubtype)
        self.calenderCollectionView.reloadData()
    }
    
    /// get the current index of target obj in calendarMonthDataArr
    ///
    /// - Parameter model: target object
    /// - Returns: --
    func monthIndexOf(model: MADCalendarMonthModel) -> Int {
        
        for (index, item) in self.calendarMonthDataArr.enumerated() {
            if item.date == model.date {
                return index
            }
        }
        return -1
    }
    
    func performSwipeAnimation(subType: CATransitionSubtype) {
        let transition = CATransition.init()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut)
        transition.type = kCATransitionPush
        transition.subtype = subType as String
        self.calenderCollectionView.layer.add(transition, forKey: nil)
    }
    
    // MARK: Layout
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.calendarHeaderView.frame = CGRect.init(x: 0,
                                                    y: 0,
                                                    width: self.frame.width,
                                                    height: 64)
        self.calenderCollectionView.frame = CGRect.init(x: 20,
                                                        y: self.calendarHeaderView.frame.maxY - 10,
                                                        width: self.frame.width - 40,
                                                        height: self.frame.height - self.calendarHeaderView.frame.height - 10)

    }
    
}

extension MADCalendarView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.currentMonthData.dayArr.count + self.weekTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String.init(describing: MADCalendarCell.self), for: indexPath) as! MADCalendarCell
        
        if indexPath.row < self.weekTitles.count {
            cell.titleLabel.text = self.weekTitles[indexPath.row]
        }else {
            let index = indexPath.row - self.weekTitles.count
            if index < self.currentMonthData.dayArr.count {                
                cell.model = self.currentMonthData.dayArr[index]
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if self.currentMonthData.dayArr.count > 0 {
            let rowNums = self.currentMonthData.dayArr.count / 7 + 1
            return CGSize.init(width: self.calenderCollectionView.frame.width/7,
                                                   height: self.calenderCollectionView.frame.height/CGFloat(rowNums))
        } else {
            return CGSize.init(width: self.calenderCollectionView.frame.width/7,
                                                   height: self.calenderCollectionView.frame.height/7)
        }
    }
}

