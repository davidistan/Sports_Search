//
//  BackButtonCell.swift
//  UIPractice
//
//  Created by David Tan on 8/24/20.
//  Copyright © 2020 David Tan. All rights reserved.
//

import UIKit



class BackButtonCell: UITableViewCell {
    
//    @IBOutlet weak var backToSportsSearch: UIButton!
    
    
    
    static let identifier = "BackButtonCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "BackButtonCell", bundle: nil)
    }
    
    @IBAction func backToSearch() {
        
    }
    
    
    
}
