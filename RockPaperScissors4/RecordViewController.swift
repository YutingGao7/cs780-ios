//
//  RecordViewController.swift
//  RockPaperScissors4
//
//  Created by Candy Gao on 5/11/22.
//

import Foundation

import UIKit

class RecordViewController: UIViewController{
    
    
    @IBAction func onViewScorePressed(_ sender: Any) {
        performSegue(withIdentifier: "toScorefromUserInputSegue", sender: self)
    }
}
