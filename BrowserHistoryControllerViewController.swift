//
//  BrowserHistoryControllerViewController.swift
//  UIPractice
//
//  Created by David Tan on 8/24/20.
//  Copyright © 2020 David Tan. All rights reserved.
//

import UIKit
import RealmSwift

class BrowserHistoryControllerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate, BackToSearchDelegate {
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var searchHistory: UITextField!
    
    let realm = try! Realm()
    
    var results: Results<Browser>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        table.register(BrowserTableViewCell.nib(), forCellReuseIdentifier: BrowserTableViewCell.identifier)
        table.register(BackButton.nib(), forCellReuseIdentifier: BackButton.identifier)
        
        try! realm.write {
            results = realm.objects(Browser.self)
        }
        
        for result in results! {
            print("BROWSER HISTORY SEARCH: \(result.search)")
            print("BROWSER HISTORY URL: \(result.url)")
        }

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section < 1) {
            print("HISTORY COUNT: \(results!.count)")
            return results!.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section < 1) {
            let entry = results![indexPath.item].search
            let link = results![indexPath.item].url
            print("BROWSER HISTORY ENTRY: \(entry)")
            print("BROWSER HISTORY LINK: \(link)")
            let cell = table.dequeueReusableCell(withIdentifier: BrowserTableViewCell.identifier, for: indexPath) as! BrowserTableViewCell
            var cellText = "\(indexPath.item + 1). Search: \(entry), URL: "
            let start = cellText.count
            cellText.append(link)
            let attributedString = NSMutableAttributedString(string: cellText)
            attributedString.addAttribute(.link, value: link, range: NSRange(location: start, length: link.count))
            cell.textView.attributedText = attributedString
            cell.textView.font = UIFont(name: "Arial", size: 14)
            cell.textView.isEditable = false
            cell.textView.isSelectable = true
            return cell
        } else {
            let cell = table.dequeueReusableCell(withIdentifier: BackButton.identifier, for: indexPath) as! BackButton
            cell.back.center = CGPoint(x: cell.contentView.bounds.size.width/2,y: cell.contentView.bounds.size.height/2);
            cell.delegate = self
            return cell
        }
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        UIApplication.shared.open(URL)
        return false
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section < 1) {
            return "Browser History Results"
        } else {
            return nil
        }
    }
    
    func segue() {
        
        performSegue(withIdentifier: "backToSportsSearch", sender: nil)
        
    }
    
    
    
    @IBAction func deleteBrowserHistory(_ sender: Any) {
        
        try! realm.write {
            
            let result = realm.objects(Browser.self)
            realm.delete(result)
            
        }
        
        table.reloadData()
        
    }
    
    @IBAction func filterHistory(_ sender: Any) {
        
        let search = searchHistory.text!
        
        try! realm.write {
            
            results = realm.objects(Browser.self).filter("search CONTAINS[c] \"\(search)\" || url CONTAINS[c] \"\(search)\"")
            
        }
        
        table.reloadData()
        
    }
    
    @IBAction func resetHistory(_ sender: Any) {
        
        try! realm.write {
            
            results = realm.objects(Browser.self)
            
        }
        
        table.reloadData()
        
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
