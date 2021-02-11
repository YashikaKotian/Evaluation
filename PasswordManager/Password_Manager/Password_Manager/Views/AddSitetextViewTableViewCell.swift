//
//  AddSitetextViewTableViewCell.swift
//  Password_Manager
//
//  Created by Yashika on 1/11/20.
//  Copyright © 2020 Yashika. All rights reserved.
//

import UIKit

class AddSitetextViewTableViewCell: UITableViewCell {
    
    //MARK: Outlets
    
    @IBOutlet weak var titleLabe: UILabel!
    @IBOutlet weak var valueTextView: UITextView!
    
    func setUpCell(title: String, value: String) {
        titleLabe.text = title
        valueTextView.text = value
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addBorder()
    }
    
    func addBorder() {
        valueTextView.layer.borderColor = UIColor.hexFromString(hexa: "#F5F7FB").cgColor
        valueTextView.layer.cornerRadius = 4.0
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
