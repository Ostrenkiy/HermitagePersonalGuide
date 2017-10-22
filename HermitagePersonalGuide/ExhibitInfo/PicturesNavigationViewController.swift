//
//  PicturesNavigationViewController.swift
//  HermitagePersonalGuide
//
//  Created by Ostrenkiy on 22.10.2017.
//  Copyright © 2017 Ostrenkiy. All rights reserved.
//

import UIKit

class PicturesNavigationViewController: UINavigationController {

    var pictures: [Picture] = []
    var hall: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.barTintColor = appBackgroundColor
        navigationBar.tintColor = UIColor.white
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        if let root = viewControllers.first as? ExhibitListViewController {
            root.pictures = pictures
            root.hall = hall
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dvc = segue.destination as? ExhibitListViewController {
            dvc.pictures = pictures
            dvc.hall = hall
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
