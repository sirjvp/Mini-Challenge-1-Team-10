//
//  TaskModel.swift
//  Mini Challenge 1 Team 13
//
//  Created by Jonathan Valentino on 07/04/22.
//

import Foundation

struct Task{
    let task: String
    let due: String
//        let imageName: String
}

//enum TaskStatus{
//    case unlisted
//    case finished
//    case one
//    case three
//    case five
//}

//    let names = [
//        "Clarence",
//        "Marshal",
//        "Jonathan",
//        "Charisel",
//        "Yoppy"
//    ]
    
//    let data: [Task] = [
//        Task(task: "Clarence", due: "2014-05-20"),
//        Task(task: "Marshal", due: "2014-05-20"),
//        Task(task: "Jonathan", due: "2014-05-20"),
//        Task(task: "Charisel", due: "2014-05-20"),
//        Task(task: "Yoppy", due: "2014-05-20")
//    ]

//    func updateItem(item: TaskItem, newTask: String){
//        item.task = newTask
//
//        do {
//            try context.save()
//        }
//        catch {
//            //error
//        }
//    }

//    func createItem(task: String, diff: Int16, due: Date, status: String){
//        let newItem = TaskItem(context: context)
//        newItem.task = task
//        newItem.difficulty = diff
//        newItem.due = due
//        newItem.status = status
//        newItem.createdAt = Date()
//
//        do {
//            try context.save()
//            getAllItem()
//        }
//        catch {
//            //error
//        }
//    }

//func deleteItem(item: TaskItem){
//        context.delete(item)
//        
//        do {
//            try context.save()
//        }
//        catch {
//            //error
//        }
//    }

