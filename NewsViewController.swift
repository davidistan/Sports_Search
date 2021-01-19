//
//  NewsViewController.swift
//  UIPractice
//
//  Created by David Tan on 8/14/20.
//  Copyright © 2020 David Tan. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var newsCollection: UICollectionView!
    
    var newsTypes: [String] = ["Blank"]
    var newsLinks = ["Blank"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        newsCollection.dataSource = self
        newsCollection.delegate = self
        newsCollection.register(NewsCell.nib(), forCellWithReuseIdentifier: NewsCell.identifier)
        
        newsTypes = ["Netflix", "Hulu", "Disney+", "HBO", "Showtime", "YouTube Red", "FOX", "TNT"]
        
        newsLinks = ["https://www.netflix.com", "https://www.hulu.com/welcome", "https://www.disneyplus.com", "https://www.hbo.com", "https://www.sho.com", "https://www.youtube.com/premium", "https://www.fox.com/live/channel/WRAZ/", "https://www.tntdrama.com"]

        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        newsTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = newsCollection.dequeueReusableCell(withReuseIdentifier: NewsCell.identifier, for: indexPath) as! NewsCell
        let name = newsTypes[indexPath.section]
        cell.configure(name: name, url: newsLinks[indexPath.section])
        cell.textView.font = UIFont(name: "Size", size: 16)
        cell.textView.textAlignment = .center
        
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 250, height: 300)
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
