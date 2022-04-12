//
//  DetailTaskViewController.swift
//  Mini Challenge 1 Team 13
//
//  Created by Jonathan Valentino on 09/04/22.
//

import UIKit

class DetailTaskViewController: UIViewController {
    
    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var difficulty: UILabel!
    @IBOutlet weak var deadline: UILabel!
    @IBOutlet weak var toggle: UIButton!
    @IBOutlet weak var sectionControl: UISegmentedControl!
    @IBOutlet weak var techniqueInfo: UILabel!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var model: TaskItem = TaskItem()
    
    private var work: Int = 1
    let flowtimeHelp =  NSMutableAttributedString()
            .normal("Flowtime is great for task that needs ")
            .bold("a longer period of thinking time ")
            .normal("and")
            .bold(" uses your creativity to finish. ")
            .normal("\n\nEnjoy your task ")
            .bold("without interruption")
            .normal(" while still considering your break time.")


    let pomodoroHelp = NSMutableAttributedString()
        .normal("Pomodoro is great for task that is ")
        .bold("a chore")
        .normal(" and ")
        .bold("repetitive.")
        .normal("\n\nForce yourself to finish the task by ")
        .bold("weaving your work and break time.")
    
//    var task: String = ""
//    var diff: Int16 = 0
//    var due: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        techniqueInfo?.attributedText = flowtimeHelp
        createBarButtonItem()
        updateText()
    }
    
    @IBAction func sectionChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
//            flowtimeHelp = "Flowtime"
            techniqueInfo?.attributedText = flowtimeHelp
            print("Flowtime")
            work = 1
        case 1:
//            pomodoroHelp = "Pomodoro"
            techniqueInfo?.attributedText = pomodoroHelp
            print("Pomodoro")
            work = 2
        default:
            techniqueInfo?.attributedText = flowtimeHelp
        }
    }
    
    func createBarButtonItem(){
        let editPullDownButton = UIButton()
        editPullDownButton.setImage(UIImage(systemName: "togglepower"), for: .normal)
                
        let edit = UIAction(title: "Edit Task", image: UIImage(systemName: "pencil"), handler: { _ in self.editTask() })
        let delete = UIAction(title: "Delete Task", image: UIImage(systemName: "trash"), attributes: .destructive ,handler: { _ in self.removeTask() })
        let menu = UIMenu(children: [edit, delete])
        editPullDownButton.menu = menu
        editPullDownButton.showsMenuAsPrimaryAction = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: editPullDownButton)
    }
    
    @IBAction func startButton(_ sender: Any){
        if(work == 1)
        {
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "flowtime") as? FlowtimeViewController else {
                    return
                }
            
            vc.model = model
            navigationController?.pushViewController(vc, animated: true)
        }else
        {
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "pomodoro") as? PomodoroViewController else {
                    return
                }
            
            vc.model = model
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    @IBAction func finishButton(_ sender: Any){
        model.status = "finished"
        
        do {
            try context.save()
        }
        catch {
            //error
        }
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    func editTask(){
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "editTask") as? EditTaskViewController else {
                return
            }
        
        vc.completion = { task, diff, due in
            self.dismiss(animated: true, completion: nil)
            self.updateText()
        }
        
        vc.model = model
        self.present(vc, animated: true)
    }
    
    func removeTask(){
        context.delete(model)
        
        do {
            try context.save()
        }
        catch {
            //error
        }
        
        navigationController?.popToRootViewController(animated: true)
        
    }
    
    func updateText(){
        taskName.text = model.task
        
        if(model.difficulty == 2){
            difficulty.text = "Medium"
        }else if(model.difficulty == 3){
            difficulty.text = "Hard"
        }else{
            difficulty.text = "Easy"
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let due = dateFormatter.string(from: model.due!)
        deadline.text = "Deadline: " + due
    }
}
