//
//  MADBundleUtils.swift
//  OstrichBlockChain
//
//  Created by 梁宪松 on 2018/10/31.
//  Copyright © 2018 ipzoe. All rights reserved.
//

import UIKit

class MADBundleUtils: NSObject {

    static var currBundle: Bundle? = {
        
        guard let path = Bundle.main.path(forResource: "MADCalendar", ofType: "bundle") else {
            return nil
        }
        return Bundle.init(path: path)
    }()
    
    static func image(from bunlde: Bundle? = MADBundleUtils.currBundle, name: String, type: String = "png") -> UIImage? {
        guard let path = bunlde?.path(forResource: name, ofType: type) else {
            return nil
        }
        
        return  UIImage.init(contentsOfFile: path)
    }
}
