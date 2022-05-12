
import UIKit



class RoundResultViewController: UIViewController, GameViewDelegate, FinalResultViewDelegate{

    @IBOutlet weak var roundField: UILabel!
    @IBOutlet weak var resultField: UILabel!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var historyInfo: UILabel!
    @IBOutlet weak var scoreBtn: UIButton!
    
    
    let game = GameInfo()
    let gameRecording = GameAggregate()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
        game.setPlayerInt(playerChoice)
        let roundInt: Int, roundResultText: String, aiChoice: String, extraRound: Bool
        (roundInt, roundResultText, aiChoice, extraRound) = game.getGameResult()
        
        displayRound(game.getPreviousRound())
        displayRoundResult(playerChoice, aiChoice, roundResultText)
        
        setButton(extraRound)
        
        
        switch roundInt {
        case 1:
            gameRecording.recordWin()
        case 0:
            gameRecording.recordTie()
        case -1:
            gameRecording.recordLose()
        default:
            print("error! un-recognized round result int: \(roundInt)")
        }
        
        historyInfo.isHidden = false
        historyInfo.text = game.getHistoryText()
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
        //print(segue.destination)
        if let finalResultVC = segue.destination as? FinalResultViewController {
            finalResultVC.delegate = self
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
    
    func storeScore(){
        print("storing score")
        let newScore = UserScore(context: context)
        var winNum: Int, tieNum: Int, lossNum: Int
        (winNum, tieNum, lossNum) = gameRecording.getUserScores()
        newScore.wins = Int16(winNum)
        newScore.ties = Int16(tieNum)
        newScore.losses = Int16(lossNum)
        
        //(newScore.wins, newScore.ties, newScore.losses) = Int32(gameRecording.getUserScores())
        print(gameRecording.getUserScores())

        do {
            try context.save()
        } catch {
        }
        
    }
    
    
}
