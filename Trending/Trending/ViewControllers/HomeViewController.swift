//
//  HomeViewController.swift
//  Trending
//
//  Created by Emre on 12.01.2023.
//

import UIKit
import SkeletonView
import Lottie

class HomeViewController: UIViewController {

    @IBOutlet weak var noConnectionView: UIView!
    @IBOutlet weak var lottieAnimationView: LottieAnimationView!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 200
            tableView.registerClass(named: HomeTableViewCell.self)
            tableView.reloadData()
        }
    }

    private var list: [Item]?
    private var showSkeleton = true

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        searchRepositories()
    }

    @IBAction func retryButtonPressed(_ sender: UIButton) {
        searchRepositories()
    }

    private func setupView() {
        tableView.dataSource = self
        tableView.delegate = self

        setupLottie()
    }

    private func searchRepositories() {
        showSkeleton = true
        tableView.isHidden = false
        noConnectionView.isHidden = true
        NetworkManager.shared.searchRepositories { [weak self] result in
            guard let self = `self` else { return }
            switch result {
            case .success(let response):
                if let items = response.items {
                    self.showSkeleton = false
                    self.list = items
                    self.tableView.reloadData()
                }
            case .failure(_):
                self.tableView.isHidden = true
                self.noConnectionView.isHidden = false
            }
        }
    }

    private func setupLottie() {
        lottieAnimationView.contentMode = .scaleAspectFit
        lottieAnimationView.loopMode = .loop
        lottieAnimationView.play()
    }

}

extension HomeViewController: SkeletonTableViewDataSource, SkeletonTableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let list = list else {
            return 10
        }
        return list.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell",
                                                       for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }

        showSkeleton ? cell.showAnimatedGradientSkeleton() : cell.hideSkeleton()

        if let list = list, indexPath.row < list.count {
            cell.bindCell(with: list[indexPath.row])
        }

        return cell
    }

    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "HomeTableViewCell"
    }

}
