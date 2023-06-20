//
//  ViewController.swift
//  UsersApp
//
//  Created by Maxos on 6/10/23.
//

import UIKit

final class UsersTableViewController: UITableViewController {
    private var list = [UserModel]()
    var onRefresh: (() -> Void)?
    var onDisplay: (([UserModel]) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    @objc private func onTableLoading() {
        onRefresh?()
    }
    
    private func setupTableView() {
        let controll = UIRefreshControl()
        controll.addTarget(self, action: #selector(onTableLoading), for: .valueChanged)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: String(describing: UserTableViewCell.self),
                                 bundle: nil),
                           forCellReuseIdentifier: String(describing: UserTableViewCell.self))
        tableView.refreshControl = controll
    }
}

extension UsersTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: UserTableViewCell.self),
            for: indexPath
        ) as! UserTableViewCell
        
        let item = list[indexPath.row]
        cell.setup(with: item)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension UsersTableViewController: GridViewProtocol {
    
    func showError(_ error: String) {
        let alert = UIAlertController(title: String(error),
                                      message: nil,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .cancel))
        present(alert, animated: true)
    }
    
    func displayUsers(_ users: [UserModel]) {
        list = users
        self.tableView.reloadData()
    }
    
    func showLoading(_ isLoading: Bool) {
        if isLoading {
            self.tableView.refreshControl?.beginRefreshing()
        } else {
            self.tableView.refreshControl?.endRefreshing()
        }
    }
}
