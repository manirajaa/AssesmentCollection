//
//  AssesmentCollectionCell.swift
//  AssesmentTable
//
//  Created by Manikandan R on 07/11/17.
//  Copyright © 2017 Y Media Labs. All rights reserved.
//

import UIKit

class TabularCollectionCell: UICollectionViewCell {
    
    static let identifier: String = "TabularCollectionCellID"
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var rightSeperator: UIView!
    @IBOutlet weak var bottomSeperator: UIView!
    @IBOutlet private weak var separatorBottomConstraint: NSLayoutConstraint!
    @IBOutlet private weak var separatorTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var labelTopConstraint: NSLayoutConstraint!
    
    
    var extendedSeperatorInset: UIEdgeInsets = .zero {
        didSet {
            separatorTopConstraint.constant = extendedSeperatorInset.top
            separatorBottomConstraint.constant = extendedSeperatorInset.bottom
        }
    }
    
    var shouldRoundLeftCorner: Bool = false {
        didSet {
            container.layer.cornerRadius = shouldRoundLeftCorner ? 4 : 0
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
