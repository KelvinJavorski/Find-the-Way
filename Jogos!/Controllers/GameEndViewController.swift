//
//  GameEndViewController.swift
//  Jogos!
//
//  Created by Kaz Born on 28/11/19.
//  Copyright © 2019 Kelvin Javorski Soares. All rights reserved.
//

import UIKit

class GameEndViewController: BaseViewController {

	func refreshInterface () {
		// RELOAD INFO THAT SHOWS ONSCREEN
		
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		refreshInterface()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		refreshInterface()
	}
    

	@IBAction func mainMenu(_ sender: UIButton) {
		self.navigationController?.popToRootViewController(animated: true)
	}
	

}
