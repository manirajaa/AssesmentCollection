//
//  ViewController.swift
//  AssesmentTable
//
//  Created by Manikandan r on 07/11/17.
//  Copyright © 2017 Manikandan r. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: AssesmentCollectionView!
    
    @IBAction func reloadCollection(_ sender: Any) {
        // Can update the data content here.
        self.collectionView.reloadData()
    }
    // DATA
    
    let data :[[String]] = [
        ["Admission Date","Discharge Date","Duration", "Discharge Diagnosis (code and description)"],
        ["value","Discharge Date","Duration", "Discharge Diagnosis (code and description)"],
        ["condition","Discharge Date","Duration", "Discharge Diagnosis (code and description)"],
        ["applied","Discharge Date","Duration", "Discharge Diagnosis (code and description)"],
        ["there","Discharge Date","Duration", "Discharge Diagnosis (code and description)"],
        ["Admission Date","Discharge Date","Duration", "Discharge Diagnosis (code and description)"],
        ["Admission Date","Discharge Date","Duration", "Discharge Diagnosis (code and description)"],
        ["Admission Date","Discharge Date","Duration", "Discharge Diagnosis (code and description)"],
        ["Admission Date","Discharge Date","Duration", "Discharge Diagnosis (code and description)"],
        ["Admission Date","Discharge Date","Duration", "Discharge Diagnosis (code and description)"],
        ["Admission Date","Discharge Date","Duration", "Discharge Diagnosis (code and description)"],
        ["Admission Date","Discharge Date","Duration", "Discharge Diagnosis (code and description)"],
        ["Admission Date","Discharge Date","Duration", "Discharge Diagnosis (code and description)"],
        ["Admission Date","Discharge Date","Duration", "Discharge Diagnosis (code and description)"],
        ["Admission Date","Discharge Date","Duration", "Discharge Diagnosis (code and description)"],
        ["Admission Date","Discharge Date","Duration", "Discharge Diagnosis (code and description)"],
        ["Admission Date","Discharge Date","Duration", "Discharge Diagnosis (code and description)"],
        ["Admission Date","Discharge Date","Duration", "Discharge Diagnosis (code and description)"],
        ["Admission Date","Discharge Date","Duration", "Discharge Diagnosis (code and description)"],
        ["Admission Date","Discharge Date","Duration", "Discharge Diagnosis (code and description)"],
        ["Admission Date","Discharge Date","Duration", "Discharge Diagnosis (code and description)"],
        ["Admission Date","Discharge Date","Duration", "Discharge Diagnosis (code and description)"],
        ["Admission Date","Discharge Date","Duration", "Discharge Diagnosis (code and description)"],
        ["Admission Date","Discharge Date","Duration", "Discharge Diagnosis (code and description)"],
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeCollection()
    }
    
    private func initializeCollection() {
        collectionView.collectionDelegate = self
        collectionView.collectionDatasource = self
        collectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController:AssessmentCollectionDelegate,AssessmentCollectionDataSource {
    //DataSource
    func numberOfColumns(in collectionView:UICollectionView) -> Int {
        return data.first?.count ?? 0
    }
    
    func numberOfRows(in collectionView:UICollectionView) -> Int {
        return data.count
    }
    
    func numberOfStaticRows(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func numberOfStaticColumn(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func titleAttributesForCell(in collectionView:UICollectionView, at indexpath: IndexPath) -> CellTitleAttributes {
        var font = Font.AvenirMedium.font()
        var textAlignment = NSTextAlignment.center
        if indexpath.section == 0 {
            font = Font.AvenirHeavy.font(size: 18)
        }
        if indexpath.row < 2 && indexpath.section != 0 {
            textAlignment = .right
        }
        let titleAttribute = CellTitleAttributes(title: data[indexpath.section][indexpath.row], font: font, textAlignment: textAlignment)
        return titleAttribute
    }

    func collectionCell(isColumnSeperatorHidden indexpath : IndexPath) -> Bool {
        if indexpath.row == 0 {
            return false
        } else {
            return true
        }
    }
    
    //Delegate
    func didSelectRow(at indexPath: IndexPath) {
        print(indexPath.row,indexPath.section)
    }
}

