//
//  PostDetailsViewController.swift
//  Deviget
//
//  Created by Fernando Gallo on 21/10/19.
//  Copyright © 2019 Fernando Gallo. All rights reserved.
//

import UIKit

class PostDetailsViewController: UIViewController {
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeAgoLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    
    var viewModel: PostDetailsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupPostFields() {
        authorLabel.text = viewModel.postAuthor()
        titleLabel.text = viewModel.postTitle()
        timeAgoLabel.text = viewModel.postTimeAgo()
    }

}


// MARK: - PostDetailsDelegate

extension PostDetailsViewController: PostDetailsDelegate {
    
    func refreshPostDetails() {
        setupPostFields()
    }
    
}
