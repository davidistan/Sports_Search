//
//  CollectionTableViewCell.swift
//  UIPractice
//
//  Created by David Tan on 8/10/20.
//  Copyright © 2020 David Tan. All rights reserved.
//

import UIKit

class CollectionTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var collectionView: UICollectionView!
    
    static let identifier = "CollectionTableViewCell"
    
    var previous: UICollectionViewCell?
    
    var first_load = false
    
    var name = "NBA"
    
    func configure(with topic: [Sports_Topics]) {
        self.topics = topic
        print("first config")
    }
    
    func configure(hasScrolled: UIScrollView, highlighted: String) {
        
        DispatchQueue.main.async {
            for cell in self.collectionView.visibleCells {
                let c = cell as! CollectionViewCell
                if (c.button.titleLabel!.text! != highlighted) {
                    c.backgroundColor = .white
                } else {
                    c.backgroundColor = .yellow
                }
            }
        }
    }
    
    func configure(with topic: [Sports_Topics], cell: CollectionViewCell, category: String) {
        for cell in self.collectionView.visibleCells {
            let c = cell as! CollectionViewCell
            if (c.button.titleLabel!.text! == category) {
                c.backgroundColor = .yellow
            } else {
                c.backgroundColor = .white
            }
        }
        
        name = category
        
        self.collectionView.reloadData()
    }
    
    func configure(with topic: [Sports_Topics], first_cell: CollectionTableViewCell, first: Bool) {
        self.topics = topic
        first_load = first
        print("first config: first cell")
    }
    
    
    var topics = [Sports_Topics]()
    
    static func nib() -> UINib {
        return UINib(nibName: "CollectionTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.register(CollectionViewCell.nib(), forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        topics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        cell.configure(with: topics[indexPath.row])
        if (first_load == true && indexPath.row == 0) {
            cell.backgroundColor = .yellow
            name = cell.button.titleLabel!.text!
            first_load = false
        } else {
            if (cell.button.titleLabel!.text! != name) {
                cell.backgroundColor = .white
                print("\(cell.button.titleLabel!.text!) is WHITE")
            } else if (cell.button.titleLabel!.text! == name) {
                cell.backgroundColor = .yellow
                print("\(cell.button.titleLabel!.text!) is YELLOW")
                name = cell.button.titleLabel!.text!
            }
        return cell
    }
    

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("VIEW IS SCROLLING")
        self.configure(hasScrolled: scrollView, highlighted: name)
    }
}
