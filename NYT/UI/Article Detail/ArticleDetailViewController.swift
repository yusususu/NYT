//
//  ArticleDetailViewController.swift
//  NYT
//
//  Created by Yusuf Yıldız on 15.02.2019.
//  Copyright © 2019 Yusuf Yıldız. All rights reserved.
//

import Foundation
import UIKit

class ArticleDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var articleTypeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: AsyncImageView!


    public func configureWithSearchArticle(viewModel: SearchArticle) {

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"

        self.articleTypeLabel.text = viewModel.articleType.uppercased()
        self.dateLabel.text = dateFormatterPrint.string(from: (viewModel.publishDate)!)
        self.titleLabel.text = viewModel.snippet
        self.detailLabel.text = viewModel.leadParagraph
        detailLabel.sizeToFit()
        self.thumbnailImageView.url = NSURL.init(string: viewModel.media.detailImageUrl?.absoluteString ?? "")
    }

    public func configureWithFeaturedArticle(viewModel: FeaturedArticle) {

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"

        self.articleTypeLabel.text = viewModel.articleType.uppercased()
        self.dateLabel.text = dateFormatterPrint.string(from: (viewModel.publishDate))
        self.titleLabel.text = viewModel.title
        self.detailLabel.text = viewModel.abstract
        detailLabel.sizeToFit()
        self.thumbnailImageView.url = NSURL.init(string: viewModel.media.detailImageUrl?.absoluteString ?? "")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.navigationItem.titleView = UIImageView.init(image: UIImage.init(named: "The_New_York_Times_logo"))
    }

    override func viewDidLayoutSubviews() {
        detailLabel.sizeToFit()
    }

}

