//
//  AppStyle.swift
//  CustomStyles
//
//  Created by Jayesh Kawli on 6/8/17.
//  Copyright © 2017 Jayesh Kawli. All rights reserved.
//

import UIKit

enum Image: String {
    case chevron
}

class AppStyle {

    let animation: Bool
    var mainImage: UIImage?
    let chevronImage: UIImage
    var backgroundColor: UIColor?
    var textColor: UIColor?
    let cornerRadius: CGFloat
    let font: UIFont
    let text: String

    init(styleInformation: NSDictionary) {
        animation = (styleInformation["animation"] as? Bool) ?? false
        chevronImage = UIImage(named: Image.chevron.rawValue)!
        text = (styleInformation["text"] as? String) ?? ""

        if let imageInfo = styleInformation["image"] as? NSDictionary, let mainImageInfo = imageInfo["main"] as? String, let actualImage = UIImage(named: mainImageInfo) {
            mainImage = actualImage
        }

        if let styles = styleInformation["styles"] as? NSDictionary {

            backgroundColor = (styles["background-color"] as? String)?.hexStringToUIColor()
            textColor = (styles["text-color"] as? String)?.hexStringToUIColor()
            cornerRadius = (styles["corner-radius"] as? CGFloat) ?? 0.0
            if let fontName = styles["font-name"] as? String, let fontSize = styles["font-size"] as? Int, let assignedFont = UIFont(name: fontName, size: CGFloat(fontSize)) {
                font = assignedFont
            } else {
                font = UIFont.systemFont(ofSize: 14)
            }
        } else {
            cornerRadius = 0.0
            font = UIFont.systemFont(ofSize: 14)
        }
    }

}


extension String {
    func hexStringToUIColor () -> UIColor {
        var cString:String = self.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
