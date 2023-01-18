//
//  HomeTableViewCell.swift
//  Trending
//
//  Created by Emre on 12.01.2023.
//

import UIKit
import Kingfisher

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView! {
        didSet {
            profileImageView.layer.cornerRadius = profileImageView.frame.width/2
            profileImageView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var projectDetailLabel: UILabel!
    @IBOutlet weak var projectDetailContainerView: UIView!
    @IBOutlet weak var languageIconImageView: UIImageView!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var starIconImageView: UIImageView!
    @IBOutlet weak var starCountLabel: UILabel!

    func bindCell(with item: Item) {
        if let avatarURL = item.owner?.avatarURL,
           let url = URL(string: avatarURL) {
            profileImageView.kf.setImage(with: url)
        }
        usernameLabel.text = item.owner?.login
        projectNameLabel.text = item.fullName
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        languageIconImageView.image = languageIconImageView.image?.withRenderingMode(.alwaysTemplate)
        languageIconImageView.tintColor = .blue
        starIconImageView.image = starIconImageView.image?.withRenderingMode(.alwaysTemplate)
        starIconImageView.tintColor = .yellow
    }

}
