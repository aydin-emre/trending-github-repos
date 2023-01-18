//
//  HomeViewController.swift
//  Trending
//
//  Created by Emre on 12.01.2023.
//

import UIKit
import SkeletonView

class HomeViewController: UIViewController {

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
        setupVIP()
    }

    private func setupView() {
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func setupVIP() {
        NetworkManager.shared.searchRepositories { [weak self] result in
            switch result {
            case .success(let response):
                print(response)
                if let items = response.items {
                    self?.showSkeleton = false
                    self?.list = items
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
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
