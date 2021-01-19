//
//  HomeScreenViewController.swift
//  UIPractice
//
//  Created by David Tan on 8/23/20.
//  Copyright © 2020 David Tan. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController {

    @IBOutlet weak var homeScreenImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.homeScreenImage.image = UIImage(named: "jlin")

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

}
