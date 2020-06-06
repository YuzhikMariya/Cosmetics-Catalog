//
//  AddCosmeticsViewController.swift
//  YuzhikApp
//
//  Created by Admin on 21/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class AddCosmeticsViewController: UIViewController {

    @IBOutlet weak var edtName: UITextField!
    
    @IBOutlet weak var edtBrend: UITextField!
    
    @IBOutlet weak var edtCost: UITextField!
    
    @IBOutlet weak var edtDescription: UITextField!
    @IBOutlet weak var edtImage: UITextField!
    
    @IBOutlet weak var edtVideo: UITextField!
    
    @IBOutlet weak var btnAdd: UIButton!
    
    @IBAction func addClick(_ sender: Any) {
        var tempCosmetics: Cosmetics = Cosmetics()
        tempCosmetics.name = edtName.text
        tempCosmetics.brend = edtBrend.text
        let numberFormatter = NumberFormatter()
        let number = numberFormatter.number(from: edtCost.text ?? "0")
        let numberFloatValue = number?.floatValue
        tempCosmetics.cost = numberFloatValue
        tempCosmetics.description = edtDescription.text
        tempCosmetics.urlToImage = edtImage.text
        tempCosmetics.urlToVideo = edtVideo.text
        tempCosmetics.id = fullCosmeticsArray.count + 1
        
        print(fullCosmeticsArray.count, eng_cosmeticsArray.count, ru_cosmeticsArray.count)
        
        fullCosmeticsArray.append(tempCosmetics)
        
        eng_cosmeticsArray.append(tempCosmetics)
        ru_cosmeticsArray.append(tempCosmetics)
        print(fullCosmeticsArray.count, eng_cosmeticsArray.count, ru_cosmeticsArray.count)

        var text = "["
        for el in fullCosmeticsArray{
            text += "{"
            text += "\"id\":" + String(el.id!) + ","
            text += "\"name\":\"" + (el.name ?? "No name") + "\","
            text += "\"description\":\"" + (el.description ?? "No description") + "\","
            text += "\"brend\":\"" + (el.brend ?? "No brend") + "\","
            text += "\"cost\":" + String(el.cost ?? 0.0) + ","
            text += "\"urlToImage\":\"" + (el.urlToImage ?? "") + "\","
            text += "\"urlToVideo\":\"" + (el.urlToVideo ?? "") + "\"}"
            if(el.id != fullCosmeticsArray.count){
                text += ","
            }
            
        }
        text += "]"
        if let url = Bundle.main.url(forResource: "ru_cosmetics", withExtension: "json")  {
            do {
                print("temppppppppppppppppppppppppppppp")
                try text.write(to: url, atomically: false, encoding: .utf8)
                  
            }
                catch {
                print("error")
            }
        }
        if let url = Bundle.main.url(forResource: "eng_cosmetics", withExtension: "json")  {
            do {
                print("temppppppppppppppppppppppppppppp")
                try text.write(to: url, atomically: false, encoding: .utf8)
                  
            }
                catch {
                print("error")
            }
        }
       // print(fullCosmeticsArray.description)
        //self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
