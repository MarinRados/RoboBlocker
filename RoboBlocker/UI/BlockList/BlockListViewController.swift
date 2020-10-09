//
//  BlockListViewController.swift
//  RoboBlocker
//
//  Created by Marin on 07/10/2020.
//  Copyright © 2020 Marin Rados. All rights reserved.
//

import UIKit
import Contacts

final class BlockListViewController: UIViewController {
    
    var viewModel: BlockListViewModel!
    private let contactStore = CNContactStore()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
        addDoneButton()
        blockAllSwitch.setOn(viewModel.getContactListStatus(), animated: false)
        getContactListAuthorization()
        
        viewModel.onChangedList = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    // MARK: - Contacts
    
    private func getContactListAuthorization() {
        // Getting contacts from contact list to create a whitelist. Whitelist is not supported in CallDirectoryHandler.
        // This code should be removed but I left it as a showcase how to fetch the contact list.
        let authorizationStatus = CNContactStore.authorizationStatus(for: .contacts)
        switch authorizationStatus {
        case .authorized:
            getContacts()
        case .notDetermined:
            contactStore.requestAccess(for: .contacts) { [weak self] granted, error in
                if error != nil {
                    print(String(describing: error))
                }
                if granted {
                    self?.getContacts()
                }
            }
        default:
            break
        }
    }
    
    private func getContacts() {
        blockAllSwitch.isEnabled = true
        let request = CNContactFetchRequest(keysToFetch: [CNContactPhoneNumbersKey as CNKeyDescriptor])
        var contactList: [String] = []
        do {
            try contactStore.enumerateContacts(with: request) { [weak self] contacts, _ in
                for phone in contacts.phoneNumbers {
                    let number = phone.value.stringValue.trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: .symbols)
                    contactList.append(number)
                }
                self?.viewModel.saveContacts(contactList)
            }
        } catch {
            print(error)
        }
    }
    
    // MARK: - Constraints
    
    private func setupConstraints() {
        blockAllSwitch.anchor(trailing: (view.trailingAnchor, 24))
        allowOnlyContactsLabel.anchor(top: (view.safeAreaLayoutGuide.topAnchor, 30), leading: (view.leadingAnchor, 24), trailing: (blockAllSwitch.leadingAnchor, 24))
        blockAllSwitch.centerYAnchor.constraint(equalTo: allowOnlyContactsLabel.centerYAnchor).isActive = true
        blockListTitleLabel.anchor(top: (allowOnlyContactsLabel.bottomAnchor, 16), leading: (view.leadingAnchor, 24))
        addButton.anchor(trailing: (view.trailingAnchor, 20), size: CGSize(width: 40, height: 40))
        textField.anchor(top: (blockListTitleLabel.bottomAnchor, 16), leading: (view.leadingAnchor, 24), trailing: (addButton.leadingAnchor, 12), size: CGSize(width: 0, height: 40))
        addButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor).isActive = true
        tableView.anchor(top: (textField.bottomAnchor, 20), bottom: (view.safeAreaLayoutGuide.bottomAnchor, 0), leading: (view.leadingAnchor, 0), trailing: (view.trailingAnchor, 0))
        topSeparator.anchor(bottom: (tableView.topAnchor, 0), leading: (view.leadingAnchor, 0), trailing: (view.trailingAnchor, 0), size: CGSize(width: 0, height: 0.5))
    }
    
    // MARK: - User Interaction
    
    @objc private func switchValueDidChange(_ sender: UISwitch) {
        viewModel.setContactListStatus(isOn: sender.isOn)
    }
    
    @objc private func addTapped() {
        textField.resignFirstResponder()
        guard let input = textField.text else {
            showAlert(title: "Please enter the number you wish to add to your block list.", message: nil, actions: [UIAlertAction(title: "OK", style: .default, handler: nil)])
            return
        }
        if !CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: input)) {
            showAlert(title: "Invalid phone number", message: nil, actions: [UIAlertAction(title: "OK", style: .default, handler: nil)])
            return
        } else if input.isEmptyOrWhitespace {
            showAlert(title: "Please enter the number you wish to add to your block list", message: nil, actions: [UIAlertAction(title: "OK", style: .default, handler: nil)])
            return
        } else if input.count < 10 {
            showAlert(title: "Please enter the whole phone number", message: nil, actions: [UIAlertAction(title: "OK", style: .default, handler: nil)])
            return
        }
        textField.text = ""
        viewModel.addToBlockList(number: input)
    }
    
    // MARK: - UI Components
    
    private lazy var allowOnlyContactsLabel: UILabel = {
        let allowOnlyContactsLabel = UILabel()
        allowOnlyContactsLabel.numberOfLines = 0
        UILabelStyle.regularText.apply(to: allowOnlyContactsLabel)
        allowOnlyContactsLabel.text = "Only allow calls from your contact list"
        view.addSubview(allowOnlyContactsLabel)
        return allowOnlyContactsLabel
    }()
    
    private lazy var blockAllSwitch: UISwitch = {
        let blockAllSwitch = UISwitch()
        blockAllSwitch.onTintColor = .main
        blockAllSwitch.backgroundColor = .white
        blockAllSwitch.setOn(false, animated: false)
        blockAllSwitch.isEnabled = false
        blockAllSwitch.addTarget(self, action: #selector(switchValueDidChange), for: .valueChanged)
        view.addSubview(blockAllSwitch)
        return blockAllSwitch
    }()
    
    private lazy var blockListTitleLabel: UILabel = {
        let blockListTitleLabel = UILabel()
        UILabelStyle.bold32Main.apply(to: blockListTitleLabel)
        blockListTitleLabel.text = "Block List"
        view.addSubview(blockListTitleLabel)
        return blockListTitleLabel
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
        textField.placeholder = "Enter phone number"
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 40))
        leftView.backgroundColor = .clear
        textField.leftView = leftView
        textField.leftViewMode = .always
        textField.backgroundColor = .white
        
        textField.keyboardType = .numberPad
        view.addSubview(textField)
        return textField
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.register(BlockedNumberTableViewCell.self, forCellReuseIdentifier: "BlockedNumberTableViewCell")
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

extension BlockListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.blockList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BlockedNumberTableViewCell", for: indexPath) as? BlockedNumberTableViewCell else { return UITableViewCell() }
        cell.phoneNumber = viewModel.blockList[indexPath.row]
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

extension BlockListViewController: UITextFieldDelegate {
    
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        return newLength <= 12
    }
}
