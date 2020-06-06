//
//  Model.swift
//  YuzhikApp
//
//  Created by Admin on 16/02/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

var checkedBrendsArray :Array<String> = []
var isFilterChanged: Bool = false
var sortKind: Int = 0

struct Cosmetics : Decodable {
    var id: Int?
    var name: String?
    var description: String?
    var brend: String?
    var cost: Float?
    var urlToImage: String?
    var urlToVideo: String?

}

var fullCosmeticsArray: [Cosmetics] = [], cosmeticsArray: [Cosmetics] = [], ru_cosmeticsArray: [Cosmetics] = [], eng_cosmeticsArray: [Cosmetics] = []

struct Brend {
    var name: String
    var isChecked: Bool
}

var brendArray = [
    Brend(name: "Maybelline", isChecked: false),
    Brend(name: "Giorgio Armani", isChecked: false),
    Brend(name: "DIVAGE", isChecked: false),
    Brend(name: "Vivienne Sabo", isChecked: false),
    Brend(name: "L'Oreal Paris", isChecked: false),
    Brend(name: "Belita", isChecked: false),
    Brend(name: "Lancome", isChecked: false),
    Brend(name: "Givenchy", isChecked: false),
    Brend(name: "Bourjois", isChecked: false),
    Brend(name: "Max Factor", isChecked: false)
]
