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
            tableView.estimatedRowHeight = 410
            tableView.rowHeight = 410
            tableView.registerClass(named: HomeTableViewCell.self)
        }
    }

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
        NetworkManager.shared.searchRepositories { result in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error)
            }
        }
    }

}

extension HomeViewController: SkeletonTableViewDataSource, SkeletonTableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "HomeTableViewCell"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

}
