//
//  OnBoardingViewController.swift
//  Mini Challenge 1 Team 13
//
//  Created by Jonathan Valentino on 08/04/22.
//

import UIKit

class OnBoardingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func move(_ sender: Any){
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "dashboardTabBar") as? UIViewController else {
                return
            }
        
        UserDefaults.standard.hasOnboarded = true
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
    }

}
