# UIColectionView - Customization

![imagen](../master/Sketch/ScreenFlow.gif)


## Moving cells  

```swift

override func viewDidLoad() {
		super.viewDidLoad()
	...
    installsStandardGestureForInteractiveMovement = true
    
}

override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {}


```

## Subclassing Collection view layout
animation add or delete cell  

```swift

class FlowLayout: UICollectionViewFlowLayout {

  ...

  // For Adding Cells:
  override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {}

  // For removing Cells:
  override func finalLayoutAttributesForDisappearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {}

}
```

## Enhance section headers
1. Create a new instance of Section for each section  
2. Update sectionHeader to use the section object  
3. Update the Section Header in the storyboard.  


## Multiple sections

```swift
  // custom header view cell
  class SectionHeader: UICollectionReusableView {}

  class MainViewController: UICollectionViewController {
  ...
  
    // Multiple sections
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
      return dataSource.numberOfSections
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
      
      // show the header uiview
      if let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as? SectionHeader{
        
        let section = Section()
        section.title = dataSource.titleForSectionAtIndexPath(indexPath)
        section.count = dataSource.numberOfParksInSection(indexPath.section)
        view.section = section
        
        return view
      }
      
      return UICollectionReusableView()
      
    }
  }

```
