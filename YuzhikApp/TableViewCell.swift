//
//  TableViewCell.swift
//  YuzhikApp
//
//  Created by Admin on 16/02/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_Name: UILabel!
    @IBOutlet weak var lbl_Description: UILabel!
    @IBOutlet weak var lbl_Brend: UILabel!
    @IBOutlet weak var lbl_Cost: UILabel!
    @IBOutlet weak var img_Photo: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func updateSettings_Cell(){
        
        lbl_Description.font = font_style
        lbl_Cost.font = font_style
        
        if font_style?.fontName == "AppleSDGothicNeo-Thin"{
            lbl_Name.font = UIFont(name: "AppleSDGothicNeo-Bold", size: CGFloat(font_size + 4))
            lbl_Brend.font = UIFont.italicSystemFont(ofSize: CGFloat(font_size - 2))
            
        }
        else{
            lbl_Name.font = UIFont(name: font_style!.fontName + "-Bold", size: CGFloat(font_size + 4))
            lbl_Brend.font = UIFont(name: font_style!.fontName + "-Italic", size: CGFloat(font_size - 2))
        }

        self.backgroundColor = background
        
    }
    
    public func refresh(_ cosmetics: Cosmetics){
        lbl_Name.text = cosmetics.name
        lbl_Description.text = cosmetics.description
        lbl_Brend.text = cosmetics.brend
        if cosmetics.cost != nil{
            lbl_Cost.text = String(format: "%.2f", cosmetics.cost!)
        }
        
        if let img = UIImage(named: cosmetics.urlToImage ?? "default"){
            img_Photo.image = img
        }
        else{
            img_Photo.image = UIImage(named: "default")
        }
    }

}
