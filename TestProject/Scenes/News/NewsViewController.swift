//
//  NewsViewController.swift
//  TestProject
//
//  Created by Nana Jimsheleishvili on 23.11.23.
//

import UIKit

final class NewsViewController: UIViewController {
    
    // MARK: - Properties
    private var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    private var news = [News]()
    private var viewModel  = DefaultNewViewModel()

    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        viewModel.viewDidLoad()
    }
    
    // MARK: - Setup TableView
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "newsCell")
        tableView.dataSource = self
        tableView.delegate = self
        #warning("Usually we write the tableView registration+delegate+dataSource in a different function and not in the properties section. Since there are no other visual properties, we can get away with writing them here.")

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

// MARK: - TableViewDataSource
extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return news.count
        #warning("If we had zero there, we would not get any visuals, so instead changed it to news.count, so tableView cell number is the same as the news number.")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as? NewsTableViewCell else {
            fatalError("Could not dequeue NewsCell")
            return UITableViewCell()
        }
        #warning("Next time make sure the cell identifier is the same everywhere")
        cell.configure(with: news[indexPath.row])
        return cell
    }
}

// MARK: - TableViewDelegate
extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
        #warning("Zero would mean nothing would show, since it's the height")
    }
}

// MARK: - NewsViewModelDelegate
extension NewsViewController: NewsViewModelDelegate {
    func newsFetched(_ news: [News]) {
        self.news = news
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        #warning("In order for the code to work smoothely added dispatchQueue.")
    }
    
    func showError(_ error: Error) {
        print("error")
    }
}


