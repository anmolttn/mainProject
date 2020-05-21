//
//  TrendingMovies.swift
//  MainApp
//
//  Created by Anmol Chauhan on 20/05/20.
//  Copyright © 2020 Anmol Chauhan. All rights reserved.
//

import Foundation

struct TrendingMovies : Codable {
    let id : Int?
    let video : Bool?
    let voteCount : Int?
    let voteAverage : Double?
    let title : String?
    let releaseDate : String?
    let originalLanguage : String?
    let originalTitle : String?
    let genreIds : [Int]?
    let backdropPath : String?
    let adult : Bool?
    let overview : String?
    let posterPath : String?
    let popularity : Double?
    let mediaType : String?
    
    enum CodingKeys: String, CodingKey {

        case id = "id"
        case video = "video"
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case title = "title"
        case releaseDate = "release_date"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIds = "genre_ids"
        case backdropPath = "backdrop_path"
        case adult = "adult"
        case overview = "overview"
        case posterPath = "poster_path"
        case popularity = "popularity"
        case mediaType = "media_type"
    }
}


struct MoviesData : Codable {
    let page : Int?
    let results : [TrendingMovies]?
    let totalPages : Int?
    let totaResults : Int?

    enum CodingKeys: String, CodingKey {

        case page = "page"
        case results = "results"
        case totalPages = "total_pages"
        case totaResults = "total_results"
    }
}
