//
//  ViewController.swift
//  Mini Challenge 1 Team 13
//
//  Created by Jonathan Valentino on 05/04/22.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var sectionControl: UISegmentedControl!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var models = [TaskItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAllItem()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    @IBAction func sectionChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            getAllItem()
            print("all")
            print(models)
        case 1:
            getUnlistedItem()
            print("unlisted")
            print(models)
        case 2:
            getFinishedItem()
            print("finished")
            print(models)
        default:
            getAllItem()
        }
    }
    
    @IBAction func notification() {
        // fire test notification
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge,. sound], completionHandler: { success, error in
            if success {
                self.scheduleTest()
            }
            else if error != nil {
                print("error occured")
            }
        })
    }
    
    func scheduleTest() {
        let content = UNMutableNotificationContent()
        content.title = "Hello World"
        content.sound = .default
        content.body = "My long body. My long body."
        
        let targetDate = Date().addingTimeInterval(10)
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: targetDate), repeats: false)
        
        let request = UNNotificationRequest(identifier: "some_long_id", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            if( error != nil){
                print("something went wrong")
            }
        })
    }
    
    //Core Data
    func getAllItem(){
        do {
            models = try context.fetch(TaskItem.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch {
            //error
        }
    }
    
    func getUnlistedItem(){
        do {
            models = try context.fetch(TaskItem.fetchRequest())
            models = models.filter {$0.status == "unlisted"}
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch {
            //error
        }
    }
    
    func getFinishedItem(){
        do {
            models = try context.fetch(TaskItem.fetchRequest())
            models = models.filter {$0.status == "finished"}
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch {
            //error
        }
    }
    
    
    @IBAction func didTapAdd() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "addTask") as? AddTaskViewController else {
            return
        }

        vc.delegate = self
        
//        vc.title = "Add Task"
//        vc.navigationItem.largeTitleDisplayMode = .never
//        vc.completion = { task, diff, due, status in
////            self.navigationController?.popToRootViewController(animated: true)
//            self.dismiss(animated: true, completion: nil)
////            let new = Task(task: task, due: due, identifier: "id_\(task)")
////            self.models.append(new)
//            self.getAllItem()
//        }
        self.present(vc, animated: true)
    }
}
    
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped me!")
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "detailTask") as? DetailTaskViewController else {
            return
        }
        
        vc.navigationItem.largeTitleDisplayMode = .never
        
        let model = models[indexPath.row]
        vc.model = model
        
//        vc.task = model.task!
//        vc.diff = model.difficulty
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        vc.due = dateFormatter.string(from: model.due!)
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}


extension ViewController: UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
        
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        let cell = tableView.dequeueReusableCell(withIdentifier: "Task", for: indexPath) as! CustomTableViewCell
            
        let task = models[indexPath.row]
        
        cell.task?.text = task.task
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        cell.due?.text = dateFormatter.string(from: task.due!)
 
//        cell.iconImageView.image = UIImage(named: task.imageName)

        return cell
        
    }
}

extension ViewController: AddTaskViewControllerDelegate {
    func onSave(){
        getAllItem()
    }
    
    func passOnEdit(){
        getAllItem()
    }
}
    
