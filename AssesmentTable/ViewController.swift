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
        ["Title1","Title2","Title3", "Title4"],
        ["value","Date","Duration", "code and description","value","Date","Duration", "code and description"],
        ["value","Date","Duration", "code and description","value","Date","Duration", "code and description"],
        ["value","Date","Duration", "code and description","value","Date","Duration", "code and description"],
        ["value","Date","Duration", "code and description","value","Date","Duration", "code and description"],
        ["value","Date","Duration", "code and description","value","Date","Duration", "code and description"],
        ["value","Date","Duration", "code and description","value","Date","Duration", "code and description"],
        ["value","Date","Duration", "code and description","value","Date","Duration", "code and description"],
        ["value","Date","Duration", "code and description","value","Date","Duration", "code and description"],
        ["value","Date","Duration", "code and description","value","Date","Duration", "code and description"],
        ["value","Date","Duration", "code and description","value","Date","Duration", "code and description"],
        ["value","Date","Duration", "code and description","value","Date","Duration", "code and description"],
        ["value","Date","Duration", "code and description","value","Date","Duration", "code and description"],
        ["value","Date","Duration", "code and description","value","Date","Duration", "code and description"],
        ["value","Date","Duration", "code and description","value","Date","Duration", "code and description"],
        ["value","Date","Duration", "code and description","value","Date","Duration", "code and description"],
        ["value","Date","Duration", "code and description","value","Date","Duration", "code and description"],
        ["value","Date","Duration", "code and description","value","Date","Duration", "code and description"],
        ["value","Date","Duration", "code and description","value","Date","Duration", "code and description"],
        ["value","Date","Duration", "code and description","value","Date","Duration", "code and description"],
        ["value","Date","Duration", "code and description","value","Date","Duration", "code and description"],
        ["value","Date","Duration", "code and description","value","Date","Duration", "code and description"],
        ["value","Date","Duration", "code and description","value","Date","Duration", "code and description"]
    ]
    
    // MARK: - OVERRIDE METHODS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeCollection()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { (context) in
            // Reloading the collection on rotation to recalculate the item sizes in tabular layout.
            self.collectionView.reloadData()
        })
    }
    
    // MARK: - PRIVATE METHOD
    
    private func initializeCollection() {
        collectionView.tabularDelegate = self
        collectionView.tabularDatasource = self
        collectionView.reloadData()
    }
}

// MARK: - TabularCollectionDataSource

extension ViewController: TabularCollectionDataSource {
    
    func tabularView(_ tabularView: TabularCollectionView, titleAttributesForCellAt indexpath: IndexPath) -> CellTitleAttributes {
        var font = Font.avenirMedium.font()
        var textAlignment = NSTextAlignment.center
        if indexpath.section == 0 {
            font = Font.avenirHeavy.font(ofSize: 18)
        }
        if indexpath.row < 2 && indexpath.section != 0 {
            textAlignment = .right
        }
        let text = data[indexpath.section][indexpath.row]
        return CellTitleAttributes(title: text, font: font, textAlignment: textAlignment, textColor: Color.text.uiColor)
    }
    
    func numberOfColumns(in tabularView: TabularCollectionView) -> Int { return data.first?.count ?? 0 }
    
    func numberOfRows(in tabularView: TabularCollectionView) -> Int { return data.count }
        
    func numberOfStaticRows(in tabularView: TabularCollectionView) -> Int { return 1 }
    
    func numberOfStaticColumn(in tabularView: TabularCollectionView) -> Int { return 1 }
    
}

// MARK: - TabularCollectionDelegate

extension ViewController: TabularCollectionDelegate {
    
    func tabularView(_ tabularView: TabularCollectionView, didSeletItemAt indexPath: IndexPath) { }
    
    func tabularView(_ tabularView: TabularCollectionView, shouldHideColumnSeparatorAt indexPath: IndexPath) -> Bool {
        return indexPath.row != 0
    }
}

