//
//  Movie.swift
//  MovieTest
//
//  Created by phanthanhtung on 03/09/2023.
//

import Foundation
import RswiftResources

struct Movie {
    let id: Int
    let title: String
    let description: String
    let rating: Double
    let duration: String
    let genres: [String]
    let releaseDate: String
    let trailerLink: String
    let image: ImageResource
    
    var isOnWatchedList: Bool = false
}
