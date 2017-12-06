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
    var columnTitle : [String] = ["Value","Unit","Nov'17","Dec'17","Jan'18","Feb'18jhjhjhgjghjkh","Mar'18","Apr'18","May'18","J","July'18"]
    var rowTitle: [String] = ["Value","URR","HGB","TSAT","GSTdsf hfhgfhgfh","AST jjh","Feb'18","Mar'18","Apr'18","May'18","Jun'18","July'18","AST","Feb'18","Mar'18","Apr'18","May'18","Jun'18 asf","July'18","AST","Feb'18","Mar'18","Apr'18","May'18","Jun'18","July'18"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeCollection()
    }
    
    private func initializeCollection() {
        collectionView.numberOfStaticRows = 2
        collectionView.numberOfStaticColumns = 0
        collectionView.columnTitle  = columnTitle
        collectionView.rowTitle = rowTitle
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

