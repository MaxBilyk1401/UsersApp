//
//  FilterViewController.swift
//  UsersApp
//
//  Created by Maxos on 6/25/23.
//

import UIKit

final class FilterViewController: UIViewController {
    var viewModel: FilterViewModel!
    var sorting = [Sorting].self
    var filter = [Filter].self
    private var filterLabel: UILabel!
    private var sortingLabel: UILabel!
    private var textFieldsStackView: UIStackView!
    private var textField: UITextField!
    private var textField2: UITextField!
    private var doneButton: UIButton!
    private var clearButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Settings"
        setupLables()
        setupTextFieldsAndStackView()
        setupButtons()
    }
    
    private func setupLables() {
        filterLabel = UILabel()
        filterLabel.translatesAutoresizingMaskIntoConstraints = false
        filterLabel.text = "Filters"
        filterLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        
        sortingLabel = UILabel()
        sortingLabel.translatesAutoresizingMaskIntoConstraints = false
        sortingLabel.text = "Sort by"
        sortingLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        
        view.addSubview(filterLabel)
        view.addSubview(sortingLabel)
        NSLayoutConstraint.activate([
            filterLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            filterLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            sortingLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            sortingLabel.leadingAnchor.constraint(equalTo: filterLabel.trailingAnchor, constant: 112)
        ])
    }
    
    private func setupTextFieldsAndStackView() {
        textFieldsStackView = UIStackView()
        textFieldsStackView.axis = .horizontal
        textFieldsStackView.alignment = .leading
        textFieldsStackView.distribution = .fillProportionally
        textFieldsStackView.spacing = 16
        textFieldsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(textFieldsStackView)
        NSLayoutConstraint.activate([
            textFieldsStackView.topAnchor.constraint(equalTo: filterLabel.bottomAnchor, constant: 8),
            textFieldsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textFieldsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        let pickerView1 = UIPickerView()
        let pickerView2 = UIPickerView()
//        pickerView1.delegate = self
//        pickerView1.dataSource = self
//        pickerView2.delegate = self
//        pickerView2.dataSource = self
        
        textField = UITextField()
        textField.placeholder = "Choose filters"
        textField.borderStyle = .roundedRect
        textField.inputView = pickerView1
        textFieldsStackView.addArrangedSubview(textField)
        
        textField2 = UITextField()
        textField2.placeholder = "Choose sorting"
        textField2.borderStyle = .roundedRect
        textField2.inputView = pickerView2
        textFieldsStackView.addArrangedSubview(textField2)
    }
    
//    private func selectActivityBy(row: Int) {
//        textField.text = sorting[]
//        textField2.text =
//    }
    
    private func setupButtons() {
        doneButton = UIButton()
        clearButton = UIButton()
        
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(.black, for: .normal)
        doneButton.tintColor = .black
        doneButton.layer.cornerRadius = 12.0
        doneButton.layer.borderWidth = 1.0
        doneButton.layer.borderColor = UIColor(named: "borderButtonColor")?.cgColor
        doneButton.backgroundColor = UIColor(named: "backgroundButtonColor")
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        
        clearButton.setTitle("Clear", for: .normal)
        clearButton.setTitleColor(.black, for: .normal)
        clearButton.tintColor = .black
        clearButton.layer.cornerRadius = 12.0
        clearButton.layer.borderWidth = 1.0
        clearButton.layer.borderColor = UIColor(named: "borderButtonColor")?.cgColor
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(doneButton)
        view.addSubview(clearButton)
        
        NSLayoutConstraint.activate([
            doneButton.topAnchor.constraint(equalTo: textFieldsStackView.bottomAnchor, constant: 16),
            doneButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            clearButton.topAnchor.constraint(equalTo: doneButton.bottomAnchor, constant: 16),
            clearButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            clearButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    @objc private func doneButtonTapped() {
        viewModel.done()
    }
}

//extension FilterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        <#code#>
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        <#code#>
//    }
//}
