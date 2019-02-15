//
//  BaseTableViewController.swift
//  NYT
//
//  Created by Yusuf Yıldız on 15.02.2019.
//  Copyright © 2019 Yusuf Yıldız. All rights reserved.
//

import Foundation
import UIKit

class BaseTableViewController: UITableViewController {

    var articles : [Any] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        //self.tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: "ArticleTableViewCell")
        self.tableView.register(UINib(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: "ArticleTableViewCell")
        self.tableView.rowHeight = UITableView.automaticDimension;
        self.tableView.estimatedRowHeight = 140;
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell : ArticleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as! ArticleTableViewCell

        if self.articles[indexPath.row] is SearchArticle
        {
            let viewModel = self.articles[indexPath.row] as! SearchArticle
            cell.configureWithSearchArticle(viewModel: viewModel)
        }
        else if self.articles[indexPath.row] is FeaturedArticle
        {
            let viewModel = self.articles[indexPath.row] as! FeaturedArticle
            cell.configureWithFeaturedArticle(viewModel: viewModel)
        }

        return cell;

    }

}

