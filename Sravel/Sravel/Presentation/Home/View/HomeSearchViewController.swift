//
//  HomeSearchViewController.swift
//  Sravel
//
//  Created by asong on 2022/09/06.
//

import UIKit

final class HomeSearchViewController: UIViewController {
    
    var arr = ["Zedd", "Alan Walker", "David Guetta", "Avicii", "Marshmello", "Steve Aoki", "R3HAB", "Armin van Buuren", "Skrillex", "Illenium", "The Chainsmokers", "Don Diablo", "Afrojack", "Tiesto", "KSHMR", "DJ Snake", "Kygo", "Galantis", "Major Lazer", "Vicetone"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSearchController()
        self.setupTableView()
    }
    
    private lazy var resultTableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    
    func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.title = "해시태그로 검색"
        searchController.searchBar.placeholder = "검색어를 입력하세요"
        self.navigationItem.searchController = searchController
    }
    
    func setupTableView() {
        self.resultTableView.delegate = self
        self.resultTableView.dataSource = self
    }
}

extension HomeSearchViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = self.arr[indexPath.row]
        return cell
    }
}

extension HomeSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text)
    }
}
