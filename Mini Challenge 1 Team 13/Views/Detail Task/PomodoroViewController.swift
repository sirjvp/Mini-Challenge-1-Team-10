//
//  PomodoroViewController.swift
//  Mini Challenge 1 Team 13
//
//  Created by Jonathan Valentino on 12/04/22.
//

import UIKit

class PomodoroViewController: UIViewController {

    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startAndBreak: UIButton!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var model: TaskItem = TaskItem()

    var timer:Timer = Timer()
    var count:Int = 0
    var timerCounting:Bool = false
    var counter: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = model.task
        taskName.text = "Do Your Work!"
        startAndBreak.setTitle("Start Working", for: .normal)
        timerLabel.text = makeTimeString(hours: 0, minutes: 25, seconds: 0)

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

    @IBAction func didTapStartAndBreak(_ sender:Any){
        if(timerCounting)
        {
            timer.invalidate()
            //break
            timerCounting = false
            startAndBreak.setTitle("Start Working", for: .normal)
            taskName.text = "Break ends in..."
            
            var breaktime = 0
            if(counter < 4)
            {
                timerLabel.text = makeTimeString(hours: 0, minutes: 5, seconds: 0)
                breaktime = 5 * 60
                counter += 1
            }else
            {
                timerLabel.text = makeTimeString(hours: 0, minutes: 15, seconds: 0)
                breaktime = 15 * 60
                counter = 0
            }
            count = breaktime
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerWatch), userInfo: nil, repeats: true)
        }
        else
        {
            timer.invalidate()
            //timer
            timerCounting = true
            startAndBreak.setTitle("Take A Break", for: .normal)
            taskName.text = "Do Your Work!"
            timerLabel.text = makeTimeString(hours: 0, minutes: 25, seconds: 0)
            count = 25 * 60
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerWatch), userInfo: nil, repeats: true)
        }
    }
    
    @objc func stopWatch() -> Void
    {
        count = count + 5
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

}
