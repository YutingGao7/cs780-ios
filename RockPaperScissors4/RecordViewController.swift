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
    
    
    
    
    @IBAction func onConfirmName(_ sender: Any) {
        guard let userName: String = userNameInput.text else {
            prompt.text = "Error! Please enter a valid name."
            return
        }
        
        guard !userName.isEmpty else {
            prompt.text = "Name cannot be empty!"
            return
        }
        
        prompt.text = userName
    }
    @IBAction func onViewScorePressed(_ sender: Any) {
        performSegue(withIdentifier: "toScorefromUserInputSegue", sender: self)
    }
}
