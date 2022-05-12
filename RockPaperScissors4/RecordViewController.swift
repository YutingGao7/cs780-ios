//
//  RecordViewController.swift
//  RockPaperScissors4
//
//  Created by Candy Gao on 5/11/22.
//

import Foundation

import UIKit

class RecordViewController: UIViewController{
    
    @IBOutlet weak var userNameInput: UITextField!
    
    @IBOutlet weak var prompt: UILabel!
    
    @IBOutlet weak var confirmNameBtn: UIButton!
    
    @IBOutlet weak var viewScoreBtn: UIButton!
    
    @IBOutlet weak var playerName: UILabel!
    
    @IBAction func onConfirmName(_ sender: Any) {
        prompt.isHidden = false
        guard let userName: String = userNameInput.text else {
            prompt.text = "Error! Please enter a valid name."
            return
        }
        
        guard !userName.isEmpty else {
            prompt.text = "Name cannot be empty!"
            return
        }
        
        playerName.isHidden = false
        playerName.text = userName
        prompt.isHidden = true
        userNameInput.isHidden = true
        confirmNameBtn.isHidden = true
        viewScoreBtn.isHidden = false
        
        
    }
    @IBAction func onViewScorePressed(_ sender: Any) {
        performSegue(withIdentifier: "toScorefromUserInputSegue", sender: self)
    }
    
    override func viewDidLoad() {
        prompt.isHidden = true
        viewScoreBtn.isHidden = true
        playerName.isHidden = true
    }
}
