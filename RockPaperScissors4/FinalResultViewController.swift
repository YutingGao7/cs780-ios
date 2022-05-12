
import UIKit


class FinalResultViewController: UIViewController{
    
    
    @IBOutlet weak var greeting: UILabel!
    
    var gameRecording = GameAggregate()
    var totalWins: Int16 = 0
    var totalTies: Int16 = 0
    var totalLosses: Int16 = 0
    
    var greetingText: String = ""
    
    
    @IBAction func againPressed(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        greeting.text = greetingText
    }
    
}
