//
//  AssesmentCollecionLayout.swift
//  AssesmentTable
//
//  Created by Manikandan r on 07/11/17.
//  Copyright © 2017 Manikandan r. All rights reserved.
//


import UIKit

class AssesmentCollecionLayout: UICollectionViewLayout {
    
    // MARK: - Variables
    var numberOfColumns = 0
    var numberOfStaticColumns:Int = 0
    var numberOfStaticRows:Int = 0

    var itemAttributes = [[UICollectionViewLayoutAttributes]]()
    
    private var itemSizeArray = [CGSize]()
    private var contentSize: CGSize = .zero
    private var contentFont:UIFont = Font.AvenirMedium.font()
    
    var cellTitleAttributes: ((_ indexPath: IndexPath) -> (title:String,font:UIFont))?
    
}
    //MARK: -
extension AssesmentCollecionLayout {
    
    override func prepare() {
        guard let collectionView = collectionView else {
            return
        }
        
        if collectionView.numberOfSections == 0 {
            return
        }
        
        if itemAttributes.count != collectionView.numberOfSections {
            generateItemAttributes(collectionView: collectionView)
            return
        }
        
        for section in 0..<collectionView.numberOfSections {
            for item in 0..<collectionView.numberOfItems(inSection: section) {
                if section > numberOfStaticRows - 1 && item > numberOfStaticColumns - 1 {
                    continue
                }
                let attributes = layoutAttributesForItem(at: IndexPath(item: item, section: section))!
                if section == 0 && numberOfStaticRows > 0 {
                    var frame = attributes.frame
                    frame.origin.y = collectionView.contentOffset.y + collectionView.contentInset.top
                    attributes.frame = frame
                }
                
                if item == 0  && numberOfStaticColumns > 0 {
                    var frame = attributes.frame
                    frame.origin.x = collectionView.contentOffset.x + collectionView.contentInset.left
                    attributes.frame = frame
                }
                
                if section > 0 && section < numberOfStaticRows {
                    var frame = attributes.frame
                    var height:CGFloat = 0
                    for _ in 0..<section {
                        let sectionAttributes = layoutAttributesForItem(at: IndexPath(item: item, section: section - 1))!
                        height += sectionAttributes.frame.height
                    }
                    frame.origin.y = collectionView.contentOffset.y + collectionView.contentInset.top + height
                    attributes.frame = frame
                }
                
                if item > 0 && item < numberOfStaticColumns {
                    var frame = attributes.frame
                    var width:CGFloat = 0
                    for index in 0..<item {
                        let sectionAttributes = layoutAttributesForItem(at: IndexPath(item: index, section: section))!
                        width += sectionAttributes.frame.width
                    }
                    frame.origin.x = collectionView.contentOffset.x + collectionView.contentInset.left + width //sectionAttributes.frame.width
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
extension AssesmentCollecionLayout {
    
    func generateItemAttributes(collectionView: UICollectionView) {
        if itemSizeArray.count != numberOfColumns {
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
                let itemWidth = itemSizeArray[index]

                
                let indexPath = IndexPath(item: index, section: section)
                
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = CGRect(x: xOffset, y: yOffset, width: itemWidth.width, height: itemWidth.height)
                
                if section < numberOfStaticRows && index < numberOfStaticColumns {
                    //numberOfStaticRows,numberOfStaticRows cell should be on top
                    attributes.zIndex = 1024
                } else if section < numberOfStaticRows || index < numberOfStaticColumns {
                    //numberOfStaticRows,numberOfStaticRows should be above other cells
                    attributes.zIndex = 1023
                }
                
                sectionAttributes.append(attributes)
                
                xOffset += itemWidth.width
                column += 1
                
                if column == numberOfColumns {
                    if xOffset > contentWidth {
                        contentWidth = xOffset
                    }
                    column = 0
                    xOffset = 0
                    yOffset += itemWidth.height
                }
            }
            itemAttributes.append(sectionAttributes)
        }
        
        if let attributes = itemAttributes.last?.last {
            contentSize = CGSize(width: contentWidth, height: attributes.frame.maxY)
        }
    }
    
    func sizeForString(_ text:String,_ font:UIFont) -> CGSize {
        let size: CGSize = text.size(withAttributes: [NSAttributedStringKey.font: font])
        let width: CGFloat = size.width + 50
        return CGSize(width: width, height: size.height + 20)
    }
    
    //MARK:- Find Size
    func findSizes(collectionView: UICollectionView) {
        for section in 0..<collectionView.numberOfSections {
            for index in 0..<numberOfColumns {
                let indexPath = IndexPath(item: index, section: section)
                let titleString = cellTitleAttributes?(indexPath).title ?? ""
                let font = cellTitleAttributes?(indexPath).font ?? contentFont
                var size = sizeForString(titleString,font)
                
                if itemSizeArray.isEmpty  {
                    itemSizeArray.append(size)
                } else {
                    if itemSizeArray.count > index {
                        let previous_size = itemSizeArray[index]
                        if previous_size.width > size.width {
                            size.width = previous_size.width
                        }
                        if previous_size.height > size.height {
                            size.height = previous_size.height
                        }
                        itemSizeArray[index] = size
                    } else {
                        itemSizeArray.append(size)
                    }
                }
            }
        }
    }
    
}
