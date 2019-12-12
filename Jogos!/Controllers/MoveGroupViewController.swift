//
//  MoveGroupViewController.swift
//  Jogos!
//
//  Created by Kevin Ribeiro on 09/12/19.
//  Copyright © 2019 Kelvin Javorski Soares. All rights reserved.
//

import UIKit

class MoveGroupViewController: BaseViewController {
    
    @IBOutlet weak var windRoseImage: UIImageView!
    
    @IBOutlet weak var Nbutton: UIButton!
    @IBOutlet weak var NEbutton: UIButton!
    @IBOutlet weak var Ebutton: UIButton!
    @IBOutlet weak var SEbutton: UIButton!
    @IBOutlet weak var Sbutton: UIButton!
    @IBOutlet weak var SWbutton: UIButton!
    @IBOutlet weak var Wbutton: UIButton!
    @IBOutlet weak var NWbutton: UIButton!
    
    @IBOutlet weak var chooseDirectionButton: UIButton!
    
    var positionFlag : Int = 0
    
    func updateTurn(){
        GameManager.shared.dayTurnsLeft -= 1
        GameManager.shared.hasGameEnded()
        
    }
    @IBAction func Naction(_ sender: Any) {
        positionFlag = 1
        alphaAllDirectionButtons()
        Nbutton.alpha = 1.0
        chooseDirectionButton.isEnabled = true
    }
    @IBAction func NEaction(_ sender: Any) {
        positionFlag = 2
        alphaAllDirectionButtons()
        NEbutton.alpha = 1.0
        chooseDirectionButton.isEnabled = true
    }
    @IBAction func Eaction(_ sender: Any) {
        positionFlag = 3
        alphaAllDirectionButtons()
        Ebutton.alpha = 1.0
        chooseDirectionButton.isEnabled = true
    }
    @IBAction func SEaction(_ sender: Any) {
        positionFlag = 4
        alphaAllDirectionButtons()
        SEbutton.alpha = 1.0
        chooseDirectionButton.isEnabled = true
    }
    @IBAction func Saction(_ sender: Any) {
        positionFlag = 5
        alphaAllDirectionButtons()
        Sbutton.alpha = 1.0
        chooseDirectionButton.isEnabled = true
    }
    @IBAction func SWaction(_ sender: Any) {
        positionFlag = 6
        alphaAllDirectionButtons()
        SWbutton.alpha = 1.0
        chooseDirectionButton.isEnabled = true
    }
    @IBAction func Waction(_ sender: Any) {
        positionFlag = 7
        alphaAllDirectionButtons()
        Wbutton.alpha = 1.0
        chooseDirectionButton.isEnabled = true
    }
    @IBAction func NWaction(_ sender: Any) {
        positionFlag = 8
        alphaAllDirectionButtons()
        NWbutton.alpha = 1.0
        chooseDirectionButton.isEnabled = true
    }
    
    @IBAction func chooseDirectionAction(_ sender: Any) {
        switch positionFlag {
        case 1: GameManager.shared.navigator.moveGroup(to: .north)
            break
        case 2: GameManager.shared.navigator.moveGroup(to: .northeast)
            break
        case 3: GameManager.shared.navigator.moveGroup(to: .east)
            break
        case 4: GameManager.shared.navigator.moveGroup(to: .southeast)
            break
        case 5: GameManager.shared.navigator.moveGroup(to: .south)
            break
        case 6: GameManager.shared.navigator.moveGroup(to: .southwest)
            break
        case 7: GameManager.shared.navigator.moveGroup(to: .west)
            break
        case 8: GameManager.shared.navigator.moveGroup(to: .northwest)
            break
        default: GameManager.shared.navigator.moveGroup(to: .on)
        }
        
        updateTurn()
        
        
        if let vc = navigationController?.viewControllers.last(where: { $0.isKind(of: PassDeviceViewController.self) }) {
                    self.navigationController?.popToViewController(vc, animated: true)
                } else {
                    if let vc = storyboard?.instantiateViewController(identifier: "Pass Device") as? PassDeviceViewController {
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true, completion: nil)
                    }
                }
        
    }
    //gamemaneger.shared.currentplayer
    
    func alphaAllDirectionButtons() {
        Nbutton.alpha = 0.5
        NEbutton.alpha = 0.5
        NWbutton.alpha = 0.5
        Sbutton.alpha = 0.5
        SEbutton.alpha = 0.5
        SWbutton.alpha = 0.5
        Ebutton.alpha = 0.5
        Wbutton.alpha = 0.5
    }
    
    func enableButtons(){
        NEbutton.isUserInteractionEnabled = false
        NWbutton.isUserInteractionEnabled = false
        SEbutton.isUserInteractionEnabled = false
        SWbutton.isUserInteractionEnabled = false
        Nbutton.isUserInteractionEnabled = false
        Wbutton.isUserInteractionEnabled = false
        Sbutton.isUserInteractionEnabled = false
        Ebutton.isUserInteractionEnabled = false
        alphaAllDirectionButtons()
        
        let available = GameManager.shared.navigator.verifyNeighbor()
        for direction in available{
            switch direction {
            case .northwest:
                NWbutton.isUserInteractionEnabled = true
                NWbutton.alpha = 1
            case .north:
                Nbutton.isUserInteractionEnabled = true
                Nbutton.alpha = 1
            case .northeast:
            NEbutton.isUserInteractionEnabled = true
                NEbutton.alpha = 1
            case .west:
            Wbutton.isUserInteractionEnabled = true
                Wbutton.alpha = 1
            case .east:
            Ebutton.isUserInteractionEnabled = true
                Ebutton.alpha = 1
            case .southwest:
            SWbutton.isUserInteractionEnabled = true
                SWbutton.alpha = 1
            case .south:
            Sbutton.isUserInteractionEnabled = true
                Sbutton.alpha = 1
            case .southeast:
            SEbutton.isUserInteractionEnabled = true
                SEbutton.alpha = 1
            default:
                break
            }
        }
    }
    
    override func viewDidLoad() {
        enableButtons()
        if GameManager.shared.currentPlayer.alignment == .innocent {
            
            NEbutton.alpha = 0.5
            NWbutton.alpha = 0.5
            SEbutton.alpha = 0.5
            SWbutton.alpha = 0.5
            
            NEbutton.isUserInteractionEnabled = false
            NWbutton.isUserInteractionEnabled = false
            SEbutton.isUserInteractionEnabled = false
            SWbutton.isUserInteractionEnabled = false
            
            windRoseImage.image = UIImage(named: "turista")
        }
        else if GameManager.shared.currentPlayer.alignment == .murderer{
            
            windRoseImage.image = UIImage(named: "assassino")
        }
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        enableButtons()
        if GameManager.shared.currentPlayer.alignment == .innocent {
            
            NEbutton.alpha = 0.5
            NWbutton.alpha = 0.5
            SEbutton.alpha = 0.5
            SWbutton.alpha = 0.5
            
            NEbutton.isUserInteractionEnabled = false
            NWbutton.isUserInteractionEnabled = false
            SEbutton.isUserInteractionEnabled = false
            SWbutton.isUserInteractionEnabled = false
            
            windRoseImage.image = UIImage(named: "turista")
        }
        else if GameManager.shared.currentPlayer.alignment == .murderer{
            
            windRoseImage.image = UIImage(named: "assassino")
        }
        super.viewWillAppear(true)

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
