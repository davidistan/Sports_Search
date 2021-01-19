//
//  BrowserViewController.swift
//  UIPractice
//
//  Created by David Tan on 8/23/20.
//  Copyright © 2020 David Tan. All rights reserved.
//

import UIKit
import RealmSwift

class Browser: Object {
    @objc dynamic var search = ""
    @objc dynamic var url = ""
}

class BrowserViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var sportsHubLabel: UILabel!
    @IBOutlet weak var browserSearch: UISearchBar!
    @IBOutlet weak var go: UITextView!
    @IBOutlet weak var sportsHubView: UIImageView!
    
    var text = ""
    var link = ""
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sportsHubLabel.layer.cornerRadius = 5
        self.sportsHubView.image = UIImage(named: "jlin")
        print("IN BROWSER")
        browserSearch.autocapitalizationType = .none
        text = browserSearch.text!
        print("SEARCH WEB")
        if (text == "") {
            print("OPEN DUCKDUCKGO")
            link = "https://duckduckgo.com"
        } else if (text.contains("https://") == false) {
            var formattedText = ""
            for character in text {
                if (character != " ") {
                    formattedText.append(character)
                } else if (character == " ") {
                    formattedText.append("+")
                }
            }
            print("SEARCH DUCKDUCKGO")
            let search = "https://duckduckgo.com/?q="
            link = search + formattedText
        } else {
            print("OPEN WEBSITE")
            link = text
        }
        
        let alignment = NSMutableParagraphStyle()
        alignment.alignment = NSTextAlignment.center
        let textFont = UIFont.systemFont(ofSize: 32)
        var attributedString = NSAttributedString(string: link,
                                                  attributes: [ NSAttributedString.Key.paragraphStyle: alignment, NSAttributedString.Key.font: textFont])
        attributedString = NSAttributedString.makeHyperlink(for: link, in: go.text!, as: go.text!)
        self.go.attributedText = attributedString
        
        }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewDidLoad()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("SEARCH BUTTON CLICKED")
        var link = ""
        let search = searchBar.text!
        if (search == "") {
            link = "https://duckduckgo.com"
        } else if (search.contains("https://") == false) {
            var formattedText = ""
            for character in search {
                if (character != " ") {
                    formattedText.append(character)
                } else if (character == " ") {
                    formattedText.append("+")
                }
            }
            print("SEARCH DUCKDUCKGO")
            let browserEntry = "https://duckduckgo.com/?q="
            link = browserEntry + formattedText
        } else {
            link = search
        }
        
        print("SEARCH: \(search)")
        print("URL: \(link)")
        
        
        
        try! realm.write {
            let new_entry = Browser()
            new_entry.search = text
            new_entry.url = link
            realm.add(new_entry)
        }
    }
    
    @IBAction func saveToRealm() {
        try! realm.write {
            print("SAVE TO REALM")
            var link = ""
            let search = browserSearch.text!
            if (search == "") {
                link = "https://duckduckgo.com"
            } else if (search.contains("https://") == false) {
                var formattedText = ""
                for character in search {
                    if (character != " ") {
                        formattedText.append(character)
                    } else if (character == " ") {
                        formattedText.append("+")
                    }
                }
                let browserEntry = "https://duckduckgo.com/?q="
                link = browserEntry + formattedText
            } else {
                link = search
            }
        
            print("SEARCH: \(search)")
            print("URL: \(link)")
            let new_entry = Browser()
            new_entry.search = search
            new_entry.url = link
            realm.add(new_entry)
            }
    }
    
    
    
    

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


