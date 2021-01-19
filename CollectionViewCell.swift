//
//  CollectionViewCell.swift
//  UIPractice
//
//  Created by David Tan on 8/10/20.
//  Copyright © 2020 David Tan. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var button: UIButton!
    
    var delegate: tableChange?
    
    static func nib() -> UINib {
        return UINib(nibName: "CollectionViewCell", bundle: nil)
    }
    
    static let identifier = "CollectionViewCell"
    
    let nc = NotificationCenter.default
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(with topic: Sports_Topics) {
        self.button.setTitle(topic.topic, for: .normal)
        self.button.sizeToFit()
        
    }
    
    public func changeTextColor(text: String, button: sportsButton) {
        self.delegate?.tableChanged(button: button)
        nc.post(name: NSNotification.Name(rawValue: "buttonChanged"), object: nil, userInfo: ["cell" : self])
        
    }
    
    @IBAction func highlight(_ sender: sportsButton) {
        self.changeTextColor(text: "Pressed", button: sender)
    }

}
