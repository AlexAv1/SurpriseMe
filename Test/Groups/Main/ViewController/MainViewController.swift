//
//  MainViewController.swift
//  Test
//
//  Created by iMac on 09.06.2020.
//  Copyright © 2020 AlexAviJr. All rights reserved.
//

import UIKit
import CountryPickerView
import SwiftPhoneNumberFormatter
import Moya

class MainViewController: UIViewController {
    
    // - UI
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var textField: PhoneFormattedTextField!
    
    // - Constraint
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    
    // - Data
    var users = [UserModel]()
    var persons = [PersonModel]()
    
    // - Server provider
    private let provider = MoyaProvider<UsersServerDataProvider>()
    
    // - Action
    @IBAction func confirmButtonAction(_ sender: Any) {
        provider.request(.users) { (result) in
            switch result {
            case .success(let response):
                let persons = try! JSONDecoder().decode([PersonModel].self, from: response.data)
                self.persons = persons
                
            case .failure(let error):
                print(error)
            }
        }
        
        let smsVC = UIStoryboard(name: "Sms", bundle: nil).instantiateViewController(withIdentifier: "SmsViewController") as! SmsViewController
        smsVC.userNumber = users[0].number
        present(smsVC, animated: true, completion: nil)
        
    }
    
    @IBAction func anotherPersonButtonAction(_ sender: Any) {
        let anotherPersonVC = UIStoryboard(name: "AnotherPerson", bundle: nil).instantiateViewController(withIdentifier: "AnotherPersonViewController") as! AnotherPersonViewController
        anotherPersonVC.userNumber = users[0].number
        anotherPersonVC.modalPresentationStyle = .overFullScreen
        present(anotherPersonVC, animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
}

// MARK: -
// MARK: - Text field delegate

extension MainViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()
        return true
    }
    
}

// MARK: -
// MARK: - Configure

extension MainViewController {
    
    func configure() {
        configureUsers()
        configureTapGesture()
        configureTextField()
        subscribeToKeyboardNotifications()
    }
    
    func configureUsers() {
        let anita = UserModel(id: 1, name: "Anitta", number: "720 505-50-00", mail:"anita@gmail.com")
        
        nameLabel.text = String("Hi, \(anita.name)!")
        
        users = [anita]
    }
    
    func configureTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func configureTextField() {
        textField.delegate = self
        textField.config.defaultConfiguration = PhoneFormat(defaultPhoneFormat: "(###) ###-##-##")
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
}

// MARK: -
// MARK: - Keyboard logic

private extension MainViewController {
    
    @objc func hideKeyboard() {
        textField.resignFirstResponder()
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        bottomConstraint.constant = 310
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        bottomConstraint.constant = 40
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
    
}
