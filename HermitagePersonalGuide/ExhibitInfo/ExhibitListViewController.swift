//
//  ExhibitListViewController.swift
//  HermitagePersonalGuide
//
//  Created by Андрей on 21.10.2017.
//  Copyright © 2017 Ostrenkiy. All rights reserved.
//

import UIKit
import Nuke

class ExhibitListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    var pictures: [Picture] = []
    var hall: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        title = "Зал \(hall)"
        view.backgroundColor = appBackgroundColor
        tableView.backgroundColor = appBackgroundColor
        tableView.estimatedRowHeight = 115
        tableView.rowHeight = UITableViewAutomaticDimension
//        var ex1 = Exhibit()
//        ex1.name = "bkdjslfjlkfdjsdslgjslkdjglksdjglkjsdlkfjsldkjflksdjflkdsjf"
//        ex1.text = "dslgjslkdjglksdjglkjsdlkfjsldkjflksdjflkdsjfdslgjslkdjglksdjglkjsdlkfjsldkjflksdjflkdsjfdslgjslkdjglksdjglkjsdlkfjsldkjflksdjflkdsjfdslgjslkdjglksdjglkjsdlkfjsldkjflksdjflkdsjf"
//        exhibits.append(ex1)
    }
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ExhibitInfoViewController, let ex = sender as? Picture {
            vc.picture = ex
        }
     }
}

extension ExhibitListViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.performSegue(withIdentifier: "showExhibitInfo", sender: pictures[indexPath.row])
    }
}

extension ExhibitListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exhibitCell", for: indexPath) as! ExhibitTableViewCell
        
        if let url = pictures[indexPath.row].imageURL {
            Nuke.loadImage(with: url, into: cell.exhibitImageView)
        }

//        exhibits[indexPath.row].image = cell.exhibitImageView.image
        
        cell.exhibitCellName.text = pictures[indexPath.row].title
        return cell
    }
}
