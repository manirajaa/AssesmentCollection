#  Assesment Collection
Creating the collection view to support both horizontal and vertical scrolling.

## Usage

Add the following files into your project:

* AssesmentCollecionLayout.swift
* AssesmentCollectionView.swift
* AssesmentCollectionCell.swift
* AssesmentCollectionCell.xib


Add the below reference to your view controller
```ObjC
@IBOutlet weak var collectionView: AssesmentCollectionView!
```
Add the Following lines into your code for Customizing the collection view.
```ObjC
collectionView.numberOfStaticRows = 2
collectionView.numberOfStaticColumns = 1
collectionView.columnTitle  = columnTitle
collectionView.rowTitle = rowTitle
collectionView.headerFont = UIFont(name: "Avenir-Heavy", size: 14)!
collectionView.contentFont = UIFont(name: "Avenir-light", size: 14)!
collectionView.showColumnSeperator = true
collectionView.reloadData()
```

## Swift version
* Swift 4.0

## Refeference
Thanks to [Brightec Team](https://www.brightec.co.uk/ideas/uicollectionview-using-horizontal-and-vertical-scrolling-sticky-rows-and-columns)


## Thanks

