//
//  Moviesl.swift
//  NeflixTestApp
//
//  Created by Martin Flores Alvarez on 16/08/22.
//

import Foundation

struct Movies: Codable{
  let page: Int
  let results: [results_movies]
  
  enum CodingKeysMovies: String, CodingKey {
    case results_movies = "results"
  }
}


struct results_movies: Codable {
  let poster_path:String
  let adult: Bool?
  let overview:String
  let release_date: String?
  let genre_ids:[results_movies_genre]
  let id: Int
  let original_title:String?
  let original_language: String
  let title:String?
  let popularity: Double
  let vote_count: Int
  let video: Bool?
  let vote_average: Double
  //TV properties
  let name: String?
  let first_air_date: String?
  
  
  enum CodingKeysMovies: String, CodingKey {
    case poster_path = "poster_path"
    case adult = "adult"
    case overview = "overview"
    case release_date = "release_date"
    case genre_ids = "genre_ids"
    case id = "id"
    case original_title = "original_title"
    case original_language = "original_language"
    case title = "title"
    case popularity = "popularity"
    case vote_count = "vote_count"
    case video = "video"
    case vote_average = "vote_average"
    //TV properties
    case name = "name"
    case first_air_date = "first_air_date"

  }
}

struct results_movies_genre: Codable {

}

