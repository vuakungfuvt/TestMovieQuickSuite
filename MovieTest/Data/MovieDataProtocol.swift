//
//  Movie.swift
//  MovieTest
//
//  Created by phanthanhtung on 03/09/2023.
//

import Foundation

protocol MovieDataProtocol {
    func getAllMovies() async -> [Movie]
    func addOnWatchList(movieId: Int, isOnWatchList: Bool)
}
