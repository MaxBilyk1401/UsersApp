//
//  CombinedViewController.swift
//  UsersApp
//
//  Created by Maxos on 6/14/23.
//

import UIKit

final class CombinedViewController: UIViewController {
    var viewModel = UserViewModel()
    private var list = [UserModel]()
    private var gridViewController: UsersCollectionViewController!
    private var tableViewController: UsersTableViewController!
    private var scrollView: UIScrollView!
    private var switchControl: UISwitch!
    private var wrap: UIView!
    private var innerScrollView: UIView!
    private var vcStackView: UIStackView!
    private var headerLabel: UILabel!
    private var filterButton: UIButton!
    private var settingsButton: UIButton!
    private var isTableViewMode = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHeaderLabel()
        setupButtons()
        isTableViewMode.toggle()
        setupWrapView()
        setupScrollView()
        setupInnerScrollView()
        setupVCStackView()
        setupVC()
        bindOnViewModel()
        
        gridViewController.onRefresh = { [weak self] in
            self?.viewModel.fetchData()
        }
        
        tableViewController.onRefresh = { [weak self] in
            self?.viewModel.fetchData()
        }
        
        viewModel.fetchData()
    }
    
    private func bindOnViewModel() {
        viewModel.onLoading = { [weak self] isLoading in
            guard let self else { return }
            self.gridViewController.showLoading(isLoading)
            self.tableViewController.showLoading(isLoading)
        }
        
        viewModel.onSuccess = { [weak self] list in
            guard let self else { return }
            self.gridViewController.displayUsers(list)
            self.tableViewController.displayUsers(list)
        }
        
        viewModel.onFailure = { [weak self] failure in
            guard let self else { return }
            guard let failure else { return }
            self.gridViewController.showError(failure)
            self.tableViewController.showError(failure)
        }
    }
    
    private func setupHeaderLabel() {
        headerLabel = UILabel()
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.text = "Users"
        headerLabel.font = .systemFont(ofSize: 32, weight: .heavy)
        
        view.addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }
    
    private func setupButtons() {
        filterButton = UIButton()
        filterButton.backgroundColor = .clear
        filterButton.setImage(UIImage(systemName: "line.3.horizontal.decrease"),
                              for: .normal)
        filterButton.tintColor = .black
        
        settingsButton = UIButton()
        settingsButton.backgroundColor = UIColor(named: "backgroundButtonColor")
        settingsButton.tintColor = .black
        settingsButton.layer.cornerRadius = 12
        settingsButton.layer.borderWidth = 1.50
        settingsButton.layer.borderColor = UIColor(named: "borderButtonColor")?.cgColor
        settingsButton.setImage(UIImage(systemName: "square.grid.2x2"), for: .normal)
        settingsButton.addTarget(self,
                                 action: #selector(viewModeButtonTapped),
                                 for: .touchUpInside)
        
        view.addSubview(filterButton)
        view.addSubview(settingsButton)
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            settingsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            settingsButton.widthAnchor.constraint(equalToConstant: 48),
            settingsButton.heightAnchor.constraint(equalToConstant: 48),
            filterButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            filterButton.trailingAnchor.constraint(equalTo: settingsButton.leadingAnchor, constant: -16),
            filterButton.widthAnchor.constraint(equalToConstant: 48),
            filterButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    private func setupWrapView() {
        wrap = UIView()
        wrap.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(wrap)
        NSLayoutConstraint.activate([
            wrap.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            wrap.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            wrap.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 16),
            wrap.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        scrollView.isScrollEnabled = false
        wrap.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.bottomAnchor.constraint(equalTo: wrap.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: wrap.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: wrap.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: wrap.trailingAnchor)
        ])
    }
    
    private func setupInnerScrollView() {
        innerScrollView = UIView()
        innerScrollView.translatesAutoresizingMaskIntoConstraints = false
        innerScrollView.backgroundColor = .cyan
        scrollView.addSubview(innerScrollView)
        NSLayoutConstraint.activate([
            innerScrollView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            innerScrollView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            innerScrollView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            innerScrollView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            innerScrollView.heightAnchor.constraint(equalTo: wrap.heightAnchor)
        ])
    }
    
    private func setupVCStackView() {
        vcStackView = UIStackView()
        vcStackView.distribution = .fillEqually
        vcStackView.translatesAutoresizingMaskIntoConstraints = false
        vcStackView.axis = .horizontal
        vcStackView.spacing = 0.0
        innerScrollView.addSubview(vcStackView)
        NSLayoutConstraint.activate([
            vcStackView.bottomAnchor.constraint(equalTo: innerScrollView.bottomAnchor),
            vcStackView.leadingAnchor.constraint(equalTo: innerScrollView.leadingAnchor),
            vcStackView.topAnchor.constraint(equalTo: innerScrollView.topAnchor),
            vcStackView.trailingAnchor.constraint(equalTo: innerScrollView.trailingAnchor)
        ])
    }
    
    private func setupVC() {
        gridViewController = UsersCollectionViewController()
        gridViewController.view.translatesAutoresizingMaskIntoConstraints = false
        gridViewController.view.frame = view.bounds
        gridViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        tableViewController = UsersTableViewController()
        tableViewController.view.translatesAutoresizingMaskIntoConstraints = false
        tableViewController.view.frame = view.bounds
        tableViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addChild(gridViewController)
        addChild(tableViewController)
        
        vcStackView.addArrangedSubview(gridViewController.view)
        vcStackView.addArrangedSubview(tableViewController.view)
        
        NSLayoutConstraint.activate([
            gridViewController.view.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])
        
        gridViewController.didMove(toParent: self)
        tableViewController.didMove(toParent: self)
        
    }
    
//    @objc private func showFilters(sender: UIButton) {
//        let alertController = UIAlertController(title: "Sortings", message: "s", preferredStyle: .actionSheet)
//    }
    
    @objc private func viewModeButtonTapped(sender: UIButton) {
        isTableViewMode.toggle()
        scrollView.setContentOffset(.init(x: CGFloat(isTableViewMode ? 0 : 1) * UIScreen.main.bounds.width,
                                          y: 0.0),
                                    animated: true)
        if isTableViewMode {
            settingsButton.setImage(UIImage(systemName: "square.grid.2x2"),
                                    for: .normal)
        } else {
            settingsButton.setImage(UIImage(systemName: "tablecells"),
                                    for: .normal)
        }
    }
}
