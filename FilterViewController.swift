//
//  FilterViewController.swift
//  UIPractice
//
//  Created by David Tan on 8/21/20.
//  Copyright © 2020 David Tan. All rights reserved.
//

import UIKit
import RealmSwift


class FilterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var filterDatabase: UITextField!
    @IBOutlet weak var table: UITableView!
    
    let realm = try! Realm()
    
    var filteredData = [(entry: String, category: String)]()
    
    var results: Results<Searches>?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        table.register(ResultsCell.nib(), forCellReuseIdentifier: ResultsCell.identifier)
        
        try! realm.write {
            results = realm.objects(Searches.self)
            
        }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func filterDatabase(_ sender: Any) {
        
        let text = filterDatabase.text ?? ""
        
        try! realm.write {
            let filtered = realm.objects(Searches.self).filter("searchEntry CONTAINS[c] \"\(text)\" || category CONTAINS[c] \"\(text)\"")
            print("FILTERED IS EMPTY: \(filtered.isEmpty)")
            results = filtered
            table.reloadData()
            
            
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (results!.count > 0) {
            return results!.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (results!.count > 0) {
            let cell = table.dequeueReusableCell(withIdentifier: ResultsCell.identifier, for: indexPath)
            let entry = results![indexPath.item].searchEntry
            let category = results![indexPath.item].category
            let numResults = results![indexPath.item].numberofResults
            cell.textLabel!.text = "\(indexPath.item + 1). Entry: \(entry), Category: \(category), Results: \(numResults)"
            cell.textLabel!.adjustsFontSizeToFitWidth = true
            return cell
        } else {
            let cell = table.dequeueReusableCell(withIdentifier: ResultsCell.identifier, for: indexPath)
            cell.textLabel!.text = "No Results"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Results"
    }
    
    @IBAction func reload(_ sender: Any) {
        try! realm.write {
            results = realm.objects(Searches.self)
            
        }
        
        filterDatabase.text = ""
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
