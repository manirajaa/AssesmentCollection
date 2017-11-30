//
//  AssesmentCollectionView.swift
//  AssesmentTable
//
//  Created by Manikandan r on 13/11/17.
//  Copyright © 2017 Manikandan r. All rights reserved.
//

import UIKit

class AssesmentCollectionView: UICollectionView,UICollectionViewDelegate,UICollectionViewDataSource {
    
    private let contentCellIdentifier = "ContentCellIdentifier"
    
    // Static contents
    var numberOfStaticRows: Int = 1
    var numberOfStaticColumns: Int = 1
    
    // Seperator
    var showColumnSeperator: Bool = false
    var showRowSeperator:Bool = false
    
    // FONT
    var headerFont:UIFont = UIFont.systemFont(ofSize: 14.0)
    var contentFont:UIFont = UIFont.systemFont(ofSize: 14.0)
    
    // TABLE content
    private let contentText = "Values"

    //Column Title array. First object should be same as rowTitle array
    var columnTitle : [String] = []
    
    // Row title array. First object should be same as columnTitle array
    var rowTitle: [String] = []

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
        (collectionViewLayout as? AssesmentCollecionLayout)?.contentFont = contentFont
        (collectionViewLayout as? AssesmentCollecionLayout)?.cellTitleCallBack = { [weak self] indexPath in
            guard let `self` = self else { return "" }
            if indexPath.section == 0 {
                return (self.columnTitle[indexPath.row])
            } else {
                if indexPath.row == 0 {
                    return (self.rowTitle[indexPath.section - 1])
                } else {
                    return self.contentText
                }
            }
        }
    }
    
    // Reload the content by setting up the new content.
    override func reloadData() {
        (collectionViewLayout as? AssesmentCollecionLayout)?.itemAttributes.removeAll()
        (collectionViewLayout as? AssesmentCollecionLayout)?.numberOfColumns = columnTitle.count
        (collectionViewLayout as? AssesmentCollecionLayout)?.numberOfStaticRows = numberOfStaticRows
        (collectionViewLayout as? AssesmentCollecionLayout)?.numberOfStaticColumns = numberOfStaticColumns
        super.reloadData()
    }
    
    //MARK: DATASOURCE
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.rowTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.columnTitle.count
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
            cell.contentLabel.text = self.columnTitle[indexPath.row]
        } else {
            if indexPath.row == 0 {
                cell.contentLabel.text = self.rowTitle[indexPath.section]
                cell.contentLabel.textAlignment = .right
            } else {
                cell.contentLabel.text = contentText
            }
        }
        return cell
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
