//
//  String+Utility.swift
//  AssesmentTable
//
//  Created by Manikandan r on 22/02/18.
//  Copyright © 2018 Manikandan r. All rights reserved.
//

import UIKit
extension String {
    
    // To find the size of the String
    func size(withConstrainedWidth width: CGFloat = .greatestFiniteMagnitude, height: CGFloat = .greatestFiniteMagnitude, font: UIFont) -> CGSize {
        let constraintSize = CGSize(width: width, height: height)
        return self.boundingRect(with: constraintSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil).size
    }
    
}
