//
//  OBCalendarTableHeaderView.swift
//  OstrichBlockChain
//
//  Created by 梁宪松 on 2018/10/31.
//  Copyright © 2018 ipzoe. All rights reserved.
//

import UIKit

class MADCalendarTableHeaderView: UIView {

    lazy var gradientLayer: CAGradientLayer = {
        
        let layer = CAGradientLayer.init()
        layer.startPoint = CGPoint.init(x: 0.5, y: 0)
        layer.endPoint = CGPoint.init(x: 0.5, y: 1)
        layer.locations = [0, 1]
        layer.colors = [
            UIColor.init(red: 102/255.0, green: 170/255.0, blue: 1, alpha: 1).cgColor,
            UIColor.init(red: 30/255.0, green: 106/255.0, blue: 1, alpha: 1).cgColor
        ]
        return layer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.addSublayer(self.gradientLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.gradientLayer.frame = self.bounds
    }
}
