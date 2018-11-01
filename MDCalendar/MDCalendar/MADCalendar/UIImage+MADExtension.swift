//
//  UIImage+MADExtension.swift
//  OstrichBlockChain
//
//  Created by 梁宪松 on 2018/10/31.
//  Copyright © 2018 ipzoe. All rights reserved.
//

import UIKit

extension UIImage {

    static func mad_getImage(color: UIColor, size:CGSize, cornerRadius: CGFloat) -> UIImage? {
        
        let rect = CGRect.init(x: 0, y: 0, width: size.width, height: size.height);
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale);
        
        let context = UIGraphicsGetCurrentContext();
        context!.setFillColor(color.cgColor);
        context!.fill(rect);
        
        var image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale);
        UIBezierPath.init(roundedRect: rect, cornerRadius: cornerRadius).addClip();
        
        image?.draw(in: rect);
        
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image;
    }
}
