//
//  DetailViewModel.swift
//  MovieTest
//
//  Created by phanthanhtung on 03/09/2023.
//

import UIKit

class DetailViewModel: NSObject {
    
    private var movie: Movie?
    private var userDefault: UserDefaults?
    var didUpdateWatchList: ((_ isOnWatchList: Bool) -> Void)?
    
    init(userDefault: UserDefaults) {
        self.userDefault = userDefault
    }
    
    func setData(movie: Movie?) {
        self.movie = movie
    }
    
    func getTitleMovie() -> String? {
        return movie?.title
    }
    
    func getImageMovie() -> UIImage? {
        return UIImage(named: movie?.image.name ?? "")
    }
    
    func getDescription() -> String? {
        return movie?.description
    }
    
    func getGenres() -> String? {
        return movie?.genres.joined(separator: ", ")
    }
    
    func getReleaseDate() -> String? {
        return movie?.releaseDate
    }
    
    func getRating() -> String {
        return "\(movie?.rating ?? 0)"
    }
    
    func isOnWatchList() -> Bool {
        let key = "\(movie?.id ?? 1)"
        return userDefault?.bool(forKey: key) ?? false
    }
    
    func getUrlPreview() -> URL? {
        return URL(string: movie?.trailerLink ?? "")
    }
    
    func addToWatchList() {
        let key = "\(movie?.id ?? 1)"
        let isOnWatchList = userDefault?.bool(forKey: key) ?? false
        userDefault?.set(!isOnWatchList, forKey: key)
        self.didUpdateWatchList?(!isOnWatchList)
    }
}
