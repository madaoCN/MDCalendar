//
//  ViewController.swift
//  MDCalendar
//
//  Created by 梁宪松 on 2018/11/1.
//  Copyright © 2018 madao. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    lazy var calendarView: MADCalendarView = {
        
        let view = MADCalendarView.init(frame: CGRect.zero)
        return view
    }()
    
    lazy var calendarHeaderView: MADCalendarTableHeaderView = {
        let view = MADCalendarTableHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 313))
        return view
    }()
    
    lazy var containerTableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: .grouped)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.backgroundColor = UIColor.white
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(containerTableView)
        self.containerTableView.frame = self.view.bounds
        
        self.calendarHeaderView.addSubview(self.calendarView)
        self.calendarView.frame = self.calendarHeaderView.bounds
        self.containerTableView.tableHeaderView = self.calendarHeaderView
    }
}

