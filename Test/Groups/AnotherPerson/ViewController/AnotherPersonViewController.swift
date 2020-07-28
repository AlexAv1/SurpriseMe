//
//  AnotherPersonViewController.swift
//  Test
//
//  Created by iMac on 09.06.2020.
//  Copyright © 2020 AlexAviJr. All rights reserved.
//

import UIKit

class AnotherPersonViewController: UIViewController {
    
    // - UI
    @IBOutlet weak var textField: UITextField!
    
    // - Constraint
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    // - Data
    var userNumber = ""
    
    // - Action
    @IBAction func confirmButtonAction(_ sender: Any) {
        let vc = UIStoryboard(name: "Sms", bundle: nil).instantiateViewController(withIdentifier: "SmsViewController") as! SmsViewController
        vc.userNumber = userNumber
        present(vc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
}

// MARK: -
// MARK: - Text field delegate

extension AnotherPersonViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()
        return true
    }
    
}

// MARK: -
// MARK: - Configure

private extension AnotherPersonViewController {
    
    func configure() {
        configureTapGesture()
        configureTextField()
        subscribeToKeyboardNotifications()
    }
    
    func configureTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func configureTextField() {
        //        textField.delegate = self
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
}

// MARK: -
// MARK: - Keyboard logic

private extension AnotherPersonViewController {
    
    @objc func hideKeyboard() {
        textField.resignFirstResponder()
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        bottomConstraint.constant = 320
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        bottomConstraint.constant = 200
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
    
}


