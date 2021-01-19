//
//  MusicViewController.swift
//  UIPractice
//
//  Created by David Tan on 8/14/20.
//  Copyright © 2020 David Tan. All rights reserved.
//

import UIKit

class MusicViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var musicCollection: UICollectionView!
    var musicTypes = ["Blank"]
    var musicLinks = ["Blank"]
    override func viewDidLoad() {
        super.viewDidLoad()
        print("LOAD")
        
        musicCollection.dataSource = self
        musicCollection.delegate = self
        musicCollection.register(MusicCell.nib(), forCellWithReuseIdentifier: MusicCell.identifier)

        musicTypes = ["Spotify", "Apple Music", "Amazon Music", "Pandora", "Soundcloud", "YouTube Music"]
        
        musicLinks = ["https://www.spotify.com/us/", "https://www.apple.com/apple-music/", "https://music.amazon.com/home", "https://www.pandora.com", "https://soundcloud.com", "https://music.youtube.com/tasteprofile"]

        // Do any additional setup after loading the view.
    }
    
//    var count = 0
    
//    var newsTypes = ["Netflix", "Hulu", "Disney+", "HBO", "Showtime", "YouTube Red", "FOX", "TNT"]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        musicTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = musicCollection.dequeueReusableCell(withReuseIdentifier: MusicCell.identifier, for: indexPath) as! MusicCell
        let name = musicTypes[indexPath.section]
        let link = musicLinks[indexPath.section]
        cell.configure(name: name, link: link)
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
