//
//  DarkBaseViewController.swift
//  Jogos!
//
//  Created by Rubens Paulico on 09/12/19.
//  Copyright © 2019 Kelvin Javorski Soares. All rights reserved.
//

import UIKit

class DarkBaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackgroundImageView()
        
        
        // Do any additional setup after loading the view.
    }
    
    
    func setupBackgroundImageView(){
        
        let backgroundImageView = UIImageView()
        
        let backgroundImage = UIImage(named: "bg2")
        
        backgroundImageView.image = backgroundImage
        
        backgroundImageView.contentMode =  .scaleAspectFill
        
        self.view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
        
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        let leadingConstraint = backgroundImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0)
        let trailingConstraint = backgroundImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0)
        let topConstraint = backgroundImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0)
        let bottomConstraint = backgroundImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
              NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
        
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
