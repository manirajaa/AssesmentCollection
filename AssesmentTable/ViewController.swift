//
//  ViewController.swift
//  AssesmentTable
//
//  Created by Manikandan r on 07/11/17.
//  Copyright © 2017 Manikandan r. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: TabularCollectionView!
    
    @IBAction func reloadCollection(_ sender: Any) {
        // Can update the data content here.
        self.collectionView.reloadData()
    }
    // DATA
    
    let data :[[String]] = [
        ["Admission Date","Discharge Date","Duration", "Discharge)"],
        ["value","Discharge Date","Duration", "Discharge Diagnosis (code and description)"],
        ["condition","Discharge Date","Duration", "Discharge Diagnosis (code and description)"],
        ["applied","Discharge Date","Duration", "Discharge Diagnosis (code and description)"],
        ["there","Discharge Date","Duration", "Discharge Diagnosis (code and description)"],
        ["Admission Date","Discharge Date","Duration", "Discharge )"],
        ["Admission Date","Discharge Date","Duration", "Discharge  description)"],
        ["Admission Date","Discharge Date","Duration", "Discharge )"],
        ["Admission Date","Discharge Date","Duration", "Discharge Diagnosis (code and description)"],
        ["Admission Date","Discharge Date","Duration", "Discharge"],
        ["Admission Date","Discharge Date","Duration", "Discharge Diagnosis (code and description)"],
        ["Admission Date","Discharge Date","Duration", "Discharge Diagnosis (code and description)"],
        ["Admission Date","Discharge Date","Duration", "Discharge Diagnosis (code and description)"],
        ["Admission Date","Discharge Date","Duration", ")"],
        ["Admission Date","Discharge Date","Duration", "Discharge Diagnosis (code and description)"],
        ["Admission Date","Discharge Date","Duration", "Discharge Diagnosis (code and description)"],
        ["Admission Date","Discharge Date","Duration", "Discharge Diagnosis)"],
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

extension ViewController: TabularCollectionDelegate, TabularCollectionDataSource {
    func tabularView(_ tabularView: TabularCollectionView, titleAttributesForCell indexpath: IndexPath) -> CellTitleAttributes {
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
    
    func numberOfColumns(in tabularView: TabularCollectionView) -> Int {
        return data.first?.count ?? 0
    }
    
    func numberOfRows(in tabularView: TabularCollectionView) -> Int {
        return data.count
    }
    
    func collectionCell(isColumnSeperatorHidden indexpath : IndexPath) -> Bool {
        if indexpath.row == 0 {
            return false
        } else {
            return true
        }
    }
    
    //Delegate
    func tabularView(_ tabularView: TabularCollectionView, didSeletItemAt indexPath: IndexPath) { }
}

