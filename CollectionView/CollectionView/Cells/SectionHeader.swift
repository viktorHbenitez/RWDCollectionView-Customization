//
//  SectionHeader.swift
//  CollectionView
//
//  Created by Victor Hugo Benitez Bosques on 8/27/19.
//  Copyright © 2019 Razeware. All rights reserved.
//

import UIKit

class SectionHeader: UICollectionReusableView {
  
  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var flagImage: UIImageView!
  @IBOutlet private weak var countLabel: UILabel!
  
  var section: Section? {
    didSet {
      if let section = section{
        titleLabel.text = section.title
        flagImage.image = UIImage(named: section.title ?? "")
        countLabel.text = "\(section.count)"
      }
    }
  }
  
  var title: String? {
    didSet {
      titleLabel.text = title
    }
  }
  
  
}
