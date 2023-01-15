//
//  NetworkPath.swift
//  Trending
//
//  Created by Emre on 13.01.2023.
//

import Foundation

enum NetworkPath {
    static let baseUrl: String = "https://api.github.com/"
    static let searchRepositories = "search/repositories?q=language=+sort:stars"
}
