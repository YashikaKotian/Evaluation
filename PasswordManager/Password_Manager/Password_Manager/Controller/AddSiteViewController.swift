//
//  AddSiteViewController.swift
//  Password_Manager
//
//  Created by Yashika on 1/11/20.
//  Copyright © 2020 Yashika. All rights reserved.
//

import UIKit

struct AddSiteOptions {
    let title: String
    var value: String
}

enum OptionList: Int {
    case url = 0, siteName, sectorOrFolder, userName, sitePassword, notes
}

class AddSiteViewController: UIViewController {
    
    //MARK: Variables
    private var options = [AddSiteOptions]()
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Outlet Actions
    @IBAction func resetTapped(_ sender: UIButton) {
        options.removeAll()
        options.append(contentsOf: createAddSiteOption())
        tableView.reloadData()
    }
    
    @IBAction func saveTapped(_ sender: UIButton) {
        let siteDetail = SiteInfo(url: options[OptionList.url.rawValue].value, siteName: options[OptionList.siteName.rawValue].value, sectorOrFolder: options[OptionList.sectorOrFolder.rawValue].value, userName: options[OptionList.userName.rawValue].value, password: options[OptionList.sitePassword.rawValue].value, notes: options[OptionList.notes.rawValue].value)
        let randomFilename = UUID().uuidString + "password_manager"
               let ud = UserDefaults.standard
               if var randomFilenames = ud.value(forKey: "paths") as? [String] {
                   randomFilenames.append(randomFilename)
                   ud.set(randomFilenames, forKey: "paths")
               } else {
                   ud.set([randomFilename], forKey: "paths")
               }
               
               let fullPath = getDocumentsDirectory().appendingPathComponent(randomFilename)
               
               do {
                   let data = try NSKeyedArchiver.archivedData(withRootObject: siteDetail, requiringSecureCoding: false)
                   try data.write(to: fullPath)
               } catch {
                   print("Couldn't write file")
               }
               print("data\(siteDetail)")
               showToast(message: "Saved suucessfully")
           }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func showToast(message: String) {
        let toastLabel = UITextView(frame: CGRect(x: self.view.frame.size.width/16, y: self.view.frame.size.height-100, width: self.view.frame.size.width * 7/8, height: 56))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.text = "   \(message)   "
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 28;
        toastLabel.clipsToBounds  =  true
        toastLabel.font = UIFont(name: (toastLabel.font?.fontName)!, size: 20)
        toastLabel.center.x = self.view.frame.size.width/2
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 2.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
            self.navigationController?.popViewController(animated: true)
        })
    }

    class var instance : AddSiteViewController {
        return Storyboard.main.instantiateVC(AddSiteViewController.self)
    }
    override func viewDidLoad() {
        initialSetUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barTintColor = UIColor.hexFromString(hexa: "#0E85FF")
        //To change Back button title & icon color
        navigationController?.navigationBar.tintColor = UIColor.white
        //To change Navigation Bar Title Color
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.topItem?.title = "Add Site"
        
        
        
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isHidden = false
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func initialSetUp () {
        registerCell()
        registerForKeyboardNotifications()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 95
        options.append(contentsOf: createAddSiteOption())
    }
    
    private func registerCell() {
        tableView.register(UINib(nibName: "\(BasicAddTableViewCell.self)", bundle: nil), forCellReuseIdentifier: "\(BasicAddTableViewCell.self)")
        tableView.register(UINib(nibName: "\(AddSitetextViewTableViewCell.self)", bundle: nil), forCellReuseIdentifier: "\(AddSitetextViewTableViewCell.self)")
    }
    
    func createAddSiteOption() -> [AddSiteOptions] {
        return [AddSiteOptions(title: "URL", value: ""), AddSiteOptions(title: "Site Name", value: ""), AddSiteOptions(title: "Sector/Folder", value: ""), AddSiteOptions(title: "User Name", value: ""), AddSiteOptions(title: "Site Password", value: ""), AddSiteOptions(title: "Notes", value: "")]
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        let info = notification.userInfo!
        let keyboardSize:CGSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size
        var contentInsets:UIEdgeInsets
        contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
        tableView.contentInset = contentInsets
    }
    
    @objc func keyboardWillBeHidden(notification: Notification) {
        tableView.contentInset = .zero
    }
}

//MARK: UITableViewDatasource
extension AddSiteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = options[indexPath.row]
        switch indexPath.row {
        case OptionList.notes.rawValue:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "\(AddSitetextViewTableViewCell.self)") as? AddSitetextViewTableViewCell {
                cell.setUpCell(title: data.title, value: data.value)
                cell.valueTextView.tag = indexPath.row
                cell.valueTextView.delegate = self
                return cell
            }
        default:
            if let basiCell = tableView.dequeueReusableCell(withIdentifier: "\(BasicAddTableViewCell.self)") as? BasicAddTableViewCell {
                basiCell.setUpCell(title: data.title, value: data.value, isDropDown: (indexPath.row == OptionList.sectorOrFolder.rawValue), showEyeIcon: (indexPath.row == OptionList.sitePassword.rawValue))
                basiCell.valueTextField.delegate = self
                basiCell.valueTextField.tag = indexPath.row
                
                if indexPath.row == OptionList.sectorOrFolder.rawValue {
                    basiCell.dropDownTapped = { [weak self] in
                        self?.showActionSheet(indexPath: indexPath)
                        
                    }
                }
                return basiCell
            }
        }
        
        return UITableViewCell()
    }
    
    func showActionSheet(indexPath: IndexPath) {
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // create an action
        let firstAction: UIAlertAction = UIAlertAction(title: "Social Media", style: .default) { action -> Void in
            self.options[OptionList.sectorOrFolder.rawValue].value = "Social Media"
            self.tableView.reloadRows(at: [indexPath], with: .none)
        }
        
        let secondAction: UIAlertAction = UIAlertAction(title: "Bank Account", style: .default) { action -> Void in
            self.options[OptionList.sectorOrFolder.rawValue].value = "Bank Account"
            self.tableView.reloadRows(at: [indexPath], with: .none)
        }
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in }
        
        // add actions
        actionSheetController.addAction(firstAction)
        actionSheetController.addAction(secondAction)
        actionSheetController.addAction(cancelAction)
        
        present(actionSheetController, animated: true)
    }
}

//MARK: UITableViewDelegate Methods
extension AddSiteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension AddSiteViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        options[textField.tag].value = textField.text ?? ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension AddSiteViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        options[textView.tag].value = textView.text ?? ""
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
