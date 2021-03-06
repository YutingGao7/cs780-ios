
import UIKit

class ScoreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var tableView: UITableView!
    
    
    private var models = [UserScore]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //title = "History Scores"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        getAllScores()
        self.navigationItem.setHidesBackButton(true, animated: true)
        //tableView.backgroundColor = UIColor(red: 28, green: 55, blue: 62, alpha: 1)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let name: String = model.name!
        cell.textLabel?.text = "\(name), Wins: \(model.wins), Losses: \(model.losses), Ties: \(model.ties)"

        return cell
    }

    func getAllScores() {
        do {
            models = try context.fetch(UserScore.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
        }
    }
    
    
    @IBAction func onClickClear(_ sender: Any) {
        do {
            try context.execute(UserScore.deleteRequest())
            getAllScores()
        } catch {
        }
    }
}
