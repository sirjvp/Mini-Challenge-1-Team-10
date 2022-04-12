//
//  CustomTableViewCell.swift
//  Mini Challenge 1 Team 13
//
//  Created by Jonathan Valentino on 06/04/22.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

//    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var task: UILabel!
    @IBOutlet weak var due: UILabel!
    @IBOutlet weak var view: UIView!
    
    
    override func awakeFromNib() {
       view.layer.borderWidth = 1
       view.layer.cornerRadius = 20
//    view.layer.borderColor = UIColor.red.cgColor
    }

}
