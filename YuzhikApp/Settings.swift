//
//  Settings.swift
//  YuzhikApp
//
//  Created by Admin on 02/03/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit

let settingsFileName = "config"

var lang = "RU"
var background = UIColor(red: 0, green: 0, blue: 0, alpha: 1)

var font_size = 14.0
var font_style = UIFont(name: "AppleSDGothicNeo-Thin", size: 14.0)



public extension UIColor {
    
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)

        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }

        var color: UInt32 = 0
        scanner.scanHexInt32(&color)

        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask

        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0

        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }

    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0

        getRed(&r, green: &g, blue: &b, alpha: &a)

        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0

        return String(format:"#%06x", rgb)
    }
    
}



func readSettings(){
    
    if let path = Bundle.main.path(forResource: settingsFileName, ofType: "json") {
        do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: [])
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: [])
                if let settings = jsonResult as? [String: String]{
                    
                    lang = settings["lang"] ?? "ENG"
                    
                    background = UIColor(hexString: settings["background"] ?? "0x00000000")
                    
                    font_size = Double(settings["font_size"] ?? "14.0")!
                    
                    font_style = UIFont(name: settings["font_style"] ?? "AppleSDGothicNeo-Thin", size: CGFloat(font_size))
                    
            }
        }
        catch {
               print("No such file or data isnt correct!")
        }
    }

}


func writeSettings(){
    
    
    let dictonary : [String : String] = [
        "lang" : lang,
        "font_size" : String(font_size),
        "font_style" : font_style!.fontName,
        "background" : background.toHexString()
    ]
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: dictonary, options: .prettyPrinted)

        let path = Bundle.main.path(forResource: settingsFileName, ofType: "json")!
        try jsonData.write(to: URL(fileURLWithPath: path))

        
    } catch {
        print("Can't write settings")
    }
    
}
