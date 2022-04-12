//
//  EditTaskViewController.swift
//  Mini Challenge 1 Team 13
//
//  Created by Jonathan Valentino on 11/04/22.
//

import UIKit

class EditTaskViewController: UIViewController {
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var sectionControl: UISegmentedControl!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    public var completion: ((String, Int16, Date) -> Void)?
    
    private var diff: Int16 = 1
    
    var model: TaskItem = TaskItem()

    override func viewDidLoad() {
        super.viewDidLoad()

        taskTextField.delegate = self
        taskTextField.text = model.task
        datePicker.date = model.due!
        sectionControl.selectedSegmentIndex = Int(model.difficulty) - 1
        diff = model.difficulty
    }
    
    @IBAction func closeModal(_ sender: Any) {
//        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sectionChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            diff = 1
            print("Easy")
        case 1:
            diff = 2
            print("Medium")
        case 2:
            diff = 3
            print("Hard")
        default:
            diff = 1
        }
    }

    @IBAction func saveButton(_ sender: Any){
        let task = taskTextField.text!
        let diff = diff
        let due = datePicker.date
        
        model.task = task
        model.difficulty = diff
        model.due = due
        
        do {
            try context.save()
        }
        catch {
            //error
        }
        
        completion?(task, diff, due)
    }
}

extension EditTaskViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
}
