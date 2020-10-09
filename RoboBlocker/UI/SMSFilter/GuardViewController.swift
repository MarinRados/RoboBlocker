//
//  GuardViewController.swift
//  RoboBlocker
//
//  Created by Marin on 07/10/2020.
//  Copyright © 2020 Marin Rados. All rights reserved.
//

import UIKit

final class GuardViewController: UIViewController {
    
    var viewModel: GuardViewModel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
        addDoneButton()
        guardSwitch.setOn(viewModel.getGuardStatus(), animated: false)
        
        viewModel.onChangedList = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    // MARK: - Constraints
    
    private func setupConstraints() {
        guardSwitch.anchor(trailing: (view.trailingAnchor, 24))
        guardStatusLabel.anchor(top: (view.safeAreaLayoutGuide.topAnchor, 30), leading: (view.leadingAnchor, 24), trailing: (guardSwitch.leadingAnchor, 24))
        guardSwitch.centerYAnchor.constraint(equalTo: guardStatusLabel.centerYAnchor).isActive = true
        filterListTitleLabel.anchor(top: (guardStatusLabel.bottomAnchor, 16), leading: (view.leadingAnchor, 24))
        addButton.anchor(trailing: (view.trailingAnchor, 20), size: CGSize(width: 40, height: 40))
        textField.anchor(top: (filterListTitleLabel.bottomAnchor, 16), leading: (view.leadingAnchor, 24), trailing: (addButton.leadingAnchor, 12), size: CGSize(width: 0, height: 40))
        addButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor).isActive = true
        tableView.anchor(top: (textField.bottomAnchor, 20), bottom: (view.safeAreaLayoutGuide.bottomAnchor, 0), leading: (view.leadingAnchor, 0), trailing: (view.trailingAnchor, 0))
        topSeparator.anchor(bottom: (tableView.topAnchor, 0), leading: (view.leadingAnchor, 0), trailing: (view.trailingAnchor, 0), size: CGSize(width: 0, height: 0.5))
    }
    
    // MARK: - User Interaction
    
    @objc private func switchValueDidChange(_ sender: UISwitch) {
        viewModel.setGuardStatus(isOn: sender.isOn)
    }
    
    @objc private func addTapped() {
        textField.resignFirstResponder()
        guard let input = textField.text else {
            showAlert(title: "Please enter the word you wish to add to your filters", message: nil, actions: [UIAlertAction(title: "OK", style: .default, handler: nil)])
            return
        }
        if input.isEmptyOrWhitespace {
            showAlert(title: "Please enter the word you wish to add to your filters", message: nil, actions: [UIAlertAction(title: "OK", style: .default, handler: nil)])
            return
        }
        viewModel.addToFilter(word: input.lowercased())
    }
    
    // MARK: - UI Components
    
    private lazy var guardStatusLabel: UILabel = {
        let guardStatusLabel = UILabel()
        guardStatusLabel.numberOfLines = 0
        UILabelStyle.regularText.apply(to: guardStatusLabel)
        guardStatusLabel.text = "Turn on SMS filter protection"
        view.addSubview(guardStatusLabel)
        return guardStatusLabel
    }()
    
    private lazy var guardSwitch: UISwitch = {
        let guardSwitch = UISwitch()
        guardSwitch.onTintColor = .main
        guardSwitch.backgroundColor = .white
        guardSwitch.setOn(false, animated: false)
        guardSwitch.addTarget(self, action: #selector(switchValueDidChange), for: .valueChanged)
        view.addSubview(guardSwitch)
        return guardSwitch
    }()
    
    private lazy var filterListTitleLabel: UILabel = {
        let filterListTitleLabel = UILabel()
        UILabelStyle.bold32Main.apply(to: filterListTitleLabel)
        filterListTitleLabel.text = "Filter Words"
        view.addSubview(filterListTitleLabel)
        return filterListTitleLabel
    }()
    
    private lazy var addButton: UIButton = {
        let addButton = UIButton()
        addButton.tintColor = .main
        addButton.setImage(#imageLiteral(resourceName: "add").withRenderingMode(.alwaysTemplate), for: .normal)
        addButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        view.addSubview(addButton)
        return addButton
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.contentVerticalAlignment = .center
        textField.textColor = UIColor.dark
        textField.font = Font.regular(size: 17)
        textField.autocapitalizationType = UITextAutocapitalizationType.none
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.grayText.cgColor
        textField.layer.cornerRadius = 4
        textField.placeholder = "Enter filter word"
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 40))
        leftView.backgroundColor = .clear
        textField.leftView = leftView
        textField.leftViewMode = .always
        textField.backgroundColor = .white
        view.addSubview(textField)
        return textField
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.register(FilterWordTableViewCell.self, forCellReuseIdentifier: "FilterWordTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .grayText
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.tableFooterView = UIView()
        tableView.keyboardDismissMode = .onDrag
        view.addSubview(tableView)
        return tableView
    }()
    
    private lazy var topSeparator: UIView = {
        let topSeparator = UIView()
        topSeparator.backgroundColor = .grayText
        view.addSubview(topSeparator)
        return topSeparator
    }()
    
    // MARK: - Utility
    
    private func addDoneButton() {
        let toolBar: UIToolbar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.items = [UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil),
                         UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(donePressed))]
        toolBar.sizeToFit()
        textField.inputAccessoryView = toolBar
    }
    
    @objc private func donePressed() {
        textField.resignFirstResponder()
    }
}

extension GuardViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FilterWordTableViewCell", for: indexPath) as? FilterWordTableViewCell else { return UITableViewCell() }
        cell.word = viewModel.filteredWords[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action =  UIContextualAction(style: .normal, title: "Delete", handler: { [weak self] (_, _, completionHandler ) in
            self?.viewModel.delete(index: indexPath.row)
            completionHandler(true)
        })
        action.backgroundColor = .red
        let configuration = UISwipeActionsConfiguration(actions: [action])
        return configuration
    }
}

extension GuardViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.main.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.grayText.cgColor
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
