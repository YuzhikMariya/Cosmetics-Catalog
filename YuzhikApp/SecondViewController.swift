//
//  SecondViewController.swift
//  YuzhikApp
//
//  Created by Admin on 06/02/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    struct Font {
        var name: String
        var isChecked: Bool
    }
    
    var fontStyleArray = [
        Font(name: "AppleSDGothicNeo-Thin", isChecked: true),
        Font(name: "Cochin", isChecked: false),
        Font(name: "Didot", isChecked: false),
        Font(name: "EuphemiaUCAS", isChecked: false),
        Font(name: "GillSans", isChecked: false),
        Font(name: "HelveticaNeue", isChecked: false),
        Font(name: "TrebuchetMS", isChecked: false)
    ]
    
    let colorArray = [
        UIColor(red: 0, green: 0, blue: 0, alpha: 1),
        UIColor(red: 0.96, green: 0.77, blue: 0.95, alpha: 1),
        UIColor(red: 0.64, green: 0.75, blue: 1, alpha: 1),
        UIColor(red: 0.64, green: 0.64, blue: 1, alpha: 1),
        UIColor(red: 1, green: 0.93, blue: 0.73, alpha: 1),
        UIColor(red: 1, green: 1, blue: 1, alpha: 1)]
    
    var indColor = 0;
    
    @IBOutlet weak var btn_Ru: UIButton!
    @IBOutlet weak var btn_Eng: UIButton!
    @IBOutlet weak var lbl_FontSize: UILabel!
    
    @IBOutlet weak var sldr_FontSize: UISlider!
    
    @IBOutlet weak var btn_Color: UIButton!
    @IBOutlet weak var tv_Fonts: UITableView!
    


    @IBOutlet weak var lbl_FontStyle: UILabel!
    @IBOutlet weak var lbl_FontColor: UILabel!
    
    @IBOutlet weak var lbl_RU: UILabel!
    
    @IBOutlet weak var lbl_ENG: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sldr_FontSize.minimumValue = 10
        sldr_FontSize.maximumValue = 36
        readSettings()
        for i in 0 ... fontStyleArray.count - 1{
            if fontStyleArray[i].name == font_style?.fontName{
                fontStyleArray[i].isChecked = true
            }
            else{
                fontStyleArray[i].isChecked = false
            }
        }
        sldr_FontSize.value = Float(font_size)
        updateSettings_Settings()
        lbl_FontSize.font = font_style
        if lang == "RU"{
            clickRu(btn_Ru)
        }
        else{
            clickEng(btn_Eng)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        writeSettings()
        if lang == "RU"{
            fullCosmeticsArray = ru_cosmeticsArray
        }
        else{
            fullCosmeticsArray = eng_cosmeticsArray
        }
        cosmeticsArray = fullCosmeticsArray
    }
    
    func updateSettings_Settings(){

        tv_Fonts.reloadData()
        lbl_FontStyle.font = font_style
        lbl_FontColor.font = font_style
        lbl_RU.font = font_style
        lbl_ENG.font = font_style
        btn_Color.titleLabel?.font = font_style
    }
    
    @IBAction func slider_FontSize(_ sender: UISlider) {
        lbl_FontSize.font = lbl_FontSize.font.withSize(CGFloat(sender.value))
        font_size = Double(sender.value)
        font_style = UIFont(name: font_style!.fontName, size: CGFloat(sender.value))
        updateSettings_Settings()
    }
    
    @IBAction func click_Color(_ sender: UIButton) {
        indColor = (indColor + 1) % colorArray.count
        sender.backgroundColor = colorArray[indColor]
        background = colorArray[indColor]
        if indColor == 0 {
            sender.setTitleColor(UIColor.white, for: .normal)
        }
        else{
            sender.setTitleColor(UIColor.black, for: .normal)
        }
    }
   
    @IBAction func clickRu(_ sender: UIButton) {
        if !btn_Ru.isSelected{
            btn_Eng.isSelected = false
            btn_Ru.isSelected = true
            lang = "RU"
            lbl_FontStyle.text = "Стиль шрифта"
            lbl_FontColor.text = "Цвет фона"
            lbl_FontSize.text = "Размер шрифта"
            btn_Color.setTitle("Тыкни сюда", for: .normal)
        }
    }
    
    @IBAction func clickEng(_ sender: UIButton) {
        if !btn_Eng.isSelected{
            btn_Ru.isSelected = false
            btn_Eng.isSelected = true
            lang = "ENG"
            lbl_FontStyle.text = "Font Style"
            lbl_FontColor.text = "Background Color"
            lbl_FontSize.text = "Font Size"
            btn_Color.setTitle("Tap here", for: .normal)
        }
       
    }

}

extension SecondViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        for i in 0 ... fontStyleArray.count-1 {
            fontStyleArray[i].isChecked = false
        }
        fontStyleArray[indexPath.row].isChecked = !fontStyleArray[indexPath.row].isChecked
        font_style = UIFont(name: fontStyleArray[indexPath.row].name, size: CGFloat(font_size))
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        tableView.reloadData()
        updateSettings_Settings()
        lbl_FontSize.font = font_style
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fontStyleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fontCell", for: indexPath)
        let currFont = fontStyleArray[indexPath.row]
        cell.textLabel?.text = currFont.name
        cell.textLabel?.font = UIFont(name: currFont.name, size: CGFloat(font_size))
        if currFont.isChecked {
            cell.accessoryType = .checkmark
        }
        else{
            cell.accessoryType = .none
        }
        return cell
    }}
