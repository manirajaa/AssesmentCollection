# AssesmentCollection
Collection view which scrolls both horizontal and vertical

![alt text](https://github.com/manirajaa/AssesmentCollection/blob/master/Simulator%20Screen%20Shot%20-%20iPhone%208%20Plus%20-%202018-02-22%20at%2015.06.38.png?raw=true)

## Usage

Add the following files into your project:

*  TabularCollectionView.swift
*  TabularCollectionCell.swift
*  TabularCollectionCell.xib
*  TabularLayout.swift
*  String+Utility.swift
*  Color.swift
*  Font.swift


Add the below reference to your view controller
```ObjC
@IBOutlet weak var collectionView: AssesmentCollectionView!
```

Inherit "TabularCollectionDataSource" &  "TabularCollectionDelegate" to customize the collection view.

To set the Title Attributes use this method
```ObjC
func tabularView(_ tabularView: TabularCollectionView, titleAttributesForCellAt indexPath: IndexPath) -> CellTitleAttributes
```
Create your Data and give How many number of Columns needed
```ObjC
func numberOfColumns(in tabularView: TabularCollectionView) -> Int
```

Create your Data and give How many number of Rows needed
```ObjC
func numberOfRows(in tabularView: TabularCollectionView) -> Int
```
Mention how many number of static rows you want to keep
```ObjC
func numberOfStaticRows(in tabularView: TabularCollectionView) -> Int
```

Mention how many number of static Column you want to keep
```ObjC
func numberOfStaticColumn(in tabularView: TabularCollectionView) -> Int
```

## Swift version
* Swift 4.0

## Refeference
Thanks to [Brightec Team](https://www.brightec.co.uk/ideas/uicollectionview-using-horizontal-and-vertical-scrolling-sticky-rows-and-columns)


## License

AssesmentCollection is available under the MIT license. See the LICENSE file for more info.


