import UIKit

class DataSource {
	private var parks = [Park]()
	private var immutableParks = [Park]()  // reference to delete or request others
	private var sections = [String]()
	
	var count: Int {
		return parks.count
	}
	
	var numberOfSections: Int {
		return sections.count
	}
	
	// MARK:- Public
	init() {
		parks = loadParksFromDisk()
		immutableParks = parks
	}
	// index path for the collection view
	func deleteItemsAtIndexPaths(_ indexPaths: [IndexPath]) {
		var indexes = [Int]()
		for indexPath in indexPaths {
			indexes.append(absoluteIndexForIndexPath(indexPath)) // indexPath = 0,4
		}
		var newParks = [Park]()
		for (index, park) in parks.enumerated() {  // objetcs of parks
			if !indexes.contains(index) {  // match  indexPath  == index of park
				newParks.append(park)  // new arrrays of park
			}
		}
		parks = newParks
	}
  
  private func absoluteIndexForIndexPath(_ indexPath: IndexPath) -> Int {
    var index = 0
    for i in 0..<indexPath.section {
      index += numberOfParksInSection(i)  // get items of the section
    }
    index += indexPath.item
    return index
  }
  
  func numberOfParksInSection(_ index: Int) -> Int {
    let nationalParks = parksForSection(index)
    return nationalParks.count
  }
  
  
	
	func moveParkAtIndexPath(_ indexPath: IndexPath, toIndexPath newIndexPath: IndexPath) {
		if indexPath == newIndexPath {
			return
		}
		let index = absoluteIndexForIndexPath(indexPath)
		let nationalPark = parks[index]
		nationalPark.state = sections[newIndexPath.section]
		let newIndex = absoluteIndexForIndexPath(newIndexPath)
		parks.remove(at: index)
		parks.insert(nationalPark, at: newIndex)
	}
	
	func newRandomPark() -> IndexPath {
		let index = Int.random(in: 0...immutableParks.count - 1)
		let parkToCopy = immutableParks[index]
		let newPark = Park(copying: parkToCopy)
		parks.append(newPark)
		return IndexPath(row: parks.count - 1, section: 0)
	}
	
	func indexPathForNewRandomPark() -> IndexPath {
		let index = Int.random(in: 0...immutableParks.count - 1)
		let parkToCopy = immutableParks[index]
		let newPark = Park(copying: parkToCopy)
		parks.append(newPark)
		parks.sort { $0.index < $1.index }
		return indexPathForPark(newPark)
	}
	
	func indexPathForPark(_ park: Park) -> IndexPath {
		let section = sections.index(of: park.state)!
		var item = 0
		for (index, currentPark) in parksForSection(section).enumerated() {
			if currentPark === park {
				item = index
				break
			}
		}
		return IndexPath(item: item, section: section)
	}
	
	
	
	func parkForItemAtIndexPath(_ indexPath: IndexPath) -> Park? {
		if indexPath.section > 0 {
			let arrNationalParks = parksForSection(indexPath.section)
			return arrNationalParks[indexPath.item]
		}
    else {
      // section = 0
			return parks[indexPath.item]
		}
	}
  
  private func parksForSection(_ index: Int) -> [Park] {
    let strSection = sections[index]
   
    // get parks which match with the strSection
    let parksInSection = parks.filter { (park: Park) -> Bool in
      return park.state == strSection
    }
    return parksInSection
  }
	
	func titleForSectionAtIndexPath(_ indexPath: IndexPath) -> String? {
		if indexPath.section < sections.count {
			return sections[indexPath.section]
		}
		return nil
	}
	
	
	// MARK:- Private
	private func loadParksFromDisk() -> [Park] {
		sections.removeAll(keepingCapacity: false)
		if let path = Bundle.main.path(forResource: "NationalParks", ofType: "plist") {
			if let dictArray = NSArray(contentsOfFile: path) {
				var nationalParks: [Park] = []
				for item in dictArray {
					if let dict = item as? NSDictionary {
						let name = dict["name"] as! String
						let state = dict["state"] as! String
						let date = dict["date"] as! String
						let photo = dict["photo"] as! String
						let index = dict["index"] as! Int
						let park = Park(name: name, state: state, date: date, photo: photo, index: index)
						if !sections.contains(state) {
							 sections.append(state)
						}
						nationalParks.append(park)
					}
				}
				return nationalParks
			}
		}
		return []
	}
	
	
	
	
}
