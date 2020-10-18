//
//  TeamTableViewCell.swift
//  Monsters
//
//  Created by Владислав Бочаров on 08.10.2020.
//

import UIKit

class TeamTableViewCell: UITableViewCell {

    @IBOutlet weak var imageMonster: UIImageView!
    @IBOutlet weak var desription: UILabel!
    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
