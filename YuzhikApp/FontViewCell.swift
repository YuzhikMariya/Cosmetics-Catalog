//
//  FontViewCell.swift
//  YuzhikApp
//
//  Created by Admin on 26/02/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class FontViewCell: UITableViewCell {

    @IBOutlet weak var btn_Font: UIButton!
    @IBAction func click_Font(_ sender: Any) {
        print("click btn")
        if !btn_Font.isSelected{
            
            //refreshFonts(font: lbl_Font.text!)
           // btn_Font.isSelected = true
        }
    }
    
    @IBOutlet weak var lbl_Font: UILabel!
    
    func refreshFonts(font: String){
        lbl_Font.text = font
        btn_Font.isSelected = false
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
