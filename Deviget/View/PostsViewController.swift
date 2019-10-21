//
//  PostsViewController.swift
//  Deviget
//
//  Created by Fernando Gallo on 21/10/19.
//  Copyright © 2019 Fernando Gallo. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController {
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: PostsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        getPosts()
    }
    
    
    // MARK: - Setup
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    // MARk: - API
    
    private func getPosts() {
        activityIndicatorView.startAnimating()
        viewModel.fetchPosts()
    }

}


// MARK: - UITableView DataSource

extension PostsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfPosts()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: Implement Post Cell
        return UITableViewCell()
    }
    
}


// MARK: - UITableView Delegate

extension PostsViewController: UITableViewDelegate {
    
}
