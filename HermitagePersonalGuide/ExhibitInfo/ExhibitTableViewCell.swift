//
//  ExhibitTableViewCell.swift
//  HermitagePersonalGuide
//
//  Created by Андрей on 21.10.2017.
//  Copyright © 2017 Ostrenkiy. All rights reserved.
//

import UIKit

class ExhibitTableViewCell: UITableViewCell {

    @IBOutlet var exhibitImageView: UIImageView!
    @IBOutlet var exhibitCellName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
