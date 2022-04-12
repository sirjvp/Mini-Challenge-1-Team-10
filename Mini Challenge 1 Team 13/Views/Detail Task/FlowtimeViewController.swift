//
//  FlowtimeViewController.swift
//  Mini Challenge 1 Team 13
//
//  Created by Jonathan Valentino on 11/04/22.
//

import UserNotifications

import UIKit

class FlowtimeViewController: UIViewController {
    
    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startAndBreak: UIButton!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var model: TaskItem = TaskItem()

    var timer:Timer = Timer()
    var count:Int = 0
    var timerCounting:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        notification()
        title = model.task
        taskName.text = "Do Your Work!"
        startAndBreak.setTitle("Start Working", for: .normal)
        
    }
    
    @IBAction func finishButton(_ sender: Any){
        model.status = "finished"
        
        do {
            try context.save()
        }
        catch {
            //error
        }
        
//        navigationController?.popViewController(animated: true)
//        navigationController?.popViewController(animated: true)
//        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
//            self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func didTapStartAndBreak(_ sender:Any){
        if(timerCounting)
        {
            timer.invalidate()
            //break
            timerCounting = false
            startAndBreak.setTitle("Start Working", for: .normal)
            taskName.text = "Break ends in..."
            
            var breaktime = 0
            if(count < 25 * 60)
            {
                timerLabel.text = makeTimeString(hours: 0, minutes: 5, seconds: 0)
                breaktime = 5 * 60
            }else if(count >= 25 * 60 && count < 50 * 60)
            {
                timerLabel.text = makeTimeString(hours: 0, minutes: 8, seconds: 0)
                breaktime = 8 * 60
            }else if(count >= 50 * 60 && count < 90 * 60)
            {
                timerLabel.text = makeTimeString(hours: 0, minutes: 10, seconds: 0)
                breaktime = 10 * 60
            }else
            {
                timerLabel.text = makeTimeString(hours: 0, minutes: 15, seconds: 0)
                breaktime = 15 * 60
            }
            count = breaktime
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerWatch), userInfo: nil, repeats: true)
            notification()
        }
        else
        {
            timer.invalidate()
            //stopwatch
            timerCounting = true
            startAndBreak.setTitle("Take A Break", for: .normal)
            taskName.text = "Do Your Work!"
            count = 0
            timerLabel.text = makeTimeString(hours: 0, minutes: 0, seconds: 0)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(stopWatch), userInfo: nil, repeats: true)
            notification()
        }
    }
    
    @objc func stopWatch() -> Void
    {
        count = count + 300
        let time = secondsToHoursMinutesSeconds(seconds: count)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        timerLabel.text = timeString
    }
    
    @objc func timerWatch() -> Void
    {
        if(count > 0)
        {
            count = count - 1
        }
        let time = secondsToHoursMinutesSeconds(seconds: count)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        timerLabel.text = timeString
    }
    
    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int)
    {
        return ((seconds / 3600), ((seconds % 3600)/60), ((seconds % 3600) % 60))
    }
    
    func makeTimeString(hours: Int, minutes: Int, seconds: Int) -> String
    {
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += " : "
        timeString += String(format: "%02d", minutes)
        timeString += " : "
        timeString += String(format: "%02d", seconds)
        return timeString
    }

    @IBAction func notification() {
        // fire test notification
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge,. sound], completionHandler: { success, error in
            if success {
                self.scheduleTest()
                print("permission applied")
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
}
