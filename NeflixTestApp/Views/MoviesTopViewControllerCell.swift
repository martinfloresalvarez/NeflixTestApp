//
//  File.swift
//  NeflixTestApp
//
//  Created by Martin Flores Alvarez on 17/08/22.
//


import UIKit

protocol ReusableMovieTopView: AnyObject {
  static var identifier: String { get }
}

final class MoviesTopViewControllerCell: UICollectionViewCell {
  
  private enum Constants {
    static let contentViewCornerRadius: CGFloat = 5
    static let horizontalPadding: CGFloat = 6
  }

  
  let title: UILabel = {
    let label = UILabel(frame: .zero)
    label.textAlignment = .left
    label.numberOfLines = 0
    label.textColor = UIColor.titleNavigationBar
    label.font = label.font.withSize(14)
    return label
  }()

  
  override init(frame: CGRect) {
    super.init(frame: .zero)
    setupViews()
    setupLayouts()
  }
  
  private func setupViews() {
    contentView.clipsToBounds = true
    contentView.layer.cornerRadius = Constants.contentViewCornerRadius
    contentView.backgroundColor = UIColor.categoriesMainBackground
    
    contentView.addSubview(title)

  }
  
  private func setupLayouts() {
    title.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      NSLayoutConstraint(item: title, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1, constant: 0),
      NSLayoutConstraint(item: title, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1, constant: 0)
      
    ])

  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setup(with categoria: results) {
    title.text = "\(categoria.name)"
  }
}


extension MoviesTopViewControllerCell: ReusableMovieTopView {
  static var identifier: String {
    return String(describing: self)
  }
}
