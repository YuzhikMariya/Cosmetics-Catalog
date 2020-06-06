//
//  TableViewController.swift
//  YuzhikApp
//
//  Created by Admin on 16/02/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import FirebaseDatabase

class TableViewController: UITableViewController {

    
    @IBOutlet weak var itm_Filter: UIBarButtonItem!
    
    @IBOutlet var tblView: UITableView!
    @IBAction func click_deleteFilter(_ sender: Any) {
        isFilterChanged = false
        cosmeticsArray = fullCosmeticsArray
        tableView.reloadData()
        for i in 0...brendArray.count-1 {
            brendArray[i].isChecked = false
        }
        sortKind = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ref = Database.database().reference()
        print(ref.child("cosmetics/id"))
        readSettings()
        TableViewController.loadData(resourse: "ru_cosmetics")
        ru_cosmeticsArray = fullCosmeticsArray
        TableViewController.loadData(resourse: "eng_cosmetics")
        eng_cosmeticsArray = fullCosmeticsArray

        if lang == "RU"{
            fullCosmeticsArray = ru_cosmeticsArray
        }
        else{
            fullCosmeticsArray = eng_cosmeticsArray
        }
        cosmeticsArray = fullCosmeticsArray

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        updateSettings_AllList()
        if isFilterChanged{
            var newComsArr: [Cosmetics] = []
            if !checkedBrendsArray.isEmpty{
                for cosm in fullCosmeticsArray{
                    for brend in checkedBrendsArray{
                        if cosm.brend == brend{
                            newComsArr.append(cosm)
                        }
                    }
                }
            }
            else{
                newComsArr = fullCosmeticsArray
            }
            if sortKind > 0 {
                cosmeticsArray = newComsArr.sorted(by: { $0.cost! < $1.cost! })
            }
            else if sortKind < 0 {
                cosmeticsArray = newComsArr.sorted { $0.cost! > $1.cost! }
            }
            else{
                cosmeticsArray = newComsArr
            }
            tblView.reloadData()
        }
    }
    
    public static func loadData(resourse: String){
        if let url = Bundle.main.url(forResource: resourse, withExtension: "json"){
            let jsonData = url
            
            if let data = try? Data(contentsOf: jsonData){
                if let dictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? Array<[String: Any]>{

                        fullCosmeticsArray = []
                        for jsonElement in dictionary{

                            var csm = Cosmetics()

                            if jsonElement["id"] != nil{
                                
                                csm.id = jsonElement["id"] as? Int
                                csm.name = jsonElement["name"] as? String
                                csm.description = jsonElement["description"] as? String
                                csm.brend = jsonElement["brend"] as? String
                                csm.cost = jsonElement["cost"] as? Float
                                csm.urlToImage = jsonElement["urlToImage"] as? String
                                csm.urlToVideo = jsonElement["urlToVideo"] as? String
                                
                                fullCosmeticsArray.append(csm)
                                
                            }
                            
                        }
                    }
                    else{
                        print("bad")
                    }
            }
        }
    }
    
    func updateSettings_AllList(){
        readSettings()
        if lang == "RU"{
            itm_Filter.title = "Фильтр"
            
        }
        else{
            itm_Filter.title = "Filter"
        }
        tableView.backgroundColor = background
        tableView.reloadData()
    }
    
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cosmeticsArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? TableViewCell{
            
            let currentItem = cosmeticsArray[indexPath.row]
            cell.refresh(currentItem)
            cell.updateSettings_Cell()
            return cell
            
        }
        return UITableViewCell()
        
        
       
        
    }
    
    
    @IBAction func clickAdd(_ sender: Any) {
        performSegue(withIdentifier: "goToAdd", sender: self)    }
    
    @IBAction func clickFilter(_ sender: UIButton) {
        performSegue(withIdentifier: "goToFilter", sender: self)    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "goToOneNote", sender: self)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToOneNote"{
            if let indexPath = tableView.indexPathForSelectedRow{
                (segue.destination as? FirstViewController)?.cosmetics = cosmeticsArray[indexPath.row]
                let tempId = cosmeticsArray[indexPath.row].id
                for ru_c in ru_cosmeticsArray{
                    if ru_c.id == tempId{
                        (segue.destination as? FirstViewController)?.ru_cosmetics = ru_c
                    }
                }
                for eng_c in eng_cosmeticsArray{
                    if eng_c.id == tempId{
                        (segue.destination as? FirstViewController)?.eng_cosmetics = eng_c
                    }
                }
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */



}
