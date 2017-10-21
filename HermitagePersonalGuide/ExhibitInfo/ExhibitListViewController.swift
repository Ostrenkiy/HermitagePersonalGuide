//
//  ExhibitListViewController.swift
//  HermitagePersonalGuide
//
//  Created by Андрей on 21.10.2017.
//  Copyright © 2017 Ostrenkiy. All rights reserved.
//

import UIKit

class ExhibitListViewController: UIViewController {
    var exhibits:[Exhibit] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var ex1 = Exhibit()
        ex1.name = "bkdjslfjlkfdjsdslgjslkdjglksdjglkjsdlkfjsldkjflksdjflkdsjf"
        ex1.text = "dslgjslkdjglksdjglkjsdlkfjsldkjflksdjflkdsjfdslgjslkdjglksdjglkjsdlkfjsldkjflksdjflkdsjfdslgjslkdjglksdjglkjsdlkfjsldkjflksdjflkdsjfdslgjslkdjglksdjglkjsdlkfjsldkjflksdjflkdsjf"
        exhibits.append(ex1)
    }
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ExhibitInfoViewController, let ex = sender as? Exhibit {
            vc.exhibit = ex
        }
     }
 
}

extension ExhibitListViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showExhibitInfo", sender: exhibits[indexPath.row])
    }
}

extension ExhibitListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exhibits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exhibitCell", for: indexPath) as! ExhibitTableViewCell
        cell.exhibitCellName.text = exhibits[indexPath.row].name
        //Тут должна быть подгрузка картинки
        return cell
    }
}

struct Exhibit {
    var pictureURL = ""
    var name = ""
    var text = ""
}
