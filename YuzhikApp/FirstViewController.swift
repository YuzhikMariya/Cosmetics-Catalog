//
//  FirstViewController.swift
//  YuzhikApp
//
//  Created by Admin on 16/02/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import AVKit

class FirstViewController: UIViewController {
    
    var cosmetics: Cosmetics = Cosmetics(), ru_cosmetics: Cosmetics = Cosmetics(), eng_cosmetics: Cosmetics = Cosmetics()

    @IBOutlet weak var lbl_Name: UILabel!
    @IBOutlet weak var img_Photo: UIImageView!
    @IBOutlet weak var lbl_Cost: UILabel!
    @IBOutlet weak var lbl_Brend: UILabel!
    @IBOutlet weak var lbl_Description: UILabel!
    
    @IBOutlet weak var sv_Scroll: UIScrollView!
    @IBOutlet weak var btn_ShowMovie: UIButton!
    
    @IBAction func showMovie(_ sender: Any) {

        if let path = Bundle.main.path(forResource: cosmetics.urlToVideo, ofType: "mp4"){
            let video = AVPlayer(url: URL(fileURLWithPath: path))
            let videoPlayer = AVPlayerViewController()
            videoPlayer.player = video
            
            present(videoPlayer, animated: true, completion: {
                video.play()
            })
        }
        else{
            let tit, mes: String
            if lang == "RU"{
                tit = "Извините"
                mes = "Нет видео"
            }
            else{
                tit = "Sorry"
                mes = "No video"
            }
            let alert = UIAlertController(title: tit, message: mes, preferredStyle: .alert)
            
            let btnOk = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(btnOk)
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        updateSettings_OneNote()
    }
    
    func updateSettings_OneNote(){
        readSettings()
        
        if lang == "RU"{
            btn_ShowMovie.setTitle("Смотреть", for: .normal)
            cosmetics = ru_cosmetics
        }
        else{
            btn_ShowMovie.setTitle("Show", for: .normal)
            cosmetics = eng_cosmetics
        }
        
        lbl_Cost.text = String(format: "%.2f", cosmetics.cost!)
        lbl_Brend.text = cosmetics.brend
        lbl_Description.text = cosmetics.description
        lbl_Name.text = cosmetics.name
        
        lbl_Cost.font = font_style
        lbl_Description.font = font_style
        
        
        if font_style?.fontName == "AppleSDGothicNeo-Thin"{
            lbl_Name.font = UIFont(name: "AppleSDGothicNeo-Bold", size: CGFloat(font_size + 6))
            lbl_Brend.font = UIFont.italicSystemFont(ofSize: CGFloat(font_size + 2))
            btn_ShowMovie.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: CGFloat(font_size + 4))
        }
        else{
            lbl_Name.font = UIFont(name: font_style!.fontName + "-Bold", size: CGFloat(font_size + 6))
            lbl_Brend.font = UIFont(name: font_style!.fontName + "-Italic", size: CGFloat(font_size + 2))
            btn_ShowMovie.titleLabel?.font = UIFont(name: font_style!.fontName + "-Bold", size: CGFloat(font_size + 4))
        }
        sv_Scroll.backgroundColor = background
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbl_Name.lineBreakMode = NSLineBreakMode.byWordWrapping
        lbl_Name.numberOfLines = 0
        
        if cosmetics.cost != nil{
            lbl_Cost.text = String(format: "%.2f", cosmetics.cost!)
        }
        lbl_Brend.text = cosmetics.brend
        lbl_Description.text = cosmetics.description
        
        lbl_Name.text = cosmetics.name
        if let img = UIImage(named: cosmetics.urlToImage ?? "default"){
            img_Photo.image = img
        }
        else{
            img_Photo.image = UIImage(named: "default")
        }
        
        centerLabel(lbl: lbl_Cost)
        centerLabel(lbl: lbl_Brend)
        centerLabel(lbl: lbl_Name)
    }
    
    func centerLabel(lbl: UILabel){
        lbl.textAlignment = NSTextAlignment.center
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
