//
//  MainViewController.swift
//  MovieTest
//
//  Created by phanthanhtung on 03/09/2023.
//

import UIKit

class MainViewController: UIViewController, XibViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tblMovies: UITableView!
    
    // MARK: - Variable
    private let cellIdentifier = "ItemMovieCell"
    private let viewModel = MainViewModel(repository: MovieData(), userDefault: UserDefaults.standard)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllMoviesData()
        setupView()
    }
    
    func getAllMoviesData() {
        Task {
            await viewModel.getAllMovies()
        }
    }
    
    func setupView() {
        navigationItem.backButtonTitle = "Movie"
        navigationController?.navigationBar.tintColor = .gray
        tblMovies.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tblMovies.dataSource = self
        tblMovies.delegate = self
        viewModel.reloadDataEvent = { [weak self] in
            DispatchQueue.main.async {
                self?.tblMovies.reloadData()
            }
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sort", style: .done, target: self, action: #selector(sortListMovies))
    }
    
    @objc func sortListMovies() {
        let alert = UIAlertController(title: "Sort Movies", message: "Choose style sort movie?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Title", style: .default, handler: { [weak self] _ in
            self?.viewModel.sortMovies(type: .title)
        }))
        alert.addAction(UIAlertAction(title: "Release Date", style: .default, handler: { [weak self] _ in
            self?.viewModel.sortMovies(type: .releaseDate)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            
        }))
        self.present(alert, animated: true)
    }

}

// MARK: - TableView Datasource & Delegate

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemMovieViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let itemCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ItemMovieCell else {
            return UITableViewCell()
        }
        itemCell.setData(viewModel: viewModel.itemMovieViewModels[indexPath.row])
        return itemCell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailVC = DetailViewController.create()
        detailVC.movie = self.viewModel.getMovie(indexPath: indexPath)
        detailVC.didUpdateMovieWatchList = { [weak self] movieId in
            self?.viewModel.reloadMovie(id: movieId)
        }
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
