//
//  ViewController.swift
//  RockPaperScissors4
//
//  Created by Candy Gao on 5/8/22.
//

import UIKit

class HomeViewController: UIViewController {

    
    @IBOutlet weak var gameName: UILabel!
    
    @IBAction func onClickStart(_ sender: Any) {
        self.performSegue(withIdentifier: "toRoundResultSegue", sender: self)
        //gameName.textColor = UIColor.red
    }
    
    @IBAction func onClickScore(_ sender: Any) {
        self.performSegue(withIdentifier: "toScoreSegue", sender: self)
    }
    @IBAction func onClickHelp(_ sender: Any) {
        self.performSegue(withIdentifier: "toHelpSegue", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

