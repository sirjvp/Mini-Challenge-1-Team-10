//
//  HelpViewController.swift
//  Mini Challenge 1 Team 13
//
//  Created by Jonathan Valentino on 08/04/22.
//

import UIKit

class HelpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func closeButton(_ sender: Any){
        //returns to the previous viewController
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
}
