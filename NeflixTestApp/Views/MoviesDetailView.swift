//
//  File.swift
//  NeflixTestApp
//
//  Created by Martin Flores Alvarez on 17/08/22.
//


import UIKit
import Nuke
import NukeUI

class MoviesDetailView: UIView {
  
  private enum Constants {
    static let contentViewCornerRadius: CGFloat = 20.0
    static let imageHeight: CGFloat = 50
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
    label.numberOfLines = 0
    label.textColor = UIColor.textMainColorApp
    label.font = label.font.withSize(12)
    return label
  }()
  let languajeLabel: UILabel = {
    let label = UILabel(frame: .zero)
    label.textAlignment = .left
    label.numberOfLines = 0
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
    layer.cornerRadius = Constants.contentViewCornerRadius
    backgroundColor = UIColor.gray
    
    addSubview(posterImageView)
    addSubview(title)
    addSubview(releaseDateLabel)
    addSubview(voteAverageLabel)
    addSubview(overviewLabel)
    addSubview(languajeLabel)

  }
  
  private func setupLayouts() {
    
    posterImageView.translatesAutoresizingMaskIntoConstraints = false
    title.translatesAutoresizingMaskIntoConstraints = false
    releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
    voteAverageLabel.translatesAutoresizingMaskIntoConstraints = false
    overviewLabel.translatesAutoresizingMaskIntoConstraints = false
    languajeLabel.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
      posterImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
      posterImageView.topAnchor.constraint(equalTo: topAnchor),
      posterImageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight)
    ])
    
    NSLayoutConstraint.activate([
      title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.horizontalPadding),
      title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.horizontalPadding),
      title.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 70)
    ])
    
    NSLayoutConstraint.activate([
      releaseDateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.horizontalPadding),
      releaseDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.horizontalPadding),
      releaseDateLabel.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10)
    ])
    
    NSLayoutConstraint.activate([
      voteAverageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.horizontalPadding),
      voteAverageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.horizontalPadding),
      voteAverageLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: -18)
    ])
    
    NSLayoutConstraint.activate([
      overviewLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.horizontalPadding),
      overviewLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.horizontalPadding),
      overviewLabel.topAnchor.constraint(equalTo: voteAverageLabel.bottomAnchor, constant: 10)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  
  func setup(with movie: MoviesDetail) {
    Nuke.loadImage(with: "https://image.tmdb.org/t/p/w220_and_h330_face\(movie.poster_path ?? "")", into: posterImageView)
        
    if ((movie.title?.isEmpty) != nil){
      title.text = movie.title
    }else{
      title.text = movie.name
    }
    
    
    overviewLabel.text = movie.overview
    releaseDateLabel.text = "\(movie.release_date ?? "") / \( movie.original_language ?? "")"
    voteAverageLabel.text = "👍 \(movie.vote_count) |★ \(movie.vote_average)"
    languajeLabel.text = movie.original_language
    
  }
}



