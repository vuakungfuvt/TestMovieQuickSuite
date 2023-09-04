//
//  DetailViewController.swift
//  MovieTest
//
//  Created by phanthanhtung on 03/09/2023.
//

import UIKit

class DetailViewController: UIViewController, XibViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var imvMovie: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblCurrentRate: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblReleseDate: UILabel!
    @IBOutlet weak var lblGenres: UILabel!
    @IBOutlet weak var lblAddToWatchList: UILabel!
    
    // MARK: - Variable
    var movie: Movie? {
        didSet {
            viewModel.setData(movie: self.movie)
        }
    }
    private var viewModel: DetailViewModel = DetailViewModel(userDefault: UserDefaults.standard)
    var didUpdateMovieWatchList: ((_ movieId: Int) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initData()
        viewModel.didUpdateWatchList = { [weak self] isOnWatchList in
            self?.setLabelWatchList(isOnWatchList: isOnWatchList)
            self?.didUpdateMovieWatchList?((self?.movie?.id)!)
        }
    }
    
    func initData() {
        lblTitle.text = viewModel.getTitleMovie()
        lblGenres.text = viewModel.getGenres()
        lblDescription.text = viewModel.getDescription()
        lblReleseDate.text = viewModel.getReleaseDate()
        lblCurrentRate.text = viewModel.getRating()
        imvMovie.image = viewModel.getImageMovie()
        setLabelWatchList(isOnWatchList: viewModel.isOnWatchList())
    }
    
    func setLabelWatchList(isOnWatchList: Bool) {
        lblAddToWatchList.text = isOnWatchList ? "REMOVE FROM WATCHLIST" : "+ ADD TO WATCHLIST"
    }
    
    // MARK: Actions
    
    @IBAction func btnAddWatchListTouchUpInside(_ sender: Any) {
        viewModel.addToWatchList()
    }
    
    @IBAction func btnWatchTrailerTouchUpInside(_ sender: Any) {
        guard let url = viewModel.getUrlPreview() else {
            return
        }
        UIApplication.shared.openURL(url)
    }
    
}
