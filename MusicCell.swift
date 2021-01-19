//
//  MusicCell.swift
//  UIPractice
//
//  Created by David Tan on 8/14/20.
//  Copyright © 2020 David Tan. All rights reserved.
//

import UIKit

class MusicCell: UICollectionViewCell {

    @IBOutlet weak var musicView: UIImageView!
    
    @IBOutlet weak var textView: UITextView!
    static let identifier = "MusicCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "MusicCell", bundle: nil)
    }
    
    public func configure(name: String, link: String) {
        print(self.musicView == nil)
        self.musicView.image = UIImage(named: name)
        self.textView.text = name
        
        let url = link
        let alignment = NSMutableParagraphStyle()
        alignment.alignment = NSTextAlignment.center
        let textFont = UIFont.systemFont(ofSize: 10)
        var attributedString = NSAttributedString(string: link,
                                                  attributes: [ NSAttributedString.Key.paragraphStyle: alignment, NSAttributedString.Key.font: textFont])
        attributedString = NSAttributedString.makeHyperlink(for: url, in: name, as: name)
        self.textView.attributedText = attributedString
        self.textView.font = UIFont(name: "Size", size: 12)
        self.textView.textContainer.maximumNumberOfLines = 1
    }

}
