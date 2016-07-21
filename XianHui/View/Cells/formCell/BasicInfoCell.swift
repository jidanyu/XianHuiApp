//
//  BasicInfoCell.swift
//  DingDong
//
//  Created by Seppuu on 16/6/2.
//  Copyright © 2016年 seppuu. All rights reserved.
//

import UIKit

class BasicInfoCell: UITableViewCell ,UITextFieldDelegate{

    @IBOutlet weak var leftLabel: UILabel!
    
    @IBOutlet weak var rightTextField: UITextField!
    
    var hasTitle = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        rightTextField.delegate = self
        self.selectionStyle = .None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        if textField.text != "" {
            hasTitle = true
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
