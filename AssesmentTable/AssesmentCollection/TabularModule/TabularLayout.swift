//
//  AssesmentCollecionLayout.swift
//  AssesmentTable
//
//  Created by Manikandan R on 07/11/17.
//  Copyright © 2017 Y Media Labs. All rights reserved.
//

import UIKit

class TabularLayout: UICollectionViewLayout {
    
    typealias TitleAttributeHandler = (_ indexPath: IndexPath) -> (title: String?, font: UIFont)
    
    // MARK: - Variables
    var numberOfColumns = 0
    var numberOfStaticColumns: Int = 0
    var numberOfStaticRows: Int = 0
    var itemAttributes = [[UICollectionViewLayoutAttributes]]()
    var cellTitleAttributes: TabularLayout.TitleAttributeHandler?

    private var itemsWidths: [CGFloat] = []
    private var itemsHeights: [CGFloat] = []
    private var contentSize: CGSize = .zero
    private var contentFont: UIFont = Font.avenirMedium.font(ofSize: 14)
    
    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView, collectionView.numberOfSections != 0 else {
            return
        }
        // Item Attributes will be calculated only once when preparing the layout.
        if itemAttributes.count != collectionView.numberOfSections {
            itemsWidths.removeAll()
            itemsHeights.removeAll()
            generateItemAttributes(collectionView: collectionView)
            return
        }
        
        // This for Loop will be executed to make the Static rows and columns in place.
        for section in 0..<collectionView.numberOfSections {
            for item in 0..<collectionView.numberOfItems(inSection: section) {
                if section > numberOfStaticRows - 1 && item > numberOfStaticColumns - 1 {
                    continue
                }
                guard let attributes = layoutAttributesForItem(at: IndexPath(item: item, section: section)) else {
                    return
                }
                //Step1:
                // First Section of Each Row will remain static if the numberOfStaticRows is more than 0. This condition only applicable for first section.
                if section == 0 && numberOfStaticRows > 0 {
                    var frame = attributes.frame
                    frame.origin.y = collectionView.contentOffset.y + collectionView.contentInset.top
                    attributes.frame = frame
                }
                
                //Step2:
                // First row of every column should remain static if the numberOfStaticColumns is more that 0. This condition only applicable for first rows.
                if item == 0  && numberOfStaticColumns > 0 {
                    var frame = attributes.frame
                    frame.origin.x = collectionView.contentOffset.x + collectionView.contentInset.left
                    attributes.frame = frame
                }
                
                //Step3:
                // If numberOfStaticRows is more than 1. Then keep those Rows in each section static. Keeping the origin.y with the inclusion of previous rows Height.
                if section > 0 && section < numberOfStaticRows {
                    var frame = attributes.frame
                    var height: CGFloat = 0
                    for _ in 0..<section {
                        guard let sectionAttributes = layoutAttributesForItem(at: IndexPath(item: item, section: section - 1)) else { return }
                        height += sectionAttributes.frame.height
                    }
                    frame.origin.y = collectionView.contentOffset.y + collectionView.contentInset.top + height
                    attributes.frame = frame
                }
                
                //  If numberOfStaticColumns is more than 1. Then keep those Section in each Row static. Keeping the origin.x with the inclusion of previous Column Width
                if item > 0 && item < numberOfStaticColumns {
                    var frame = attributes.frame
                    var width: CGFloat = 0
                    for index in 0..<item {
                        guard let sectionAttributes = layoutAttributesForItem(at: IndexPath(item: index, section: section)) else { return }
                        width += sectionAttributes.frame.width
                    }
                    frame.origin.x = collectionView.contentOffset.x + collectionView.contentInset.left + width
                    attributes.frame = frame
                }
            }
        }
        
    }
    
    override var collectionViewContentSize: CGSize {
        return contentSize
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return itemAttributes[indexPath.section][indexPath.row]
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributes = [UICollectionViewLayoutAttributes]()
        for section in itemAttributes {
            let filteredArray = section.filter { obj -> Bool in
                return rect.intersects(obj.frame)
            }
            attributes.append(contentsOf: filteredArray)
        }
        
        return attributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
}

// MARK: - Helpers
extension TabularLayout {
    
    func generateItemAttributes(collectionView: UICollectionView) {
        if itemsWidths.count != numberOfColumns {
            findSizes(collectionView: collectionView)
        }
        var column = 0
        var xOffset: CGFloat = 0
        var yOffset: CGFloat = 0
        var contentWidth: CGFloat = 0
        
        itemAttributes = []
        for section in 0..<collectionView.numberOfSections {
            var sectionAttributes: [UICollectionViewLayoutAttributes] = []
            
            for index in 0..<numberOfColumns {
                let itemWidth = itemsWidths[index]
                let itemHeight = itemsHeights[section]
                
                let indexPath = IndexPath(item: index, section: section)
                
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = CGRect(x: xOffset, y: yOffset, width: itemWidth, height: itemHeight)
                
                if section < numberOfStaticRows && index < numberOfStaticColumns {
                    //numberOfStaticRows,numberOfStaticRows cell should be on top
                    attributes.zIndex = 1024
                } else if section < numberOfStaticRows || index < numberOfStaticColumns {
                    //numberOfStaticRows,numberOfStaticRows should be above other cells
                    attributes.zIndex = 1023
                }
                
                sectionAttributes.append(attributes)
                
                xOffset += itemWidth
                column += 1
                
                if column == numberOfColumns {
                    if xOffset > contentWidth {
                        contentWidth = xOffset
                    }
                    column = 0
                    xOffset = 0
                    yOffset += itemHeight
                }
            }
            itemAttributes.append(sectionAttributes)
        }
        
        if let attributes = itemAttributes.last?.last {
            contentSize = CGSize(width: contentWidth, height: attributes.frame.maxY)
        }
    }

    // MARK: - Find Size
    func findSizes(collectionView: UICollectionView) {
        // Tabular ROWS are Section
        // Tabular columns are Rows.
        for section in 0..<collectionView.numberOfSections {
            var totalContentWidth: CGFloat = 0
            for index in 0..<numberOfColumns {
                let indexPath = IndexPath(item: index, section: section)
                let titleString = cellTitleAttributes?(indexPath).title ?? ""
                let font = cellTitleAttributes?(indexPath).font ?? contentFont
                let widthPadding: CGFloat = 30.0
                let heightPadding: CGFloat = 20.0
                var size = titleString.size(withConstrainedWidth: 300, font: font)
                size.width += widthPadding
                size.height += heightPadding
                // Top padding for first row
                size.height += section == 0 ? 8 : 0
                
                // checking the previous size on the same index of column
                if itemsWidths.count > index {
                    let previousWidth = itemsWidths[index]
                    let maxSize = max(size.width, previousWidth)
                    totalContentWidth += maxSize
                    // Adjust the last item to fill the rest of the screen.
                    if index == numberOfColumns - 1 {
                        if totalContentWidth < collectionView.bounds.size.width {
                            size.width += collectionView.bounds.size.width - totalContentWidth
                        }
                    }
                    itemsWidths[index] = max(size.width, previousWidth)
                } else {
                    itemsWidths.append(size.width)
                }

                // Checking the height of previous row of every rows.
                if itemsHeights.count > section {
                    let previousHeight = itemsHeights[section]
                    itemsHeights[section] = max(size.height, previousHeight)
                } else {
                    itemsHeights.append(size.height)
                }
            }
        }
    }
    
}
