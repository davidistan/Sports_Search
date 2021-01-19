//
//  BigCollectionViewCell.swift
//  UIPractice
//
//  Created by David Tan on 8/11/20.
//  Copyright © 2020 David Tan. All rights reserved.
//

import UIKit

class BigCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!

    @IBOutlet weak var textView: UITextView!
    
    static let identifier = "BigCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "BigCollectionViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.autoresizingMask.update(with: self.autoresizingMask)
        self.contentView.translatesAutoresizingMaskIntoConstraints = true
        // Initialization code
    }
    
    public func configure(planet: Sports, category: String) {
        self.imageView.image = UIImage(named: planet.name)
        self.textView.text = planet.name
        let link = planet.url
        let alignment = NSMutableParagraphStyle()
        alignment.alignment = NSTextAlignment.center
        let textFont = UIFont.systemFont(ofSize: 10)
        var attributedString = NSAttributedString(string: link,
                                                  attributes: [ NSAttributedString.Key.paragraphStyle: alignment, NSAttributedString.Key.font: textFont])
        attributedString = NSAttributedString.makeHyperlink(for: link, in: planet.name, as: planet.name)
        self.textView.attributedText = attributedString
        self.textView.font = UIFont(name: "Size", size: 6)
        self.textView.textContainer.maximumNumberOfLines = 1
        
        
    }
    
    public func configure() {
        self.imageView.image = UIImage(named: "Blank")
        self.textView.text = ""
    }
    

}
