//
//  MainViewModel.swift
//  MovieTest
//
//  Created by phanthanhtung on 03/09/2023.
//

import UIKit

enum SortMovieType {
    case title
    case releaseDate
}

class MainViewModel: NSObject {
    private let repository: MovieDataProtocol
    var movies = [Movie]()
    var sortedMovies = [Movie]()
    var itemMovieViewModels = [ItemMovieViewModel]()
    var reloadDataEvent: (() -> Void)?
    var userDefault: UserDefaults?
    
    init(repository: MovieDataProtocol, userDefault: UserDefaults) {
        self.repository = repository
        self.userDefault = userDefault
    }
    
    func getAllMovies() async {
        self.movies = await repository.getAllMovies()
        self.sortedMovies = self.movies
        self.itemMovieViewModels = self.movies.compactMap { ItemMovieViewModel(movie: $0) }
        for index in 0 ..< movies.count {
            self.itemMovieViewModels[index].isOnWatchList = userDefault?.bool(forKey: "\(self.movies[index].id)") ?? false
        }
        self.reloadDataEvent?()
    }
    
    func reloadMovie(id: Int) {
        guard let index = sortedMovies.firstIndex(where: { $0.id == id }) else {
            return
        }
        self.itemMovieViewModels[index].isOnWatchList = userDefault?.bool(forKey: "\(id)") ?? false
        self.reloadDataEvent?()
    }
    
    func getMovie(indexPath: IndexPath) -> Movie {
        return self.sortedMovies[indexPath.row]
    }
    
    func sortMovies(type: SortMovieType) {
        switch type {
        case .title:
            self.sortedMovies = self.movies.sorted(by: { movie1, movie2 in
                return movie1.title.lowercased() < movie2.title.lowercased()
            })
        case .releaseDate:
            self.sortedMovies = self.movies.sorted(by: { movie1, movie2 in
                let date1 = movie1.releaseDate.toDate(format: "DD MMMM YYYY") ?? Date()
                let date2 = movie2.releaseDate.toDate(format: "DD MMMM YYYY") ?? Date()
                return date1 < date2
            })
        }
        self.itemMovieViewModels = self.sortedMovies.compactMap{ ItemMovieViewModel(movie: $0) }
        for index in 0 ..< sortedMovies.count {
            self.itemMovieViewModels[index].isOnWatchList = userDefault?.bool(forKey: "\(self.movies[index].id)") ?? false
        }
        self.reloadDataEvent?()
    }
}
