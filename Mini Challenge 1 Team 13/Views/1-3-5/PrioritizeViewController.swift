//
//  1-3-5ViewController.swift
//  Mini Challenge 1 Team 13
//
//  Created by Jonathan Valentino on 11/04/22.
//

import UIKit

class PrioritizeViewController: UIViewController {
    
    @IBOutlet var tableHard: UITableView!
    @IBOutlet var tableMedium: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var models = [TaskItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        getHardTask()
        getMediumTask()
        
        tableHard.delegate = self
        tableHard.dataSource = self
        tableMedium.delegate = self
        tableMedium.dataSource = self
        self.tableHard.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.tableMedium.separatorStyle = UITableViewCell.SeparatorStyle.none

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func getEasyTask(){
        do {
            models = try context.fetch(TaskItem.fetchRequest())
//            models = models.filter {$0.status == "hard"}
            DispatchQueue.main.async {
                self.tableHard.reloadData()
            }
        }
        catch {
            //error
        }
    }
    
    func getMediumTask(){
        do {
            models = try context.fetch(TaskItem.fetchRequest())
            models = models.filter {$0.status == "medium"}
            DispatchQueue.main.async {
                self.tableMedium.reloadData()
            }
        }
        catch {
            //error
        }
    }
    
    func getHardTask(){
        do {
            models = try context.fetch(TaskItem.fetchRequest())
            models = models.filter {$0.status == "easy"}
//            DispatchQueue.main.async {
            
//                self.table.reloadData()
//            }
        }
        catch {
            //error
        }
    }
}

extension PrioritizeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped me!")
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "detailTask") as? DetailTaskViewController else {
            return
        }
        
        vc.navigationItem.largeTitleDisplayMode = .never
        
        let model = models[indexPath.row]
        vc.model = model
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}


extension PrioritizeViewController: UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
        
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Hard
        let cellHard = tableView.dequeueReusableCell(withIdentifier: "Hard", for: indexPath) as! CustomTableViewCell
            
        let task = models[indexPath.row]
        
        cellHard.task?.text = task.task
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        cellHard.due?.text = dateFormatter.string(from: task.due!)
 
        //Medium
//        let cellMedium = tableMedium.dequeueReusableCell(withIdentifier: "Task", for: indexPath) as! CustomTableViewCell
//
//        cellMedium.task?.text = task.task
//
//        cellMedium.due?.text = dateFormatter.string(from: task.due!)
        
        return cellHard
    }


}

