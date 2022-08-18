//
//  File.swift
//  NeflixTestApp
//
//  Created by Martin Flores Alvarez on 17/08/22.
//


import UIKit
import Nuke
import NukeUI

protocol ReusableView: AnyObject {
  static var identifier: String { get }
}

final class MoviesViewControllerCell: UICollectionViewCell {
  
  private enum Constants {
    static let contentViewCornerRadius: CGFloat = 4.0
    
    static let imageHeight: CGFloat = 160.0
    
    static let horizontalPadding: CGFloat = 6
  }
  
  private let posterImageView: UIImageView = {
    let imageView = UIImageView(frame: .zero)
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  let title: UILabel = {
    let label = UILabel(frame: .zero)
    label.textAlignment = .left
    label.numberOfLines = 0
    label.textColor = UIColor.primaryGreenColor
    label.font = label.font.withSize(14)
    return label
  }()
  
  let releaseDateLabel: UILabel = {
    let label = UILabel(frame: .zero)
    label.textAlignment = .left
    label.numberOfLines = 0
    label.textColor = UIColor.primaryGreenColor
    label.font = label.font.withSize(14)
    return label
  }()
  
  let voteAverageLabel: UILabel = {
    let label = UILabel(frame: .zero)
    label.textAlignment = .right
    label.textColor = UIColor.primaryGreenColor
    label.font = label.font.withSize(14)
    return label
  }()
  
  let overviewLabel: UILabel = {
    let label = UILabel(frame: .zero)
    label.textAlignment = .left
    label.numberOfLines = 4
    label.textColor = UIColor.textMainColorApp
    label.font = label.font.withSize(12)
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: .zero)
    setupViews()
    setupLayouts()
  }
  
  private func setupViews() {
    contentView.clipsToBounds = true
    contentView.layer.cornerRadius = 20
    contentView.backgroundColor = UIColor.moviesCollectionViewCell
    
    contentView.addSubview(posterImageView)
    contentView.addSubview(title)
    contentView.addSubview(releaseDateLabel)
    contentView.addSubview(voteAverageLabel)
    contentView.addSubview(overviewLabel)
  }
  
  private func setupLayouts() {
    posterImageView.translatesAutoresizingMaskIntoConstraints = false
    title.translatesAutoresizingMaskIntoConstraints = false
    releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
    voteAverageLabel.translatesAutoresizingMaskIntoConstraints = false
    overviewLabel.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      posterImageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight)
    ])
    
    NSLayoutConstraint.activate([
      title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.horizontalPadding),
      title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.horizontalPadding),
      title.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 70)
    ])
    
    NSLayoutConstraint.activate([
      releaseDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.horizontalPadding),
      releaseDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.horizontalPadding),
      releaseDateLabel.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10)
    ])
    
    NSLayoutConstraint.activate([
      voteAverageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.horizontalPadding),
      voteAverageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.horizontalPadding),
      voteAverageLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: -18)
    ])
    
    NSLayoutConstraint.activate([
      overviewLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.horizontalPadding),
      overviewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.horizontalPadding),
      overviewLabel.topAnchor.constraint(equalTo: voteAverageLabel.bottomAnchor, constant: 10)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setup(with movie: results_movies) {
    
    Nuke.loadImage(with: "https://image.tmdb.org/t/p/w220_and_h330_face\(movie.poster_path)", into: posterImageView)
    if ((movie.title?.isEmpty) != nil){
      title.text = movie.title
    }else{
      title.text = movie.name
    }
    if ((movie.release_date?.isEmpty) != nil){
      releaseDateLabel.text = movie.release_date
    }else{
      releaseDateLabel.text = movie.first_air_date
    }
    if (movie.overview.isEmpty){
      overviewLabel.text = "Sin descripcion"
    }else{
      overviewLabel.text = movie.overview
    }
    
    voteAverageLabel.text = "★ \(movie.vote_average)"
  }
}


extension MoviesViewControllerCell: ReusableView {
  static var identifier: String {
    return String(describing: self)
  }
}
