//
//  UsersCollectionViewController.swift
//  UsersApp
//
//  Created by Maxos on 6/13/23.
//

import UIKit

final class UsersCollectionViewController: UICollectionViewController {
    private var list = [UserModel]()
    var onRefresh: (() -> Void)?
    var onDisplay: (([UserModel]) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    init() {
        let flow = UICollectionViewFlowLayout()
        flow.minimumLineSpacing = 16.0
        flow.minimumInteritemSpacing = 16.0
        super.init(collectionViewLayout: flow)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc private func onCollectionLoading() {
        onRefresh?()
    }
    
    private func setupCollectionView() {
        let controll = UIRefreshControl()
        controll.addTarget(self, action: #selector(onCollectionLoading), for: .valueChanged)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: String(describing: UsersCollectionViewCell.self),
                                      bundle: nil),
                                forCellWithReuseIdentifier: String(describing: UsersCollectionViewCell.self))
        collectionView.refreshControl = controll
    }
}

extension UsersCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        list.count
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: UsersCollectionViewCell.self),
            for: indexPath) as! UsersCollectionViewCell
        let item = list[indexPath.row]
        cell.setup(with: item)
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = (UIScreen.main.bounds.width - 48) / 2
        let height = width / 193 * 305
        return CGSize(width: width, height: height)
    }
}

extension UsersCollectionViewController: GridViewProtocol {
    
    func showError(_ error: String) {
        let alert = UIAlertController(title: String(error),
                                      message: nil,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .cancel))
        present(alert, animated: true)
    }
    
    func displayUsers(_ users: [UserModel]) {
        self.list = users
        self.collectionView.reloadData()
    }
    
    func showLoading(_ isLoading: Bool) {
        if isLoading {
            self.collectionView.refreshControl?.beginRefreshing()
        } else {
            self.collectionView.refreshControl?.endRefreshing()
        }
    }
}

/*
 //    private func bindOnViewModel() {
 //        viewModel.onLoading = { [weak self] isLoading in
 //            guard let self else { return }
 //            if isLoading {
 //                self.collectionView.refreshControl?.beginRefreshing()
 //            } else {
 //                self.collectionView.refreshControl?.endRefreshing()
 //            }
 //        }
 //
 //        viewModel.onSuccess = { [weak self] list in
 //            guard let self else { return }
 //            self.list = list
 //            self.collectionView.reloadData()
 //        }
 //
 //        viewModel.onFailure = { [weak self] failure in
 //            guard let self else { return }
 //            guard let failure else { return }
 //            let alert = UIAlertController(title: String(failure),
 //                                          message: nil,
 //                                          preferredStyle: .alert)
 //            alert.addAction(UIAlertAction(title: "OK",
 //                                          style: .cancel))
 //            present(alert, animated: true)
 //        }
 //    }
 */
