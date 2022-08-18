//
//  File.swift
//  NeflixTestApp
//
//  Created by Martin Flores Alvarez on 17/08/22.
//


import UIKit
import Nuke
import NukeUI

protocol ReusableMovieProviderView: AnyObject {
  static var identifier: String { get }
}

final class MoviesProvidersViewControllerCell: UICollectionViewCell {
  
  private enum Constants {
    static let imageHeight: CGFloat = 110
    static let horizontalPadding: CGFloat = 6
  }
  
  private let providerImageView: UIImageView = {
    let imageView = UIImageView(frame: .zero)
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  let providerNameLabel: UILabel = {
    let label = UILabel(frame: .zero)
    label.textAlignment = .center
    label.numberOfLines = 0
    label.textColor = UIColor.primaryGreenColor
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

    contentView.backgroundColor = UIColor.moviesCollectionViewCell
    
    contentView.addSubview(providerImageView)
    contentView.addSubview(providerNameLabel)
    
  }
  
  private func setupLayouts() {
    providerImageView.translatesAutoresizingMaskIntoConstraints = false
    providerNameLabel.translatesAutoresizingMaskIntoConstraints = false
   

    NSLayoutConstraint.activate([
      providerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      providerImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      providerImageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
      providerImageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight)
    ])
    
    NSLayoutConstraint.activate([
      providerNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.horizontalPadding),
      providerNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.horizontalPadding),
      providerNameLabel.topAnchor.constraint(equalTo: providerImageView.bottomAnchor, constant: 5)
    ])
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setup(with provider: results_providers) {
    
    Nuke.loadImage(with: "https://image.tmdb.org/t/p/w500\(provider.logo_path)", into: providerImageView)
      providerNameLabel.text = provider.provider_name
      
  }
}


extension MoviesProvidersViewControllerCell: ReusableMovieProviderView {
  static var identifier: String {
    return String(describing: self)
  }
}
