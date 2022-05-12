
import UIKit


class RoundResultViewController: UIViewController, GameViewDelegate{

    @IBOutlet weak var roundField: UILabel!
    @IBOutlet weak var resultField: UILabel!
    @IBOutlet weak var historyInfo: UILabel!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var scoreBtn: UIButton!
    
    let game = GameInfo()
    
    //when play pressed, initiate gameView, set delegate, and display
    @IBAction func playPressed (_ sender: UIButton) {
        let gameVC = storyboard?.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        gameVC.delegate = self
        gameVC.currentRound = game.getCurrentRound()
        gameVC.historyText = game.getHistoryText()
        gameVC.modalPresentationStyle = .fullScreen
        gameVC.modalTransitionStyle = .crossDissolve
        present(gameVC, animated: true)
    }
    
    
    
    //gameView notifies this resultVC, part of delegate protocol
    //this function is called when the helper finishes the work
    func playerChoiceSet(_ playerChoice: String){
        //interact with model
        game.setPlayerInt(playerChoice)
        let roundInt: Int, roundResultText: String, aiChoice: String, extraRound: Bool
        (roundInt, roundResultText, aiChoice, extraRound) = game.getGameResult()
        
        //handle view display
        displayRound(game.getPreviousRound())
        displayRoundResult(playerChoice, aiChoice, roundResultText)
        historyInfo.isHidden = false
        historyInfo.text = game.getHistoryText()
        setButton(extraRound)
        
        //interact with semi-database, aka record global data
        recordToGameRecording(roundInt)
        
    }
    
    
    func displayRound(_ previousRound: Int){
        roundField.text = "Round: \(previousRound)"
        roundField.isHidden = false;
    }
    
    func displayRoundResult(_ playerChoice: String, _ aiChoice: String, _ roundResultText: String){
        resultField.text = "You: \(playerChoice) \nPhone: \(aiChoice)\nResult: \(roundResultText)"
        resultField.isHidden = false;
    }
    
    func setButton(_ needExtraRound: Bool){
        playBtn.setTitle("Next Round", for: .normal)
        if(needExtraRound && (game.getPreviousRound() >= game.TOTALROUND)){
            playBtn.setTitle("Final Round", for: .normal)
        }else if(!needExtraRound) {
            playBtn.isHidden = true;
            scoreBtn.isHidden = false;
            if(game.getFinalResultInt() == 1){
                scoreBtn.setTitle("You Won!", for: .normal)
            }else if(game.getFinalResultInt() == -1) {
                scoreBtn.setTitle("You Lose...", for: .normal)
            }
        }
    }
    
    
    @IBAction func scorePressed(_ sender: Any) {
        //performSegue(withIdentifier: "toFinalResultSegue", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let finalResultVC = segue.destination as? FinalResultViewController {
            //finalResultVC.delegate = self
            if(game.getFinalResultInt() == 1) {
                finalResultVC.greetingText = "Congratulations!"
            }else{
                finalResultVC.greetingText = "Almost there!"
            }
        }
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        resultField.isHidden = true;
        roundField.isHidden = true;
        scoreBtn.isHidden = true;
        historyInfo.isHidden = true
        
    }
    
    func recordToGameRecording(_ rountResultInt: Int){
        switch rountResultInt {
        case 1:
            GameAggregate.recordWin()
        case 0:
            GameAggregate.recordTie()
        case -1:
            GameAggregate.recordLose()
        default:
            print("error! un-recognized round result int: \(rountResultInt)")
        }
    }
    
}
