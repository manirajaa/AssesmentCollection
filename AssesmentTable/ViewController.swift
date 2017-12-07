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
    let headers: [String] = ["Admission Date","Discharge Date","Duration", "Discharge Diagnosis (code and description)"]
    
    let data :[[String]] = [
        ["Admission Date","Discharge Date","Duration", "Discharge Diagnosis (code and description)"]
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeCollection()
    }
    
    private func initializeCollection() {
        collectionView.collectionDelegate = self
        collectionView.collectionDatasource = self
        collectionView.headerFont = Font.heavy.uifont(withSize: 16)
        collectionView.contentFont = Font.medium.uifontWithDefaultSize()
        collectionView.showColumnSeperator = true
        collectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension ViewController:AssessmentCollectionDelegate,AssessmentCollectionDataSource {
    //DataSource
    func numberOfStaticRows(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func numberOfStaticColumn(in collectionView: UICollectionView) -> Int {
        return 0
    }
    
    func headers(for collectionView:UICollectionView) -> [String] {
        return headers
    }
    
    func tableData(for collectionView:UICollectionView) -> [[String]] {
        return data
    }

    //Delegate
    func didSelectRow(at indexPath: IndexPath) {
        print(indexPath.row,indexPath.section)
    }
}

