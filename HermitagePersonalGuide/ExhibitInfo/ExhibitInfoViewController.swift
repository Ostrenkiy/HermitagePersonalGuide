//
//  ExhibitInfoViewController.swift
//  HermitagePersonalGuide
//
//  Created by Андрей on 21.10.2017.
//  Copyright © 2017 Ostrenkiy. All rights reserved.
//

import UIKit
import Nuke

class ExhibitInfoViewController: UIViewController {
    var exhibit: Exhibit?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ExhibitInfoViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension ExhibitInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "pictureCell", for: indexPath) as! PictureTableViewCell
            Nuke.loadImage(with: URL(string: (exhibit?.pictureURL)!)!, into: cell.exhibitImageView)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath)
            cell.textLabel?.text = self.exhibit?.name
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "descriptionCell", for: indexPath)
            cell.textLabel?.text = self.exhibit?.text
            return cell
        }
    }
}
