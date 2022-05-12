
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
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    @IBAction func quitPressed(_ sender: UIButton) {
        print("quit pressed")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        delegate?.storeScore()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        greeting.text = greetingText
    }
    
}
