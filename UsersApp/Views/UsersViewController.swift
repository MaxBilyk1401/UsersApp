//
//  ViewController.swift
//  UsersApp
//
//  Created by Maxos on 6/10/23.
//

import UIKit

final class UsersViewController: UITableViewController {
    private var list = [UserModel]()
    var viewModel: UserViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindOnViewModel()
        viewModel.fetchData()
        title = "Users"
    }
    
    private func bindOnViewModel() {
        viewModel.onLoading = { [weak self] isLoading in
            guard let self else { return }
            if isLoading {
                self.tableView.refreshControl?.beginRefreshing()
            } else {
                self.tableView.refreshControl?.endRefreshing()
            }
        }
        
        viewModel.onSuccess = { [weak self] list in
            guard let self else { return }
            self.list = list
            self.tableView.reloadData()
        }
        
        viewModel.onFailure = { [weak self] failure in
            guard let self else { return }
            guard let failure else { return }
            let alert = UIAlertController(title: String(failure),
                                          message: nil,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK",
                                          style: .cancel))
        }
    }
    
    @objc private func onTableLoading() {
        viewModel.fetchData()
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

extension UsersViewController {
    
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
