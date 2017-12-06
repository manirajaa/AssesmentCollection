//
//  Font.swift
//  AssesmentTable
//
//  Created by Manikandan r on 05/12/17.
//  Copyright © 2017 Manikandan r. All rights reserved.
//

import Foundation
import UIKit

enum Font {
    case heavy
    case medium
    case light
    
    func uifont(withSize size:CGFloat = 14) -> UIFont {
        switch self {
        case .heavy:
            return UIFont(name: "Avenir-Heavy", size: size)!
        case .medium:
            return UIFont(name: "Avenir-Medium", size: size)!
        case .light:
            return UIFont(name: "Avenir-Light", size: size)!
        }
    }
    
    func uifontWithDefaultSize() -> UIFont {
        switch self {
        case .heavy:
            return UIFont(name: "Avenir-Heavy", size: 14)!
        case .medium:
            return UIFont(name: "Avenir-Medium", size: 14)!
        case .light:
            return UIFont(name: "Avenir-Light", size: 14)!
        }
    }

    

}
