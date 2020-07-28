//
//  SmsViewController.swift
//  Test
//
//  Created by iMac on 09.06.2020.
//  Copyright © 2020 AlexAviJr. All rights reserved.
//

import UIKit

class SmsViewController: UIViewController {
    
    // - UI
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet var codeLabels: [UILabel]!
    @IBOutlet weak var textField: UITextField!
    
    // - Data
    var userNumber = "" 
    private var symbolIndex = 0
    
    // - Constraint
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    // - Action
    @IBAction func closeButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
}

// MARK: -
// MARK: - Text field delegate

extension SmsViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {        
        if string.isEmpty {
            if symbolIndex > 0 {
                symbolIndex -= 1
                codeLabels[symbolIndex].text = nil
            }
        } else {
            codeLabels[symbolIndex].text = string
            symbolIndex += 1
            if symbolIndex == codeLabels.count {
                dismiss(animated: true, completion: nil)
            }
        }
        
        return true
    }
    
}

// MARK: -
// MARK: - Configure

private extension SmsViewController {
    
    func configure() {
        configureUI()
        configureTextField()
    }
    
    func configureUI() {
        numberLabel.text = String("Please enter 4-digit code We just sent to \(userNumber)!")
    }
    
    func configureTextField() {
        textField.delegate = self
        textField.becomeFirstResponder()
    }
    
}
