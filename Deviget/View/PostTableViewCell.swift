//
//  PostTableViewCell.swift
//  Deviget
//
//  Created by Fernando Gallo on 21/10/19.
//  Copyright © 2019 Fernando Gallo. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeAgoLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    
    static let cellIdentifier = "PostCell"
    
    var viewModel: PostCellViewModel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        thumbnailImageView.layer.cornerRadius = 4.0
        thumbnailImageView.clipsToBounds = true
    }

    func configure() {
        authorLabel.text = viewModel.author
        titleLabel.text = viewModel.title
        timeAgoLabel.text = viewModel.createdTime
        commentsLabel.text = viewModel.numberOfComments
    }
    
}

extension PostTableViewCell: FetchImageDelegate {
    
    func fetchImageSuccess(_ image: UIImage) {
        thumbnailImageView.image = image
    }
    
}
