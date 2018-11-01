//
//  MADCalendarHeader.swift
//  OstrichBlockChain
//
//  Created by 梁宪松 on 2018/10/31.
//  Copyright © 2018 ipzoe. All rights reserved.
//

import UIKit

class MADCalendarHeader: UIView {
    
    /// click to back to the previous month
    lazy var backButton: UIButton = {
        
        let button = UIButton.init()
        button.setImage(MADBundleUtils.image(name: "mad_calendar_back@2x")!, for: .normal)
        button.setImage(MADBundleUtils.image(name: "mad_calendar_back@2x")!, for: .selected)
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    /// click to forward to the next month
    lazy var forwardButton: UIButton = {
        
        let button = UIButton.init()
        button.setImage(MADBundleUtils.image(name: "mad_calendar_forward@2x")!, for: .normal)
        button.setImage(MADBundleUtils.image(name: "mad_calendar_forward@2x")!, for: .selected)
        button.contentHorizontalAlignment = .right
        return button
    }()
    
    
    /// the button which display current date
    lazy var dateButton: UIButton = {
        
        let button = UIButton.init()
        button.setTitle("2018年12月", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        
        if #available(iOS 8.2, *) {
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        } else {
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        }
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.backButton)
        self.addSubview(self.forwardButton)
        self.addSubview(self.dateButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let edgeOffset: CGFloat = 40.0, buttonW: CGFloat = 24.0, buttonH: CGFloat = 24.0
        
        self.dateButton.center = self.center
        self.dateButton.frame.size = CGSize.init(width: self.frame.width/2.0, height: buttonH)
        
        self.backButton.frame = CGRect.init(x: edgeOffset,
                                            y: (self.frame.height - buttonH)/2.0,
                                            width:buttonW,
                                            height: buttonH)
        
        self.forwardButton.frame = CGRect.init(x: self.frame.width - edgeOffset - buttonW,
                                            y: (self.frame.height - buttonH)/2.0,
                                            width:buttonW,
                                            height: buttonH)
    }
}
