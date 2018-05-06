//
//  UIImage+extention.swift
//  GameofThrones
//
//  Created by Abhishek on 06/05/18.
//  Copyright © 2018 Abhishek. All rights reserved.
//

import Foundation
extension UIImage {
    static func getImageFromColor(_ color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0);
        color.setFill()
        UIRectFill(rect);
        
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image!
    }
}


