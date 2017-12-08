//
//  AssesmentCollectionView.swift
//  AssesmentTable
//
//  Created by Manikandan r on 13/11/17.
//  Copyright © 2017 Manikandan r. All rights reserved.
//

import UIKit

struct CellTitleAttributes {
    var title: String
    var font: UIFont = Font.AvenirMedium.font()
    var textAlignment: NSTextAlignment = .center
}

// MARK: DELEGATE
protocol TabularCollectionDelegate: class {
    func tabularView(_ tabularView: TabularCollectionView, isRowSeperatorHidden indexpath: IndexPath) -> Bool
    func tabularView(_ tabularView: TabularCollectionView, isColumnSeperatorHidden indexpath: IndexPath) -> Bool
    func tabularView(_ tabularView: TabularCollectionView, didSeletItemAt indexPath: IndexPath)
}

extension TabularCollectionDelegate {
    //Optional methods.
    func tabularView(_ tabularView: TabularCollectionView, isRowSeperatorHidden indexpath: IndexPath) -> Bool {
        return true
    }
    
    func tabularView(_ tabularView: TabularCollectionView, isColumnSeperatorHidden indexpath: IndexPath) -> Bool {
        return true
    }
    
    func tabularView(_ tabularView: TabularCollectionView, didSeletItemAt indexPath: IndexPath) { }
}

// DATA SOURCE
protocol TabularCollectionDataSource: class {
    func tabularView(_ tabularView: TabularCollectionView, titleAttributesForCell indexpath: IndexPath) -> CellTitleAttributes
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
    weak var collectionDatasource: TabularCollectionDataSource?
    weak var collectionDelegate: TabularCollectionDelegate?
    
    //Color
    var cellNormalColor = UIColor.white
    var cellHiglightColor = UIColor(red: 242/255.0, green: 243/255.0, blue: 247/255.0, alpha: 1.0)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        basicSetup()
    }
    
    func basicSetup() {
        dataSource = self
        delegate = self
        
        register(UINib(nibName: String(describing: TabularCollectionCell.self), bundle: nil),
                 forCellWithReuseIdentifier: TabularCollectionCell.identifier)
        
        let layout = TabularLayout()
        collectionViewLayout = layout
        (collectionViewLayout as? TabularLayout)?.numberOfStaticRows = collectionDatasource?.numberOfStaticRows(in: self) ?? 0
        (collectionViewLayout as? TabularLayout)?.numberOfStaticColumns = collectionDatasource?.numberOfStaticColumn(in: self) ?? 0
        (collectionViewLayout as? TabularLayout)?.cellTitleAttributes = { [weak self] indexPath in
            guard let `self` = self else {
                let attribute = CellTitleAttributes(title: "", font: Font.AvenirMedium.font(), textAlignment: .center)
                return (attribute.title, attribute.font)
            }
            guard let attribute = (self.collectionDatasource?.tabularView(self, titleAttributesForCell: indexPath))  else {
                return ("", Font.AvenirMedium.font())
            }
            return (attribute.title, attribute.font)
        }
    }
    
    // Reload the content by setting up the new content.
    override func reloadData() {
        (collectionViewLayout as? TabularLayout)?.itemAttributes.removeAll()
        (collectionViewLayout as? TabularLayout)?.numberOfColumns = collectionDatasource?.numberOfColumns(in: self) ?? 0
        super.reloadData()
    }
}

extension TabularCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return collectionDatasource?.numberOfRows(in: self) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionDatasource?.numberOfColumns(in: self) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TabularCollectionCell.identifier, for: indexPath)
        
        if indexPath.section % 2 != 0 {
            (cell as? TabularCollectionCell)?.backgroundColor = cellHiglightColor
        } else {
            (cell as? TabularCollectionCell)?.backgroundColor = cellNormalColor
        }
        
        (cell as? TabularCollectionCell)?.rightSeperator.isHidden = collectionDelegate?.tabularView(self, isColumnSeperatorHidden: indexPath) ?? true
        (cell as? TabularCollectionCell)?.bottomSeperator.isHidden = collectionDelegate?.tabularView(self, isRowSeperatorHidden: indexPath) ?? true
        
        let titleAttribute = collectionDatasource?.tabularView(self, titleAttributesForCell: indexPath)
        (cell as? TabularCollectionCell)?.contentLabel.font = titleAttribute?.font
        (cell as? TabularCollectionCell)?.contentLabel.text = titleAttribute?.title
        (cell as? TabularCollectionCell)?.contentLabel.textAlignment = titleAttribute?.textAlignment ?? .center
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionDelegate?.tabularView(self, didSeletItemAt: indexPath)
    }
    
}

