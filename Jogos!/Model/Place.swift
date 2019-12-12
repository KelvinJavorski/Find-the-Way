//
//  Place.swift
//  Jogos!
//
//  Created by Kaz Born on 27/11/19.
//  Copyright © 2019 Kelvin Javorski Soares. All rights reserved.
//

import Foundation

class Place {
	
	var name 	  : String = ""
	var imageName : String = ""

    var position : Position = Position(x: 0, y: 0)
	
	enum types {
		case spawn
		case trap
		case empty
		case misc
		case safehouse
	}
    
	var type : types = .empty
    
    init(){}
	
	init(name: String = "", imageName: String = "", type: types) {
		self.name  = name
		self.imageName = imageName
		self.type = type
	}
}
