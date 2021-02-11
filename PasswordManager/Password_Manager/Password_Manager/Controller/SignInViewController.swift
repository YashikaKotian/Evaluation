//
//  SignInViewController.swift
//  Password_Manager
//
//  Created by Yashika on 1/11/20.
//  Copyright © 2020 Yashika. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var mPinTextField: UITextField!
    @IBOutlet weak var eyeButton: UIButton!
    @IBOutlet weak var scrollViewBottomConstraint: NSLayoutConstraint!
    
    //MARK: Action Methods
    @IBAction func showPasswordTapped(_ sender: UIButton) {
        mPinTextField.isSecureTextEntry = !mPinTextField.isSecureTextEntry
        if mPinTextField.isSecureTextEntry {
            eyeButton.setImage(UIImage(named: "eye_on"),  for: .normal)
        } else {
            eyeButton.setImage(UIImage(named: "eye_close"), for: .normal)
        }
    }
    
    @IBAction func forgotPasswordTapped(_ sender: UIButton) {
    }
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        saveUserData()
        ScreenManger.loadHomeScreen()
    }
    
    @IBAction func fingerPrintButtonTapped(_ sender: UIButton) {
    }
    
    
    //MARK: Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = UserDefaults.standard
        let mobileNumber = defaults.string(forKey: "mobileNumber")
        mobileNumberTextField.text = mobileNumber
        
    }
}

extension SignInViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == mobileNumberTextField {
            guard let textFieldText = textField.text,
                let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                    return false
            }
            let substringToReplace = textFieldText[rangeOfTextToReplace]
            let count = textFieldText.count - substringToReplace.count + string.count
            return count <= 10
        }
        
        if textField == mPinTextField {
            guard let textFieldText = textField.text else {
                return false
            }
            return textFieldText.count <= 3
        }
        return false
    }
}

private extension SignInViewController {
    func saveUserData() {
        let defaults = UserDefaults.standard
        guard let mobileNumber = mobileNumberTextField.text else {
            return
        }
        guard let mPin = mobileNumberTextField.text else {
            return
        }
        defaults.set(mobileNumber, forKey: "mobileNumber")
        defaults.set(mPin, forKey: "mPin")
    }
    
    func setUp() {
        createGradientLayer()
        view.bringSubviewToFront(scrollView)
        if let placeholder = mobileNumberTextField.placeholder {
            mobileNumberTextField.attributedPlaceholder = NSAttributedString(string:placeholder,
                                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.hexFromString(hexa: "#787E8C")])
        }
    }
    
    func createGradientLayer() {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.view.bounds
        
        gradientLayer.colors = [UIColor.hexFromString(hexa:
            "#20BBFF").cgColor, UIColor.hexFromString(hexa:
                "#0E85FF").cgColor]
        
        self.view.layer.addSublayer(gradientLayer)
        
    }
}
