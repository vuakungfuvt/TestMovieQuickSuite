//
//  ItemMovieViewModel.swift
//  MovieTest
//
//  Created by phanthanhtung on 03/09/2023.
//

import UIKit
import RswiftResources

class ItemMovieViewModel: NSObject {
    var title: String
    var detailInfor: String
    var isOnWatchList: Bool
    let image: ImageResource
    
    init(movie: Movie) {
        let date = movie.releaseDate.toDate(format: "dd MMMM yyyy") ?? Date()
        let year = Calendar.current.component(.year, from: date)
        self.title = "\(movie.title)(\(year))"
        let genreString = movie.genres.joined(separator: ", ")
        self.detailInfor = "\(movie.duration) - \(genreString)"
        self.isOnWatchList = true
        self.image = movie.image
    }
}
