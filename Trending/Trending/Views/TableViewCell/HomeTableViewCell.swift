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
    @IBOutlet weak var languageContainerView: UIView!
    @IBOutlet weak var languageIconImageView: UIImageView!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var starContainerView: UIView!
    @IBOutlet weak var starIconImageView: UIImageView!
    @IBOutlet weak var starCountLabel: UILabel!

    func bindCell(with item: Item) {
        if let avatarURL = item.owner?.avatarURL,
           let url = URL(string: avatarURL) {
            profileImageView.kf.setImage(with: url)
        }
        usernameLabel.text = item.owner?.login
        projectNameLabel.text = item.fullName
        projectDetailLabel.text = item.descriptionText
        languageLabel.text = item.language
        starCountLabel.text = String(item.stargazersCount ?? 0)

        projectDetailLabel.isHidden = item.descriptionText == nil
        projectDetailContainerView.isHidden = (item.language == nil) && (item.stargazersCount == nil)
        languageContainerView.isHidden = item.language == nil
        starContainerView.isHidden = item.stargazersCount == nil
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        languageIconImageView.image = languageIconImageView.image?.withRenderingMode(.alwaysTemplate)
        languageIconImageView.tintColor = .systemBlue
        starIconImageView.image = starIconImageView.image?.withRenderingMode(.alwaysTemplate)
        starIconImageView.tintColor = .systemYellow
    }

}
