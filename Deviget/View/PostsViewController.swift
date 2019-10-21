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
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: String(describing: PostTableViewCell.self), bundle: nil),
                           forCellReuseIdentifier: PostTableViewCell.cellIdentifier)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshPosts), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = .white
        tableView.refreshControl = refreshControl
    }
    
    
    // MARk: - API
    
    private func getPosts() {
        activityIndicatorView.startAnimating()
        viewModel.fetchPosts()
    }
    
    @objc private func refreshPosts() {
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
        tableView.isHidden = false
        tableView.reloadData()
        tableView.refreshControl?.endRefreshing()
    }
    
    func fetchPostsFailure() {
        activityIndicatorView.stopAnimating()
        tableView.refreshControl?.endRefreshing()
    }
    
}
