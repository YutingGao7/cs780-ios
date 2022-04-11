
import UIKit

protocol FinalResultViewDelegate: AnyObject {
    func reloadView()
}


class FinalResultViewController: UIViewController{
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var greeting: UILabel!
    
    var totalWins: Int16 = 0
    var totalTies: Int16 = 0
    var totalLosses: Int16 = 0
    
    //weak var delegate: RoundResultViewController? = nil
    var greetingText: String = ""
    
    
    @IBAction func againPressed(_ sender: Any) {
        //poproot instntialize a new game
        //dismiss self
        //print("dismissing finalResult")
        //dismiss(animated: true, completion: nil)
        self.navigationController?.popToRootViewController(animated: true)
        let homePageVC = storyboard?.instantiateViewController(withIdentifier: "homePage") as! HomeViewController
        homePageVC.modalPresentationStyle = .fullScreen
        homePageVC.modalTransitionStyle = .crossDissolve
        present(homePageVC, animated: true)
    }
    
    
    @IBAction func quitePressed(_ sender: Any) {
        let newScore = UserScore(context: context)
        newScore.wins = totalWins
        newScore.ties = totalTies
        newScore.losses = totalLosses
        
        do {
            try context.save()
        } catch {
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        greeting.text = greetingText
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        delegate?.reloadView()
        self.navigationController?.popToRootViewController(animated: true)
        //print("called delegate")
    }
}
