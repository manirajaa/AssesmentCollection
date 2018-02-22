//
//  Font.swift
//  AssesmentTable
//
//  Created by Manikandan r on 05/12/17.
//  Copyright © 2017 Manikandan r. All rights reserved.
//

import Foundation
import UIKit

enum Font: String {
    
    case avenirHeavy = "Avenir-Heavy"
    case avenirMedium = "Avenir-Medium"
    case avenirLight = "Avenir-Light"

    func font(ofSize size:CGFloat = 14) -> UIFont { return UIFont(name: self.rawValue, size: size)! }
}
