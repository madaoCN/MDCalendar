//
//  MADCalendarCell.swift
//  OstrichBlockChain
//
//  Created by 梁宪松 on 2018/10/31.
//  Copyright © 2018 ipzoe. All rights reserved.
//

import UIKit

class MADCalendarCell: UICollectionViewCell {
    
    let defualtTextHighlightColor = UIColor.init(red: 0, green: 122.0/255, blue: 1, alpha: 1)
    
    // MARK: Var
    var model: MADCalendarDayModel? {
        willSet {
            if let _ = newValue {
                
                self.titleLabel.text = "\(newValue!.day)"
                self.pointButton.isHidden = true
                
                // if is today
                if newValue!.isToday == true {
                    
                    self.titleLabel.textColor = self.defualtTextHighlightColor
                    self.titleLabel.backgroundColor = UIColor.white
                    self.titleLabel.mad_set(cornerRadius: 17)
                    self.addAnimation()
                    
                } else {
                    self.titleLabel.textColor = UIColor.white
                    self.titleLabel.backgroundColor = UIColor.clear
                    self.titleLabel.mad_resetCornerRadius()
                    
                    switch newValue!.dayTag {
                    case .currentMonth:
                        self.titleLabel.textColor = UIColor.white
                    default:
                        self.titleLabel.textColor = UIColor.white.withAlphaComponent(0.5)
                    }
                }
            }
        }
    }
    
    // MARK: UI Component
    lazy var titleLabel: UILabel = {
        
        let label = UILabel.init()
        if #available(iOS 8.2, *) {
            label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        } else {
            label.font = UIFont.systemFont(ofSize: 14)
        }
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.text = "12"
        return label
    }()
    
    lazy var pointButton: UIButton = {
        
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.setBackgroundImage(UIImage.mad_getImage(color: UIColor.white, size: CGSize.init(width: 3, height: 3), cornerRadius: 1.5), for: .normal)
        button.setBackgroundImage(UIImage.mad_getImage(color: self.defualtTextHighlightColor, size: CGSize.init(width: 3, height: 3), cornerRadius: 1.5), for: .selected)
        button.isHidden = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.titleLabel)
        self.addSubview(self.pointButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        self.titleLabel.center = CGPoint.init(x: self.bounds.midX, y: self.bounds.midY)
//        self.titleLabel.size = CGSize.init(width: 34, height: 34)
        self.titleLabel.frame = CGRect.init(x: self.bounds.midX - 17,
                                            y: self.bounds.midY - 17,
                                            width: 34,
                                            height: 34)
        self.pointButton.frame = CGRect.init(x: self.bounds.midX - 1.5,
                                             y: self.bounds.height - 4.5,
                                             width: 3,
                                             height: 3)
    }
    
    func addAnimation() {
        
        let animation = CAKeyframeAnimation.init()
        animation.keyPath = "transform.scale"
        animation.calculationMode = kCAAnimationPaced
        animation.duration = 0.25
        self.titleLabel.layer.add(animation, forKey: nil)
    }
}


extension UILabel {
    
    func mad_set(cornerRadius: CGFloat) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = cornerRadius
    }
    
    func mad_resetCornerRadius() {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 0
    }
}
