//
//  UiElements.swift
//  NeflixTestApp
//
//  Created by Martin Flores Alvarez on 17/08/22.
//

import UIKit

extension UIButton {
  
  class func NanigationBarButton() -> UIButton {
    let button = UIButton(type: .custom)
    button.setImage(UIImage(systemName: "list.dash"), for: .normal)
    button.frame = CGRect(x: 0, y: 0, width: 53, height: 51)
    button.tintColor = UIColor.iconsGreyColor
    return button
  }
}

extension UILabel {
  
  class func CategoriesLabel(text:String) -> UILabel {
    let titleLabel = UILabel()
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.textColor = UIColor.textMainColorApp
    titleLabel.textAlignment = .center
    titleLabel.numberOfLines = 0;
    titleLabel.text = text
    titleLabel.sizeToFit()
    titleLabel.baselineAdjustment = .alignCenters
    titleLabel.autoresizesSubviews = true
    titleLabel.autoresizingMask = .flexibleWidth
    titleLabel.layer.cornerRadius = 20.0
    titleLabel.layer.masksToBounds = true
    return titleLabel
  }
}


extension UICollectionViewFlowLayout {
  class func CategoriesCollectionLayout() -> UICollectionViewFlowLayout{
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    let width = UIScreen.main.bounds.width
    layout.itemSize = CGSize(width: (width/4)-8, height: 35)
    layout.minimumInteritemSpacing = 0
    layout.minimumLineSpacing = 0
    layout.sectionInset = UIEdgeInsets(top: 10, left: 15, bottom: 0, right: 15)
    return layout
  }
  
  class func MoviesCollectionLayout() -> UICollectionViewFlowLayout{
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    let width = UIScreen.main.bounds.width
    layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 10, right: 5)
    layout.itemSize = CGSize(width: (width/2)-10, height: 350)
    layout.minimumInteritemSpacing = 0
    layout.minimumLineSpacing = 10
    return layout
  }
  class func ProvidersCollectionLayout() -> UICollectionViewFlowLayout{
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    let width = UIScreen.main.bounds.width
    layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 10, right: 5)
    layout.itemSize = CGSize(width: (width/2)-10, height: 150)
    layout.minimumInteritemSpacing = 0
    layout.minimumLineSpacing = 10
    return layout
  }
  
}

extension UIView {
    
}
