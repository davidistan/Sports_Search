//
//  ViewController.swift
//  UIPractice
//
//  Created by David Tan on 8/10/20.
//  Copyright © 2020 David Tan. All rights reserved.
//

import UIKit
import RealmSwift

class Searches: Object {
    @objc dynamic var searchEntry = ""
    @objc dynamic var category = ""
    @objc dynamic var numberofResults = 0
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, tableChange {

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var deleteHistory: UIBarButtonItem!
    
    @IBOutlet weak var openBrowser: UIBarButtonItem!
    @IBOutlet weak var searchHistory: UIBarButtonItem!
    
    @IBOutlet weak var saveSearch: UIBarButtonItem!
    
    
    
    
    var button_Change = false
    
    var marked_cell: CollectionViewCell?
    
    var marked = false
    
    var textHasChanged = false
    
    var searchBarText: String = ""
    
    let realm = try! Realm()
    
    var topics = [Sports_Topics]()
    var count = 0
    let cell = CollectionViewCell()
    
    var scrollButton: sportsButton?
    
    var first_load = true
    
    var searchCount = 0
    var currentCount = 0
    
    var nba = [Sports(name: "Playoffs", number: 0, url: "https://www.nba.com/playoffs"), Sports(name: "Standings", number: 1, url: "https://stats.nba.com/standings/"), Sports(name: "Scores", number: 2, url: "https://www.nba.com/scores#/"), Sports(name: "Highlights",
                                                                                                                                                                                                                                                           number: 3, url: "https://bleacherreport.com/house-of-highlights"), Sports(name: "Draft", number: 4, url: "https://www.nba.com/draft"),Sports(name: "Free Agency", number: 5, url: "https://www.nba.com/freeagents"), Sports(name: "Eastern Conference", number: 6, url: "https://www.espn.com/nba/teams"),
                                                                                                                                                                                                                                                                                                                              Sports(name: "Western Conference", number: 7, url: "https://www.espn.com/nba/teams")]
    
    var nfl = [Sports(name: "NFL Scores", number: 0, url: "https://www.nfl.com/schedules/2020/REG1/"), Sports(name: "NFL Playoffs", number: 1, url: "https://www.nfl.com/playoffs/playoff-picture"), Sports(name: "AFC", number: 2, url: "https://www.nfl.com/standings/"), Sports(name: "NFC", number: 3, url: "https://www.nfl.com/standings/conference/2019/reg/"), Sports(name: "NFL Draft", number: 4, url: "https://www.nfl.com/draft/"), Sports(name: "NFL Free Agency", number: 5, url: "https://www.nfl.com/free-agency/"), Sports(name: "Stats", number: 6, url: "https://www.nfl.com/stats/player-stats/"), Sports(name: "Awards", number: 7, url: "https://www.nfl.com/honors/")]
    var wnba = [Sports(name: "WNBA Scores", number: 0, url: "https://www.wnba.com/scores/#/08/21/2020"),Sports(name: "WNBA Playoffs", number: 1, url: "https://www.wnba.com/wnba-playoffs-2019/"),Sports(name: "Rankings", number: 2, url: "https://www.wnba.com/standings/#?season=2020"), Sports(name: "All-Star Game", number: 3, url: "https://www.wnba.com/wnba-all-star-2019/"), Sports(name: "LA Sparks", number: 4, url: "https://sparks.wnba.com"), Sports(name: "Indiana Fever", number: 5, url: "https://fever.wnba.com"), Sports(name: "Las Vegas Aces", number: 6, url: "https://aces.wnba.com"), Sports(name: "Washington Mystics", number: 7, url: "https://mystics.wnba.com")]
    var mlb = [Sports(name: "MLB Scores", number: 0, url: "https://www.mlb.com/scores"), Sports(name: "MLB Standings", number: 1, url: "https://www.mlb.com/standings"), Sports(name: "MLB Playoffs", number: 2, url: "https://www.mlb.com/news/mlb-announces-expanded-playoffs-for-2020"), Sports(name: "MLB Draft", number: 3, url: "https://www.mlb.com/draft/tracker"), Sports(name: "MLB Awards", number: 4, url: "https://www.mlb.com/awards"), Sports(name: "World Series", number: 5, url: "http://mlb.mlb.com/mlb/history/postseason/mlb_ws.jsp?feature=club_champs"), Sports(name: "American League", number: 6, url: "https://www.mlb.com/team"), Sports(name: "National League", number: 7, url: "https://www.mlb.com/team")]
    var other_sports = [Sports(name: "Tennis", number: 0, url: "https://www.tennis.com"), Sports(name:"Golf", number: 1, url: "https://www.golfchannel.com"), Sports(name: "UFC", number: 2, url: "https://www.ufc.com"), Sports(name: "Premier League", number: 3, url: "https://www.premierleague.com"), Sports(name: "NHL", number: 4, url: "https://www.nhl.com"), Sports(name: "NASCAR", number: 5, url: "https://www.nascar.com"), Sports(name: "Rugby", number: 6, url: "http://www.rugbyworldcup.com/2021"), Sports(name: "Fencing", number: 7, url: "https://www.usafencing.org")]
    
//    :- USE 2D ARRAY NEXT TIME IF YOU WANT TO BE ABLE TO USE indexPath.section AND
//    indexPath.item FOR ITERATION IN CELL FOR ITEM AT METHOD
//    HAVING 2 ROWS REQUIRES A 2D ARRAY
    
    var selected_images: [Sports]?
    
    var image_category = "NBA"
    
    var searchedImages: [Sports]?
    
    
    override func viewDidLoad() {
        print("LOAD")
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        search.delegate = self
        search.autocapitalizationType = .none
        selected_images = nba
        searchCount = selected_images!.count
        NotificationCenter.default.addObserver(self, selector: #selector(self.incomingNotification(_:)), name:  NSNotification.Name(rawValue: "buttonChanged"), object: nil)
        super.viewDidLoad()
        topics.append(Sports_Topics(topic: "NBA", current: false))
        topics.append(Sports_Topics(topic: "NFL", current: false))
        topics.append(Sports_Topics(topic: "WNBA", current: false))
        topics.append(Sports_Topics(topic: "MLB", current: false))
        topics.append(Sports_Topics(topic: "Other Sports", current: false))
        // Do any additional setup after loading the view.
        table.register(CollectionTableViewCell.nib(), forCellReuseIdentifier: CollectionTableViewCell.identifier)
        table.delegate = self
        table.dataSource = self
        collectionView.register(BigCollectionViewCell.nib(), forCellWithReuseIdentifier: BigCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        self.view.backgroundColor = .white
        
        self.deleteHistory.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Arial", size: 12.5)!], for: .normal)
        self.openBrowser.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Arial", size: 12.5)!], for: .normal)
        self.searchHistory.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Arial", size: 12.5)!], for: .normal)
        self.saveSearch.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Arial", size: 12.5)!], for: .normal)


    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as! CollectionTableViewCell
        if (button_Change == true) {
            cell.configure(with: topics, cell: marked_cell!, category: image_category)
            button_Change = false
        } else {
            if (first_load == true && indexPath.row == 0) {
                cell.configure(with: topics, first_cell: cell, first: first_load)
                cell.backgroundColor = .yellow
            } else {
                cell.configure(with: topics)
            }
            first_load = false
            
        }
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var value = 0
        
        if (indexPath.section == 0) {
            value = indexPath.item
        } else if (indexPath.item == 0 && indexPath.section > 0) {
            value = indexPath.section * 2
        } else {
            value = indexPath.item + (indexPath.section * 2)
        }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BigCollectionViewCell.identifier, for: indexPath) as! BigCollectionViewCell
        
        if (value < selected_images!.count) {
            cell.configure(planet: selected_images![value], category: image_category)
            cell.textView.font = UIFont(name: "Size", size: 10)
            cell.textView.textAlignment = .center
                currentCount = currentCount - 1
            
        } else {
            cell.configure()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 125, height: 125)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 40, bottom: 20, right: 40)
    }
    
    func tableChanged(button: sportsButton) {
        self.viewDidLoad()
    }
    
    func modifyResults(images: [Sports]) {
        count = 0
        var results: [Sports] = []
        var isEmpty = false
        if (searchBarText == "") {
            searchCount = selected_images!.count
            isEmpty = true
            
        } else {
            for image in selected_images! {
                if (image.name.contains(searchBarText) == false) {
                    searchCount = searchCount - 1
                } else if (image.name.contains(searchBarText)) {
                    results.append(image)
            }
            }
        }
        
        if (isEmpty == false) {
            selected_images = results
        }
        currentCount = searchCount
        count = 0
        collectionView.reloadData()
        
    }
    
    func buttonTitle(cell: CollectionViewCell) {
        button_Change = true
        scrollButton = cell.button as! sportsButton
        table.reloadData()
        count = 0
        if (cell.button.titleLabel!.text == "NBA") {
            selected_images = nba
            image_category = "NBA"
        } else if (cell.button.titleLabel!.text == "NFL") {
            selected_images = nfl
            image_category = "NFL"
        } else if (cell.button.titleLabel!.text == "WNBA") {
            selected_images = wnba
            image_category = "WNBA"
        } else if (cell.button.titleLabel!.text == "MLB") {
            selected_images = mlb
            image_category = "MLB"
        } else if (cell.button.titleLabel!.text == "Other Sports") {
            selected_images = other_sports
            image_category = "Other Sports"
        }
        searchCount = selected_images!.count
        currentCount = searchCount
        count = 0
        collectionView.reloadData()
    }
    
    @IBAction func Save(_ sender: Any) {
        print("Save")
        try! realm.write {
            let entry = Searches()
            entry.searchEntry = searchBarText
            entry.category = image_category
            entry.numberofResults = selected_images!.count
            realm.add(entry)
        }
    }
    
    @IBAction func DeleteAll(_ sender: Any) {
        print("Delete")
        try! realm.write {
                    realm.deleteAll()
                }
    }

    @IBAction func Filter(_ sender: Any) {
        
    }
    
    @objc func incomingNotification(_ notification: Notification) {
        let userInfo = notification.userInfo
        marked_cell = userInfo!["cell"] as! CollectionViewCell
        self.buttonTitle(cell: userInfo!["cell"] as! CollectionViewCell)
        marked = true
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (marked == false) {
            selected_images = nba
            image_category = "NBA"
            searchCount = selected_images!.count
        } else if (marked == false && textHasChanged == true) {
            selected_images = nba
            image_category = "NBA"
            searchCount = selected_images!.count
        } else {
            buttonTitle(cell: marked_cell!)
        }
        
        textHasChanged = true
        searchBarText = searchText
        self.modifyResults(images: selected_images!)
    }

    


}





