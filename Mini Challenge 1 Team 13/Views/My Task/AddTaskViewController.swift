//
//  AddTaskViewController.swift
//  Mini Challenge 1 Team 13
//
//  Created by Jonathan Valentino on 07/04/22.
//

import UIKit

protocol AddTaskViewControllerDelegate {
    func onSave()
}

class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var sectionControl: UISegmentedControl!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var delegate: AddTaskViewControllerDelegate?
    
    public var completion: ((String, Int16, Date, String) -> Void)?
    
    private var diff: Int16 = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        taskTextField.delegate = self
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
    
//    @objc func editingChanged(_ textField: UITextField) {
//            if textField.text?.count == 1 {
//                if textField.text?.first == " " {
//                    textField.text = ""
//                    return
//                }
//            }
//            guard
//                let habit = taskNameField.text, !habit.isEmpty
//            else {
//                addButton.isEnabled = false
//                navBar.topItem?.rightBarButtonItem?.isEnabled = false
//                return
//            }
//            addButton.isEnabled = true
//            navBar.topItem?.rightBarButtonItem?.isEnabled = true
//        }
    
    @IBAction func saveButton(_ sender: Any){
        let task = taskTextField.text!
        let diff = diff
        let due = datePicker.date
        let status = "unlisted"
        
        let newItem = TaskItem(context: context)
        newItem.task = task
        newItem.difficulty = diff
        newItem.due = due
        newItem.status = status
        newItem.createdAt = Date()
        
        do {
            try context.save()
        }
        catch {
            //error
        }
        
//        completion?(task, diff, due, status)
        
        delegate?.onSave()
        dismiss(animated: true, completion: nil)
        
//        let model = ViewController()
//        model.createItem()
        
//        dismiss(animated: true, completion: {
//            model.createItem(task: task)
//        })
        
//        if let vc = presentingViewController as? ViewController {
//            navigationController?.popViewController(animated: true)
//            dismiss(animated: true, completion: {
//                vc.createItem(task: task)
//            })
//        }

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        taskTextField.resignFirstResponder()
    }
    
}


extension AddTaskViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
}
