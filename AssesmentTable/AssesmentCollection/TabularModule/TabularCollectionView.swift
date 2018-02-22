//
//  AssesmentCollectionView.swift
//  AssesmentTable
//
//  Created by Manikandan R on 13/11/17.
//  Copyright © 2017 Y Media Labs. All rights reserved.
//

import UIKit

struct CellTitleAttributes {
    var title: String?
    var font: UIFont = Font.avenirMedium.font(ofSize: 14)
    var textAlignment: NSTextAlignment = .left
    var textColor: UIColor = Color.text.uiColor
}

// MARK: DELEGATE
protocol TabularCollectionDelegate: class {

    func tabularView(_ tabularView: TabularCollectionView, didSelectItemAt indexPath: IndexPath)
}

extension TabularCollectionDelegate {
    //Optional methods.
    func tabularView(_ tabularView: TabularCollectionView, shouldHideRowSeparatorAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tabularView(_ tabularView: TabularCollectionView, shouldHideColumnSeparatorAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tabularView(_ tabularView: TabularCollectionView, didSelectItemAt indexPath: IndexPath) { }
}

// DATA SOURCE
protocol TabularCollectionDataSource: class {
    func tabularView(_ tabularView: TabularCollectionView, titleAttributesForCellAt indexPath: IndexPath) -> CellTitleAttributes
    func numberOfColumns(in tabularView: TabularCollectionView) -> Int
    func numberOfRows(in tabularView: TabularCollectionView) -> Int
    func numberOfStaticRows(in tabularView: TabularCollectionView) -> Int
    func numberOfStaticColumn(in tabularView: TabularCollectionView) -> Int
}

extension TabularCollectionDataSource {
    func numberOfStaticRows(in tabularView: TabularCollectionView) -> Int {
        return 0
    }
    
    func numberOfStaticColumn(in tabularView: TabularCollectionView) -> Int {
        return 0
    }
}

class TabularCollectionView: UICollectionView {
    weak var tabularDatasource: TabularCollectionDataSource?
    weak var tabularDelegate: TabularCollectionDelegate?
    
    //Color
    var cellNormalColor = UIColor.white
    var cellHighlightColor = Color.background.uiColor
    var extendedShadowTop: CGFloat = -10
    var extendedShadowBottom: CGFloat = -10
    
    override func awakeFromNib() {
        super.awakeFromNib()
        basicSetup()
    }

    func basicSetup() {
        dataSource = self
        delegate = self
        bounces = false
        isDirectionalLockEnabled = true
        register(UINib(nibName: String(describing: TabularCollectionCell.self), bundle: nil), forCellWithReuseIdentifier: TabularCollectionCell.identifier)
        
        let layout = TabularLayout()
        layout.cellTitleAttributes = { [weak self] indexPath in
            guard let strongSelf = self, let attribute = strongSelf.tabularDatasource?.tabularView(strongSelf, titleAttributesForCellAt: indexPath) else {
                return (nil, Font.avenirMedium.font(ofSize: 14))
            }
            
            return (attribute.title, attribute.font)
        }
        
        collectionViewLayout = layout
    }
    
    // Reload the content by setting up the new content.
    override func reloadData() {
        (collectionViewLayout as? TabularLayout)?.itemAttributes.removeAll()
        (collectionViewLayout as? TabularLayout)?.numberOfStaticRows = tabularDatasource?.numberOfStaticRows(in: self) ?? 0
        (collectionViewLayout as? TabularLayout)?.numberOfStaticColumns = tabularDatasource?.numberOfStaticColumn(in: self) ?? 0
        (collectionViewLayout as? TabularLayout)?.numberOfColumns = tabularDatasource?.numberOfColumns(in: self) ?? 0
        super.reloadData()
        // Prepare the content to its actual position.
        (collectionViewLayout as? TabularLayout)?.prepare()
    }
}

// MARK: - UICollectionViewDataSource
extension TabularCollectionView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return tabularDatasource?.numberOfRows(in: self) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabularDatasource?.numberOfColumns(in: self) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TabularCollectionCell.identifier, for: indexPath)
        
        // Giving Alternate Background colors for each section As per the design.
        (cell as? TabularCollectionCell)?.container.backgroundColor = (indexPath.section % 2 == 0) ? cellNormalColor : cellHighlightColor

        (cell as? TabularCollectionCell)?.shouldRoundLeftCorner = indexPath.row == 0
        // Separator for cells
        (cell as? TabularCollectionCell)?.rightSeperator.isHidden = tabularDelegate?.tabularView(self, shouldHideColumnSeparatorAt: indexPath) ?? true
        (cell as? TabularCollectionCell)?.bottomSeperator.isHidden = tabularDelegate?.tabularView(self, shouldHideRowSeparatorAt: indexPath) ?? true
        
        // Getting Data Source related to Title attributes.
        let titleAttribute = tabularDatasource?.tabularView(self, titleAttributesForCellAt: indexPath)
        (cell as? TabularCollectionCell)?.contentLabel.font = titleAttribute?.font
        (cell as? TabularCollectionCell)?.contentLabel.text = titleAttribute?.title
        (cell as? TabularCollectionCell)?.contentLabel.textAlignment = titleAttribute?.textAlignment ?? .left
        (cell as? TabularCollectionCell)?.contentLabel.textColor = titleAttribute?.textColor
        
        // Extending the Right shadow only to first and last section
        (cell as? TabularCollectionCell)?.labelTopConstraint.constant = indexPath.section == 0 ? 16 : 8
        (cell as? TabularCollectionCell)?.extendedSeperatorInset.top = indexPath.section == 0 ? extendedShadowTop : 0
        (cell as? TabularCollectionCell)?.extendedSeperatorInset.bottom = (indexPath.section == (tabularDatasource?.numberOfRows(in: self) ?? 0) - 1 ) ? extendedShadowBottom : 0

        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension TabularCollectionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tabularDelegate?.tabularView(self, didSelectItemAt: indexPath)
    }

}
