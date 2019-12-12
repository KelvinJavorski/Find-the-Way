//
//  InputPlayersNameViewController.swift
//  Jogos!
//
//  Created by Kelvin Javorski Soares on 28/11/19.
//  Copyright © 2019 Kelvin Javorski Soares. All rights reserved.
//

import UIKit

class InputPlayersNameViewController: BaseViewController {
    
	// TEXTFIELDS OUTLETS
    @IBOutlet weak var player1TextField: UITextField!
	@IBOutlet weak var player2TextField: UITextField!
	@IBOutlet weak var player3TextField: UITextField!
	@IBOutlet weak var player4TextField: UITextField!
	@IBOutlet weak var player5TextField: UITextField!
	@IBOutlet weak var player6TextField: UITextField!
	@IBOutlet weak var player7TextField: UITextField!
	@IBOutlet weak var player8TextField: UITextField!
	
	// HAS PLAYER VIEWS
	@IBOutlet weak var player1View: RoundedCornerView!
	@IBOutlet weak var player2View: RoundedCornerView!
	@IBOutlet weak var player3View: RoundedCornerView!
	@IBOutlet weak var player4View: RoundedCornerView!
	@IBOutlet weak var player5View: RoundedCornerView!
	@IBOutlet weak var player6View: RoundedCornerView!
	@IBOutlet weak var player7View: RoundedCornerView!
	@IBOutlet weak var player8View: RoundedCornerView!
	
	// REMOVE PLAYER VIEW
	@IBOutlet weak var removePlayer1View: RoundedCornerView!
	@IBOutlet weak var removePlayer2View: RoundedCornerView!
	@IBOutlet weak var removePlayer3View: RoundedCornerView!
	@IBOutlet weak var removePlayer4View: RoundedCornerView!
	@IBOutlet weak var removePlayer5View: RoundedCornerView!
	@IBOutlet weak var removePlayer6View: RoundedCornerView!
	@IBOutlet weak var removePlayer7View: RoundedCornerView!
	@IBOutlet weak var removePlayer8View: RoundedCornerView!
	
    @IBOutlet weak var removePlayer1Button: UIButton!
    @IBOutlet weak var removePlayer2Button: UIButton!
    @IBOutlet weak var removePlayer3Button: UIButton!
    @IBOutlet weak var removePlayer4Button: UIButton!
    @IBOutlet weak var removePlayer5Button: UIButton!
    @IBOutlet weak var removePlayer6Button: UIButton!
    @IBOutlet weak var removePlayer7Button: UIButton!
    @IBOutlet weak var removePlayer8Button: UIButton!
    
    
    
    struct playerInput {
		var view : RoundedCornerView!
		var removeView : RoundedCornerView!
		var textField : UITextField!
        var removeButton : UIButton!
	}
	
	var playerInputs : [playerInput]!
    
	func refreshInterface () { // RELOAD INFO ON THE SCREEN
        for i in 0 ... 3{
            playerInputs[i].removeView.isHidden = true
        }
	}
	
    func updateNameCells () {
		var names = getNames()
		for i in 0 ... playerInputs.count - 1 {
			let playerInput = playerInputs[i]
			
			if names.count > 0 {
				let name = names[0]
				playerInput.textField.text 		= name
				playerInput.view.isHidden 		= false
				names.remove(at: 0)
            }
            else{
                playerInput.textField.text      = ""
            }
		}
	}
	
	func getNames () -> [String] {
		var names : [String] = []
		for playerInput in playerInputs {
			if playerInput.textField.text != "" {
				names.append(playerInput.textField.text!)
			}
		}
		return names
	}
	
	@IBAction func removePlayer(_ sender: UIButton) {
		playerInputs[sender.tag].textField.text = ""
        updateNameCells()
	}
	
//	@IBAction func startGame(_ sender: UIButton) {
//
////
////		if let vc = storyboard?.instantiateViewController(identifier: "Pass Device") as? PassDeviceViewController {
////			self.navigationController?.pushViewController(vc, animated: true)
////		}
//	}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Pass Device Segue"{
            let names = getNames()
            
            GameManager.shared.setupGame(playerNames: names)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
		
		playerInputs = [
			playerInput(view: player1View, removeView: removePlayer1View, textField: player1TextField, removeButton: removePlayer1Button),
			playerInput(view: player2View, removeView: removePlayer2View, textField: player2TextField, removeButton: removePlayer2Button),
			playerInput(view: player3View, removeView: removePlayer3View, textField: player3TextField, removeButton: removePlayer3Button),
			playerInput(view: player4View, removeView: removePlayer4View, textField: player4TextField, removeButton: removePlayer4Button),
			playerInput(view: player5View, removeView: removePlayer5View, textField: player5TextField, removeButton: removePlayer5Button),
			playerInput(view: player6View, removeView: removePlayer6View, textField: player6TextField, removeButton: removePlayer6Button),
			playerInput(view: player7View, removeView: removePlayer7View, textField: player7TextField, removeButton: removePlayer7Button),
			playerInput(view: player8View, removeView: removePlayer8View, textField: player8TextField, removeButton: removePlayer8Button)]
		
        refreshInterface()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        refreshInterface()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		refreshInterface()
	}
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
}

extension InputPlayersNameViewController : UITextFieldDelegate  {
	func textFieldDidEndEditing(_ textField: UITextField) {
		self.updateNameCells()
	}
}
