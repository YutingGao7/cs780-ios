
import UIKit

protocol GameViewDelegate: AnyObject {
 func playerChoiceSet(_ playerChoice: String)
}

class GameViewController: UIViewController{
    
    weak var delegate: RoundResultViewController? = nil
    
    @IBOutlet weak var timerField: UILabel!
    @IBOutlet weak var roundField: UILabel!
    @IBOutlet weak var gameHistory: UILabel!
    
    var currentRound: Int = 0 //to store the currentRound# passes in by delegate
    var historyText: String = "History"
    var timer: Timer!
    var count: Float = 3.1
    
    @IBAction func buttonPressed(_ sender: UIButton){
        guard let playerChoice = sender.titleLabel?.text else {
            return
        }
        delegate?.playerChoiceSet(playerChoice)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func displayTimerField(){
        count -= 0.1
        timerField.text = String(format: "%.1f", count)
        
        if(count < 2){
            timerField.textColor = UIColor.red
        }
        
        if(count <= 0){
            timerField.text = "0.0"
            delegate?.playerChoiceSet("Invalid")
            dismiss(animated: true, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        roundField.text = "Round: \(currentRound)"
        gameHistory.text = historyText
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(displayTimerField), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
    }
    
    
}
