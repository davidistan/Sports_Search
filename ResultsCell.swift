//
//  ResultsCell.swift
//  UIPractice
//
//  Created by David Tan on 8/21/20.
//  Copyright © 2020 David Tan. All rights reserved.
//

import UIKit

class ResultsCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
    
    static let identifier = "ResultsCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "ResultsCell", bundle: nil)
    }
    
}
