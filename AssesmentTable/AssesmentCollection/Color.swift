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
    case tableTitle
    case tableContent
    case tableRowHighlight
    case tableRowDefaut
    var uiColor: UIColor { return UIColor(named: rawValue) ?? .black }
    var cgColor: CGColor { return uiColor.cgColor }
}
