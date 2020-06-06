//
//  FilterViewController.swift
//  YuzhikApp
//
//  Created by Admin on 19/02/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import Firebase

class FilterViewController: UIViewController {

    

    
    @IBOutlet weak var btn_NoSort: UIButton!
    @IBOutlet weak var btn_PureSort: UIButton!
    @IBOutlet weak var btn_ExpensSort: UIButton!
    
    @IBAction func click_noSort(_ sender: Any) {
        if !btn_NoSort.isSelected{
            btn_NoSort.isSelected = true
            btn_PureSort.isSelected = false
            btn_ExpensSort.isSelected = false
        }
        sortKind = 0
    }
    
    
    @IBAction func click_pureSort(_ sender: Any) {
        if !btn_PureSort.isSelected{
            btn_NoSort.isSelected = false
            btn_PureSort.isSelected = true
            btn_ExpensSort.isSelected = false
        }
        sortKind = 1
        
    }
    
    
    @IBAction func click_expensSort(_ sender: Any) {
        if !btn_ExpensSort.isSelected{
            btn_NoSort.isSelected = false
            btn_PureSort.isSelected = false
            btn_ExpensSort.isSelected = true
        }
        sortKind = -1
        
    }
    
    
    
    @IBOutlet weak var tv_Brends: UITableView!
    @IBOutlet weak var btn_Brends: UIButton!
    
    @IBOutlet weak var lbl_KindOfSort: UILabel!
    @IBOutlet weak var lbl_NoSort: UILabel!
    @IBOutlet weak var lbl_PureSort: UILabel!
    @IBOutlet weak var lbl_ExpensSort: UILabel!
    

    @IBOutlet weak var btn_Filter: UIButton!
    
    @IBAction func click_Filter(_ sender: Any) {
        isFilterChanged = true
        checkedBrendsArray = []
        for brend in brendArray{
            if brend.isChecked{
                checkedBrendsArray.append(brend.name)
            }
        }
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tv_Brends.isHidden = true
        if sortKind > 0{
            click_pureSort(self)
        }
        else if sortKind < 0{
            click_expensSort(self)
        }
        else{
            click_noSort(self)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("did appear filter")
        updateSettings_Filter()
    }
    
    
    @IBAction func click_Brends(_ sender: Any) {
        UIView.animate(withDuration: 0.3){
            self.tv_Brends.isHidden = !self.tv_Brends.isHidden
        }
    }
    
    func updateSettings_Filter(){
        readSettings()
        if lang == "RU"{
            btn_Brends.setTitle("Бренды", for: .normal)
            btn_Filter.setTitle("Фильтровать", for: .normal)
            lbl_KindOfSort.text = "Как сортировать"
            lbl_NoSort.text = "Не сортировать"
            lbl_PureSort.text = "Сначала дешевые"
            lbl_ExpensSort.text = "Сначала дорогие"
        }
        else{
            btn_Brends.setTitle("Brends", for: .normal)
            btn_Filter.setTitle("Filter", for: .normal)
            lbl_KindOfSort.text = "Kind of sort"
            lbl_NoSort.text = "Don't sort"
            lbl_PureSort.text = "Cheap first"
            lbl_ExpensSort.text = "Expensive first"
        }
        lbl_NoSort.font = font_style
        lbl_PureSort.font = font_style
        lbl_ExpensSort.font = font_style
        
        if font_style?.fontName == "AppleSDGothicNeo-Thin"{
            btn_Brends.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: CGFloat(font_size + 2))
            lbl_KindOfSort.font = UIFont(name: "AppleSDGothicNeo-Bold", size: CGFloat(font_size + 2))
            btn_Filter.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: CGFloat(font_size + 4))
        }
        else{
            btn_Brends.titleLabel?.font = UIFont(name: font_style!.fontName + "-Bold", size: CGFloat(font_size + 2))
            lbl_KindOfSort.font = UIFont(name: font_style!.fontName + "-Bold", size: CGFloat(font_size + 2))
            btn_Filter.titleLabel?.font = UIFont(name: font_style!.fontName + "-Bold", size: CGFloat(font_size + 4))
        }
        self.view.backgroundColor = background
        btn_Filter.backgroundColor = background
        tv_Brends.reloadData()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FilterViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        brendArray[indexPath.row].isChecked = !brendArray[indexPath.row].isChecked
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return brendArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "brendCell", for: indexPath)
        let currBrend = brendArray[indexPath.row]
        cell.textLabel?.text = currBrend.name
        if currBrend.isChecked {
            cell.accessoryType = .checkmark
        }
        else{
            cell.accessoryType = .none
        }
        cell.textLabel?.font = font_style
        return cell
    }
}
