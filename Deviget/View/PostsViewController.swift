//
//  PostsViewController.swift
//  Deviget
//
//  Created by Fernando Gallo on 21/10/19.
//  Copyright © 2019 Fernando Gallo. All rights reserved.
//

import UIKit

protocol PostSelectionDelegate: class {
    func postSelected(_ post: Post)
}

class PostsViewController: UIViewController {
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: PostSelectionDelegate?
    
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
        tableView.prefetchDataSource = self
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: String(describing: PostTableViewCell.self), bundle: nil),
                           forCellReuseIdentifier: PostTableViewCell.cellIdentifier)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshPosts), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = .white
        tableView.refreshControl = refreshControl
    }
    
    
    // MARK: - Helpers
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= viewModel.numberOfPosts() * 3 / 4
    }
    
    
    // MARk: - API
    
    private func getPosts() {
        activityIndicatorView.startAnimating()
        viewModel.fetchPosts(refreshing: false)
    }
    
    @objc private func refreshPosts() {
        viewModel.fetchPosts(refreshing: true)
    }
    
}


// MARK: - UITableView DataSource

extension PostsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.totalNumberOfPosts()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.cellIdentifier,
                                                 for: indexPath) as! PostTableViewCell
        
        if !isLoadingCell(for: indexPath) {
            cell.viewModel = viewModel.viewModelForRowAt(indexPath: indexPath)
            cell.viewModel.delegate = cell
            cell.configure()
        }
        
        return cell
    }
    
}


// MARK: - UITableView DataSourcePrefetching

extension PostsViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            viewModel.fetchPosts(refreshing: false)
        }
    }
    
}


// MARK: - UITableView Delegate

extension PostsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = viewModel.postForRowAt(indexPath: indexPath)
        delegate?.postSelected(post)
        
        if let postDetailsViewController = (delegate as? PostDetailsViewModel)?.delegate as? PostDetailsViewController,
            let postDetailsNavigationController = postDetailsViewController.navigationController {
            splitViewController?.showDetailViewController(postDetailsNavigationController, sender: nil)
        }
    }
    
}


// MARK: - FetchPostsDelegate

extension PostsViewController: FetchPostsDelegate {
    
    func fetchPostsSuccess() {
        activityIndicatorView.stopAnimating()
        tableView.refreshControl?.endRefreshing()
        tableView.isHidden = false
        tableView.reloadData()
    }
    
    func fetchPostsFailure() {
        activityIndicatorView.stopAnimating()
        tableView.refreshControl?.endRefreshing()
    }
    
}
