
import UIKit

protocol FinalResultViewDelegate: AnyObject {
    func storeScore()

}


class FinalResultViewController: UIViewController{
    
    //weak var delegate: RoundResultViewController? = nil
    
    //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var greeting: UILabel!
    
    var gameRecording = GameAggregate()
    var totalWins: Int16 = 0
    var totalTies: Int16 = 0
    var totalLosses: Int16 = 0
    
    weak var delegate: RoundResultViewController? = nil
    var greetingText: String = ""
    
    
    @IBAction func againPressed(_ sender: Any) {
        //poproot instntialize a new game
        //dismiss self
        //print("dismissing finalResult")
        //dismiss(animated: true, completion: nil)
        //self.navigationController?.popToRootViewController(animated: true)
        //delegate?.modalVCDidCancel()
        navigationController?.popToRootViewController(animated: true)
        //navigationController?.popViewController(animated: true)
//        let homePageVC = storyboard?.instantiateViewController(withIdentifier: "homePage") as! HomeViewController
//        homePageVC.modalPresentationStyle = .fullScreen
//        homePageVC.modalTransitionStyle = .crossDissolve
//        present(homePageVC, animated: true)
    }
    
    
    @IBAction func quitPressed(_ sender: UIButton) {
        print("quit pressed")
        //delegate?.storeScore()
//        let newScore = UserScore(context: context)
//        newScore.wins = totalWins
//        newScore.ties = totalTies
//        newScore.losses = totalLosses
//        
//        do {
//            try context.save()
//        } catch {
//        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("notifying delegate")
        delegate?.storeScore()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        greeting.text = greetingText
        //self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
}
