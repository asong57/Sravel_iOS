//
//  HomeSearchViewController.swift
//  Sravel
//
//  Created by asong on 2022/09/06.
//

import UIKit

final class HomeSearchViewController: UIViewController {
    
    private var searchDataArr: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSearchController()
        self.setupTableView()
        self.configureTableView()
    }
    
    private lazy var resultTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    func setupSearchController() {
        self.navigationItem.title = "해시태그로 검색"
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "검색어를 입력하세요"
        searchController.delegate = self
        searchController.searchBar.delegate = self
        self.resultTableView.tableHeaderView = searchController.searchBar;
    }
    
    func setupTableView() {
        self.resultTableView.delegate = self
        self.resultTableView.dataSource = self
    }
    
    func configureTableView() {
        view.addSubview(resultTableView)
        resultTableView.snp.makeConstraints{ make in
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(self.view)
        }
    }
}

extension HomeSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchDataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = self.searchDataArr[indexPath.row]
        return cell
    }
}

extension HomeSearchViewController: UISearchControllerDelegate {
    func willPresentSearchController(_ searchController: UISearchController) {
        print(#function, "updateQueriesSuggestions")
    }

    func willDismissSearchController(_ searchController: UISearchController) {
        print(#function, "updateQueriesSuggestions")
    }

    func didDismissSearchController(_ searchController: UISearchController) {
        print(#function, "updateQueriesSuggestions")
    }
}

extension HomeSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        searchController.isActive = false
        searchDataArr.insert(searchText, at: 0)
        resultTableView.reloadData()
        
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("cancel")
    }
}
