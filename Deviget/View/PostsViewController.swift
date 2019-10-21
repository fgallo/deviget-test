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
        setupView()
        setupTableView()
        getPosts()
    }
    
    
    // MARK: - Setup
    
    private func setupView() {
        title = "Reddit Posts"
        tableView.isHidden = true
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: String(describing: PostTableViewCell.self), bundle: nil),
                           forCellReuseIdentifier: PostTableViewCell.cellIdentifier)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.cellIdentifier,
                                                 for: indexPath) as! PostTableViewCell
        cell.viewModel = viewModel.viewModelForRowAt(indexPath: indexPath)
        cell.viewModel.delegate = cell
        cell.configure()
        return cell
    }
    
}


// MARK: - UITableView Delegate

extension PostsViewController: UITableViewDelegate {
    
}


// MARK: - FetchPostsDelegate

extension PostsViewController: FetchPostsDelegate {
    
    func fetchPostsSuccess() {
        activityIndicatorView.stopAnimating()
        tableView.isHidden = false
        tableView.reloadData()
    }
    
    func fetchPostsFailure() {
        activityIndicatorView.stopAnimating()
    }
    
}
