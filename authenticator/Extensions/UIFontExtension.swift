//
//  UIFontExtension.swift
//  authenticator
//
//  Created by Tajima Yukito on 2023/01/22.
//

import Foundation
import UIKit

extension UIFont {
    
    class func avenirDemiBold(_ size: CGFloat = 20) -> UIFont {
        UIFont(name: "AvenirNext-DemiBold", size: size) ?? .systemFont(ofSize: size, weight: .medium)
    }
    
    class func avenirBold(_ size: CGFloat = 30) -> UIFont {
        UIFont(name: "AvenirNext-Bold", size: size) ?? .systemFont(ofSize: size, weight: .medium)
    }
}
