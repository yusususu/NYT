//
//  FeaturedArticlesTableViewController.swift
//  NYT
//
//  Created by Yusuf Yıldız on 15.02.2019.
//  Copyright © 2019 Yusuf Yıldız. All rights reserved.
//

import Foundation
import UIKit

class FeaturedArticlesTableViewController: BaseTableViewController,UISearchBarDelegate {

    var pullToRefreshControl:UIRefreshControl!
    var resultsController:BaseTableViewController!
    var searchController:UISearchController!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.setup()
        self.fetchFeaturedArticles()
        self.setupSearchController();

    }

    func setup() {
        self.navigationItem.titleView = UIImageView.init(image: UIImage.init(named: "The_New_York_Times_logo"))

        self.pullToRefreshControl = UIRefreshControl.init()
        self.pullToRefreshControl.backgroundColor = UIColor.clear
        self.pullToRefreshControl.beginRefreshing()
        self.pullToRefreshControl.addTarget(self, action: #selector(fetchFeaturedArticles), for: UIControl.Event.valueChanged)

        self.tableView.addSubview(self.pullToRefreshControl)
    }

    @objc func fetchFeaturedArticles(){

        self.showActivityIndicator("")

        NYTimesAPI.sharedInstance.fetchFeaturedArticles { (viewModels: [FeaturedArticle]) in
            self.articles = viewModels;

            DispatchQueue.global(qos: .userInitiated).async {
                // Bounce back to the main thread to update the UI
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.pullToRefreshControl.endRefreshing()
                    self.hideActivityIndicator()
                }
            }
        }
    }

    func setupSearchController() {

        self.resultsController = BaseTableViewController()
        self.searchController = UISearchController.init(searchResultsController: self.resultsController)
        self.resultsController.tableView.delegate = self
        self.searchController.delegate = self as? UISearchControllerDelegate
        self.searchController.dimsBackgroundDuringPresentation = true
        self.searchController.searchBar.delegate = self
        self.searchController.searchBar.searchBarStyle = UISearchBar.Style.minimal
        self.tableView.tableHeaderView = self.searchController.searchBar
        self.definesPresentationContext = true
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        UIView.cancelPreviousPerformRequests(withTarget: self)
        self.perform(#selector(performDelayedSearch), with: searchText, afterDelay: 0.5)
    }

    @objc func performDelayedSearch(searchText: String) {

        NYTimesAPI.sharedInstance.searchArticles(query: searchText) { (viewModels:[SearchArticle]) in

            self.resultsController.articles = viewModels

            DispatchQueue.global(qos: .userInitiated).async {
                // Bounce back to the main thread to update the UI
                DispatchQueue.main.async {
                    self.resultsController.tableView.reloadData()
                }
            }
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let cont = ArticleDetailViewController.init(nibName: "ArticleDetailViewController", bundle: nil)
        self.navigationController?.pushViewController(cont, animated: true)

        cont.view.isHidden = false
        if self.articles[indexPath.row] is SearchArticle
        {
            let viewModel = self.articles[indexPath.row] as! SearchArticle
            cont.configureWithSearchArticle(viewModel: viewModel)
        }
        else if self.articles[indexPath.row] is FeaturedArticle
        {
            let viewModel = self.articles[indexPath.row] as! FeaturedArticle
            cont.configureWithFeaturedArticle(viewModel: viewModel)
        }
    }

    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))

    func showActivityIndicator(_ title: String) {

        strLabel.removeFromSuperview()
        activityIndicator.removeFromSuperview()
        effectView.removeFromSuperview()

        strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 160, height: 46))
        strLabel.text = title
        strLabel.font = .systemFont(ofSize: 14, weight: .medium)
        strLabel.textColor = UIColor(white: 0.9, alpha: 0.7)

        effectView.frame = CGRect(x: 0, y: 0 , width: view.frame.width, height: view.frame.height)
        //effectView.layer.cornerRadius = 15
        //effectView.layer.masksToBounds = true

        activityIndicator = UIActivityIndicatorView(style: .white)
        activityIndicator.frame = CGRect(x: view.frame.midX-50, y: view.frame.midY-50, width: 100, height: 100)
        activityIndicator.transform = CGAffineTransform(scaleX: 2, y: 2);
        activityIndicator.startAnimating()

        effectView.contentView.addSubview(activityIndicator)
        effectView.contentView.addSubview(strLabel)
        view.addSubview(effectView)
    }

    func hideActivityIndicator() {
        strLabel.removeFromSuperview()
        activityIndicator.removeFromSuperview()
        effectView.removeFromSuperview()
    }

}

