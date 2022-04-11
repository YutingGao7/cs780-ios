
import UIKit

protocol FinalResultViewDelegate: AnyObject {
    func reloadView()
}


class FinalResultViewController: UIViewController{
    
    @IBOutlet weak var greeting: UILabel!
    
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
