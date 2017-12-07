//
//  AssesmentCollectionView.swift
//  AssesmentTable
//
//  Created by Manikandan r on 13/11/17.
//  Copyright © 2017 Manikandan r. All rights reserved.
//

import UIKit
@objc protocol AssessmentCollectionDelegate {
    func didSelectRow(at indexPath:IndexPath)
}

@objc protocol AssessmentCollectionDataSource {
    func numberOfStaticRows(in collectionView:UICollectionView) -> Int
    func numberOfStaticColumn(in collectionView:UICollectionView) -> Int
    func headers(for collectionView:UICollectionView) -> [String]
    func tableData(for collectionView:UICollectionView) -> [[String]]
}

class AssesmentCollectionView: UICollectionView {
    
    var collectionDatasource:AssessmentCollectionDataSource?
    var collectionDelegate:AssessmentCollectionDelegate?

    private let contentCellIdentifier = "ContentCellIdentifier"

    var tableData:[[String]] {
        get {
          return self.collectionDatasource?.tableData(for: self) ?? []
        }
    }
    
    var headers:[String] {
        get {
           return self.collectionDatasource?.headers(for: self) ?? []
        }
    }

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
    
    //Column Title array. First object should be same as rowTitle array
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
            if indexPath.section == 0 {
                return self.headers[indexPath.row]
            } else {
                return self.tableData[indexPath.section-1][indexPath.row]
            }
        }
    }
    
    // Reload the content by setting up the new content.
    override func reloadData() {
        (collectionViewLayout as? AssesmentCollecionLayout)?.itemAttributes.removeAll()
        (collectionViewLayout as? AssesmentCollecionLayout)?.numberOfColumns = self.headers.count
        (collectionViewLayout as? AssesmentCollecionLayout)?.numberOfStaticRows = self.numberOfStaticRows
        (collectionViewLayout as? AssesmentCollecionLayout)?.numberOfStaticColumns = self.numberOfStaticColumns
        super.reloadData()
    }
}

extension AssesmentCollectionView:UICollectionViewDelegate,UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.tableData.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.headers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellIdentifier,
                                                      for: indexPath) as! AssesmentCollectionCell
        if indexPath.section % 2 != 0 {
            cell.backgroundColor = UIColor(red: 242/255.0, green: 243/255.0, blue: 247/255.0, alpha: 1.0)
        } else {
            cell.backgroundColor = UIColor.white
        }
        
        var font = contentFont
        if indexPath.section < numberOfStaticRows && indexPath.row < numberOfStaticColumns {
            font = headerFont
        } else if indexPath.section < numberOfStaticRows || indexPath.row < numberOfStaticColumns {
            font = headerFont
        }
        cell.contentLabel.font = font
        
        cell.rightSeperator.isHidden = true
        cell.bottomSeperator.isHidden = true
        if showRowSeperator {
            if indexPath.section == numberOfStaticRows - 1 {
                cell.bottomSeperator.isHidden = false
            }
        }
        if showColumnSeperator {
            if indexPath.row == numberOfStaticColumns - 1 {
                cell.rightSeperator.isHidden = false
            }
        }
        
        cell.contentLabel.textAlignment = .center
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell.contentLabel.textAlignment = .right
            }
            cell.contentLabel.text = self.headers[indexPath.row]
        } else {
            cell.contentLabel.text = self.tableData[indexPath.section - 1][indexPath.row]

            if indexPath.row == 0 {
                cell.contentLabel.textAlignment = .right
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.collectionDelegate?.didSelectRow(at: indexPath)
    }
    
    /* Displaying the shadow and other UI changes while scrolling
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
