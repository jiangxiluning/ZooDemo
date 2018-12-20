//
//  utils.swift
//  zoo
//
//  Created by luning on 2018/12/20.
//  Copyright © 2018 luning. All rights reserved.
//
import UIKit

func resizeImage(image: UIImage, newSize: CGSize) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
    image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext();
    return newImage;
}
