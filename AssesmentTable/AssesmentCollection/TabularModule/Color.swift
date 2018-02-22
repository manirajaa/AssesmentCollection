//
//  Color.swift
//  AssesmentTable
//
//  Created by Manikandan r on 05/12/17.
//  Copyright © 2017 Manikandan r. All rights reserved.
//

import Foundation
import UIKit

enum Color: String {
    case text
    case secondaryText
    case background
    
    var uiColor: UIColor {
        switch self {
        case .text:
            return UIColor(red: 0.27, green: 0.29, blue: 0.36, alpha: 1.0)
        case .secondaryText:
            return UIColor(red: 0.55, green: 0.57, blue: 0.60, alpha: 1.0)
        case .background:
            return UIColor(red: 0.95, green: 0.96, blue: 0.97, alpha: 1.0)
        }
    }
    var cgColor: CGColor { return uiColor.cgColor }
}
