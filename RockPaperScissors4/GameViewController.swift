
import UIKit


protocol GameViewDelegate: AnyObject {
    func playerChoiceSet(_ playerChoice: String)
}


class GameViewController: UIViewController{
    
    weak var delegate: RoundResultViewController? = nil
    
    
    @IBOutlet weak var timer: UILabel!
    @IBOutlet weak var roundField: UILabel!
    @IBOutlet weak var gameHistory: UILabel!
    
    var currentRound: Int = 0 //to store the currentRound# passes in by delegate
    var historyText: String = "History"
    
    
    @IBAction func buttonPressed(_ sender: UIButton){
        guard let playerChoice = sender.titleLabel?.text else {
            return
        }
        delegate?.playerChoiceSet(playerChoice)
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        roundField.text = "Round: \(currentRound)"
        gameHistory.text = historyText
        //gameHistory.text =
    }
}
