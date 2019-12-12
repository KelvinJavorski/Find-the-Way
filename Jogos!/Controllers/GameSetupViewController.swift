//
//  GameSetupViewController.swift
//  Jogos!
//
//  Created by Kaz Born on 28/11/19.
//  Copyright © 2019 Kelvin Javorski Soares. All rights reserved.
//

import UIKit

class GameSetupViewController: BaseViewController {

	let availablePlayersOption = [3,4,5]
    var numberOfPlayers = 0
    let picker = UIPickerView()
    let toolBar = UIToolbar()
    
	func refreshInterface () {
		// RELOAD INFO THAT SHOWS ONSCREEN
		
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.dataSource = self
        createNumberOfPlayersPicker()
        print(numberOfPlayers)
        
       refreshInterface()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		refreshInterface()
	}
    
//    @IBOutlet weak var confirmButton: UIButton!

	@IBAction func mainMenu(_ sender: UIButton) {
		self.navigationController?.popToRootViewController(animated: false)
	}
	
	@IBAction func startGame(_ sender: UIButton) {
		if let vc = storyboard?.instantiateViewController(identifier: "Input Player Name") as? InputPlayersNameViewController {
			self.navigationController?.pushViewController(vc, animated: true)
		}
	}
}

extension GameSetupViewController : UIPickerViewDataSource, UIPickerViewDelegate{
    
    func createNumberOfPlayersPicker(){
        //        picker.backgroundColor = .white
        picker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(picker)
        picker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        picker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        picker.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return availablePlayersOption.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        GameManager.shared.numberOfPlayers = numberOfPlayers
        return "\(availablePlayersOption[row])"
        
    }
}
