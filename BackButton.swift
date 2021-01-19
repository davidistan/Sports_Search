//
//  BackButton.swift
//  UIPractice
//
//  Created by David Tan on 8/24/20.
//  Copyright © 2020 David Tan. All rights reserved.
//

import UIKit

class BackButton: UITableViewCell {
    
    @IBOutlet weak var back: UIButton!
    
    weak var delegate: BackToSearchDelegate?
    
    static let identifier = "BackButton"

    override func awakeFromNib() {
        super.awakeFromNib()
        self.autoresizesSubviews = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "BackButton", bundle: nil)
    }
    
    @IBAction func backToSportsSearch(_ sender: Any) {
        
        delegate?.segue()
        
    }
    
    
}

protocol BackToSearchDelegate: AnyObject {
    
    func segue()
    
}
