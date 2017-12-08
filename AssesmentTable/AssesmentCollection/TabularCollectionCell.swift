//
//  AssesmentCollectionCell.swift
//  AssesmentTable
//
//  Created by Manikandan r on 07/11/17.
//  Copyright © 2017 Manikandan r. All rights reserved.
//

import UIKit

class TabularCollectionCell: UICollectionViewCell {
    static let identifier: String = "TabularCollectionCellID"
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var rightSeperator: UIView!
    @IBOutlet weak var bottomSeperator: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
