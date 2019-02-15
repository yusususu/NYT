//
//  ArticleTableViewCell.swift
//  NYT
//
//  Created by Yusuf Yıldız on 15.02.2019.
//  Copyright © 2019 Yusuf Yıldız. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    // Link those IBOutlets with the UILabels in your .XIB file
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var articleTypeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: AsyncImageView!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Do your stuff
        self.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        self.thumbnailImageView?.layer.cornerRadius = 37.5
        self.thumbnailImageView.clipsToBounds = true
    }


    override func prepareForReuse() {
        super.prepareForReuse()

        self.titleLabel.text = nil
        self.detailLabel.text = nil
        self.articleTypeLabel.text = nil
        self.dateLabel.text = nil
        self.thumbnailImageView.image = UIImage.init(named: "PlaceHolderImage_Table")
    }

    public func configureWithSearchArticle(viewModel: SearchArticle) {

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"

        self.articleTypeLabel.text = viewModel.articleType.uppercased()
        self.dateLabel.text = dateFormatterPrint.string(from: (viewModel.publishDate)!)
        self.titleLabel.text = viewModel.snippet
        self.detailLabel.text = viewModel.leadParagraph
        self.thumbnailImageView.url = NSURL.init(string: viewModel.media.thumbnailImageUrl?.absoluteString ?? "")

    }

    public func configureWithFeaturedArticle(viewModel: FeaturedArticle) {

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"

        self.articleTypeLabel.text = viewModel.articleType.uppercased()
        self.dateLabel.text = dateFormatterPrint.string(from: (viewModel.publishDate))
        self.titleLabel.text = viewModel.title
        self.detailLabel.text = viewModel.abstract
        self.thumbnailImageView.url = NSURL.init(string: viewModel.media.thumbnailImageUrl?.absoluteString ?? "")
    }
}
