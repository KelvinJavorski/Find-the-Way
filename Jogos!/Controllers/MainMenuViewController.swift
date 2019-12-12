//
//  MainMenuViewController.swift
//  Jogos!
//
//  Created by Kaz Born on 28/11/19.
//  Copyright © 2019 Kelvin Javorski Soares. All rights reserved.
//

import UIKit

class MainMenuViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
	@IBAction func startGame(_ sender: UIButton) {
		if let vc = storyboard?.instantiateViewController(identifier: "Input Player Name") as? InputPlayersNameViewController {
			self.navigationController?.pushViewController(vc, animated: true)
		}
	}
	
	@IBAction func options(_ sender: UIButton) {
		if let vc = storyboard?.instantiateViewController(identifier: "Options") as? OptionsViewController {
			self.navigationController?.pushViewController(vc, animated: true)
		}
	}
	
	@IBAction func credits(_ sender: UIButton) {
		if let vc = storyboard?.instantiateViewController(identifier: "Credits") as? CreditsViewController {
			self.navigationController?.pushViewController(vc, animated: true)
		}
	}
	
	
}
