//
//  OptionsViewController.swift
//  Jogos!
//
//  Created by Kaz Born on 28/11/19.
//  Copyright © 2019 Kelvin Javorski Soares. All rights reserved.
//

import UIKit

class OptionsViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
	@IBAction func mainMenu(_ sender: UIButton) {
		self.navigationController?.popToRootViewController(animated: true)
	}
	
	@IBAction func credits(_ sender: UIButton) {
		if let vc = storyboard?.instantiateViewController(identifier: "Credits") as? CreditsViewController {
			self.navigationController?.pushViewController(vc, animated: true)
		}
	}
	
   

}
