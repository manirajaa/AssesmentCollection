//
//  AssesmentCollectionView.swift
//  AssesmentTable
//
//  Created by Manikandan r on 13/11/17.
//  Copyright © 2017 Manikandan r. All rights reserved.
//

import UIKit
// DELEGATE
protocol AssessmentCollectionDelegate: class {
    func collectionCell(isRowSeperatorHidden indexpath : IndexPath) -> Bool
    func collectionCell(isColumnSeperatorHidden indexpath : IndexPath) -> Bool
    func textAlignment(forCellat indexpath:IndexPath) -> NSTextAlignment
    func didSelectRow(at indexPath:IndexPath)
}

extension AssessmentCollectionDelegate {
    func collectionCell(isRowSeperatorHidden indexpath : IndexPath) -> Bool {
        return true
    }
    
    func collectionCell(isColumnSeperatorHidden indexpath : IndexPath) -> Bool {
        return true
    }
    
    func textAlignment(forCellat indexpath:IndexPath) -> NSTextAlignment {
        return .center
    }
    
    func didSelectRow(at indexPath:IndexPath) {
        //
    }
}

// DATA SOURCE
protocol AssessmentCollectionDataSource: class {
    func titleForCell(in collectionView:UICollectionView, at indexpath: IndexPath) -> String
    func numberOfColumns(in collectionView:UICollectionView) -> Int
    func numberOfRows(in collectionView:UICollectionView) -> Int
    func numberOfStaticRows(in collectionView:UICollectionView) -> Int
    func numberOfStaticColumn(in collectionView:UICollectionView) -> Int
    
    
    func headers(for collectionView:UICollectionView) -> [String]
    func tableData(for collectionView:UICollectionView) -> [[String]]
}
extension AssessmentCollectionDataSource {
    func numberOfStaticRows(in collectionView: UICollectionView) -> Int {
        return 0
    }
    
    func numberOfStaticColumn(in collectionView: UICollectionView) -> Int {
        return 0
    }
    
    func headers(for collectionView:UICollectionView) -> [String] {
        return []
    }
    
    func tableData(for collectionView:UICollectionView) -> [[String]] {
        return []
    }
}


class AssesmentCollectionView: UICollectionView {
    
    var collectionDatasource:AssessmentCollectionDataSource?
    var collectionDelegate:AssessmentCollectionDelegate?

    private let contentCellIdentifier = "ContentCellIdentifier"

//    var tableData:[[String]] {
//        get {
//          return self.collectionDatasource?.tableData(for: self) ?? []
//        }
//    }
    
//    var headers:[String] {
//        get {
//           return self.collectionDatasource?.headers(for: self) ?? []
//        }
//    }

    // Static contents
    private var numberOfStaticRows: Int {
        get {
            return self.collectionDatasource?.numberOfStaticRows(in: self) ?? 0
        }
    }
    
    private var numberOfStaticColumns: Int {
        get {
            return self.collectionDatasource?.numberOfStaticColumn(in:self) ?? 0
        }
    }
    
    // Seperator
    var showColumnSeperator: Bool = false
    var showRowSeperator:Bool = false
    
    // FONT
    var headerFont:UIFont = Font.heavy.uifontWithDefaultSize()
    var contentFont:UIFont = Font.medium.uifontWithDefaultSize()
    
    var cellNormalColor = UIColor.white
    var cellHiglightColor = UIColor(red: 242/255.0, green: 243/255.0, blue: 247/255.0, alpha: 1.0)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        basicSetup()
    }
    
    func basicSetup() {
        dataSource = self
        delegate = self
        
        self.register(UINib(nibName: String(describing: AssesmentCollectionCell.self), bundle: nil),
                      forCellWithReuseIdentifier: contentCellIdentifier)
        self.collectionViewLayout  = AssesmentCollecionLayout()
        (collectionViewLayout as? AssesmentCollecionLayout)?.headerFont = headerFont
        (collectionViewLayout as? AssesmentCollecionLayout)?.numberOfStaticRows = self.numberOfStaticRows
        (collectionViewLayout as? AssesmentCollecionLayout)?.numberOfStaticColumns = self.numberOfStaticColumns
        (collectionViewLayout as? AssesmentCollecionLayout)?.contentFont = contentFont
        (collectionViewLayout as? AssesmentCollecionLayout)?.cellTitle = { [weak self] indexPath in
            guard let `self` = self else { return "" }
            
            return (self.collectionDatasource?.titleForCell(in: self, at: indexPath))!
            
        }
    }
    
    // Reload the content by setting up the new content.
    override func reloadData() {
        (collectionViewLayout as? AssesmentCollecionLayout)?.itemAttributes.removeAll()
        (collectionViewLayout as? AssesmentCollecionLayout)?.numberOfColumns = self.collectionDatasource?.numberOfColumns(in:self) ?? 0
        (collectionViewLayout as? AssesmentCollecionLayout)?.numberOfStaticRows = self.numberOfStaticRows
        (collectionViewLayout as? AssesmentCollecionLayout)?.numberOfStaticColumns = self.numberOfStaticColumns
        super.reloadData()
    }
}

extension AssesmentCollectionView:UICollectionViewDelegate,UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.collectionDatasource?.numberOfRows(in:collectionView) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.collectionDatasource?.numberOfColumns(in: collectionView) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellIdentifier,
                                                      for: indexPath) as! AssesmentCollectionCell
        if indexPath.section % 2 != 0 {
            cell.backgroundColor = cellHiglightColor
        } else {
            cell.backgroundColor = cellNormalColor
        }
        
        cell.rightSeperator.isHidden = self.collectionDelegate?.collectionCell(isColumnSeperatorHidden: indexPath) ?? false
        cell.bottomSeperator.isHidden = self.collectionDelegate?.collectionCell(isRowSeperatorHidden: indexPath) ?? false
        cell.contentLabel.textAlignment = self.collectionDelegate?.textAlignment(forCellat: indexPath) ?? .center
        
        var font = contentFont
        if indexPath.section < numberOfStaticRows && indexPath.row < numberOfStaticColumns {
            font = headerFont
        } else if indexPath.section < numberOfStaticRows || indexPath.row < numberOfStaticColumns {
            font = headerFont
        }
        cell.contentLabel.font = font
        
        cell.contentLabel.text = self.collectionDatasource?.titleForCell(in: collectionView, at: indexPath)        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.collectionDelegate?.didSelectRow(at: indexPath)
    }
    
    /*
     //TODO: Displaying the shadow and other UI changes while scrolling
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
     if showColumnSeperator {
     if scrollView.contentOffset.x > 0 {
     
     } else {
     
     }
     }
     if showRowSeperator {
     
     }
     }
     */
}
