//
//  FontExtension.swift
//  authenticator
//
//  Created by Tajima Yukito on 2023/01/22.
//

import Foundation
import SwiftUI

extension Font {
    
    static func avenir(_ size: CGFloat = 17) -> Font {
        .custom("AvenirNext", size: size, relativeTo: .title)
    }
    
    static func avenirBold(_ size: CGFloat = 20) -> Font {
        .custom("AvenirNext-DemiBold", size: size, relativeTo: .title)
    }
}
