//
//  ItemMovieCell.swift
//  MovieTest
//
//  Created by phanthanhtung on 03/09/2023.
//

import UIKit

protocol ItemMovieCellDelegate: NSObject {
    func didTapAddOnWatchListEvent(cell: UITableViewCell)
}

class ItemMovieCell: UITableViewCell {
    
    // MARK: - Variables
    @IBOutlet weak var imvMovie: UIImageView!
    @IBOutlet weak var btnAddOnWatchList: UIButton!
    @IBOutlet weak var viewWatchList: UIView!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    weak var delegate: ItemMovieCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(viewModel: ItemMovieViewModel) {
        self.imvMovie.image = UIImage(named: viewModel.image.name)
        self.lblTitle.text = viewModel.title
        self.lblDetail.text = viewModel.detailInfor
        self.viewWatchList.isHidden = !viewModel.isOnWatchList
    }
    
    @IBAction func btnAddWatchListTouchUpInside(_ sender: Any) {
    }
}
