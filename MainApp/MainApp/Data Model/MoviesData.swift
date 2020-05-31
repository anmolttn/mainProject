//
//  TrendingMovies.swift
//  MainApp
//
//  Created by Anmol Chauhan on 20/05/20.
//  Copyright © 2020 Anmol Chauhan. All rights reserved.
//

import Foundation

struct MoviesData : Codable {
    let page : Int?
    let results : [MovieResultModel]?
    let totalPages : Int?
    let totaResults : Int?
}

struct MovieResultModel: Codable {
    
    var popularity: Float?
    var vote_count: Int?
    var video: Bool?
    var vote_average: Float?
    var title: String?
    var release_date: String?
    var original_language: String?
    var original_title: String?
    var backdrop_path: String?
    var adult: Bool?
    var poster_path: String?
    var id: Int?
    var overview: String?
    var original_name: String?
    var media_type: String?
    var first_air_date: String?
}
