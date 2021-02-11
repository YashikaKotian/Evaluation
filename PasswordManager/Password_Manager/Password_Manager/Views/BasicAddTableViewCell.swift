//
//  BasicAddTableViewCell.swift
//  Password_Manager
//
//  Created by Yashika on 1/11/20.
//  Copyright © 2020 Yashika. All rights reserved.
//

import UIKit

class BasicAddTableViewCell: UITableViewCell {
    
    //MaRK:Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var eyeButton: UIButton!
    
    var dropDownTapped:  (()-> Void)?
    @IBAction func rightButtonTapped(_ sender: UIButton) {
        dropDownTapped?()
    }
    
    @IBAction func eyeButtonTapped(_ sender: UIButton) {
        valueTextField.isSecureTextEntry = !valueTextField.isSecureTextEntry
        if valueTextField.isSecureTextEntry {
            eyeButton.setImage(UIImage(named: "eye_on"),  for: .normal)
        } else {
            eyeButton.setImage(UIImage(named: "eye_close"), for: .normal)
        }
    }
    
    func setUpCell(title: String, value: String, isDropDown: Bool, showEyeIcon: Bool) {
        titleLabel.text = title
        valueTextField.text = value
        rightButton.isHidden = !isDropDown
        eyeButton.isHidden = !showEyeIcon
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
