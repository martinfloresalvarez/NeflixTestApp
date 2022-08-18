//
//  MoviesDetail.swift
//  NeflixTestApp
//
//  Created by Martin Flores Alvarez on 18/08/22.
//

import Foundation

struct MoviesDetail: Codable{
  let adult: Bool
  let backdrop_path: String?
  let belongs_to_collection: results_belong?
  let budget: Int?
  let genres: [results_genres]
  let homepage: String
  let id: Int
  let imdb_id: String?
  let original_language: String?
  let original_title: String?
  let overview: String?
  let popularity: Double?
  let poster_path: String?
  let production_companies: [results_production_companies]
  let production_countries: [results_production_countries]
  let release_date: String?
  let revenue: Int?
  let runtime: Int?
  let spoken_languages: [results_spoken_languages]  
  let status: String?
  let tagline: String?
  let title: String?
  let name: String?
  let video:Bool?
  let vote_average:Double
  let vote_count:Int  
  
  enum CodingKeysMoviesDetail: String, CodingKey {
    case adult = "adult"
    case backdrop_path = "backdrop_path"
    case belongs_to_collection = "belongs_to_collection"
    case budget = "budget"
    case genres = "genres"
    case homepage = "homepage"
    case id = "id"
    case imdb_id = "imdb_id"
    case original_language = "original_language"
    case original_title = "original_title"
    case overview = "overview"
    case popularity = "popularity"
    case poster_path = "poster_path"
    case production_companies = "production_companies"
    case production_countries = "production_countries"
    case release_date = "release_date"
    case revenue = "revenue"
    case runtime = "runtime"
    case spoken_languages = "spoken_languages"
    case status = "status"
    case tagline = "tagline"
    case title = "title"
    case name = "name"

    case video = "video"
    case vote_average = "vote_average"
    case vote_count = "vote_count"

  }
}

struct results_belong: Codable {
  let id:Int
  let name:String
  let poster_path:String
  let backdrop_path:String
  enum CodingKeysGenres: String, CodingKey {
    case id = "id"
    case name = "name"
    case poster_path = "poster_path"
    case backdrop_path = "backdrop_path"
  }
}


struct results_genres: Codable {
  
  let id:Int
  let name:String

  enum CodingKeysGenres: String, CodingKey {
    case id = "id"
    case name = "name"
  }
}

struct results_production_companies: Codable {
  
  let id:Int
  let name:String
  let logo_path:String?
  let origin_country:String

  enum CodingKeysCompanies: String, CodingKey {
    case id = "id"
    case name = "name"
    case logo_path = "logo_path"
    case origin_country = "origin_country"

  }
}

struct results_production_countries: Codable {
  
  let iso_3166_1:String
  let name:String
 
  enum CodingKeysCountries: String, CodingKey {
    case iso_3166_1 = "id"
    case name = "name"
  }
}


struct results_spoken_languages: Codable {
  
  let iso_639_1:String
  let name:String
 
  enum CodingKeysLanguajes: String, CodingKey {
    case iso_639_1 = "id"
    case name = "name"
  }
}







