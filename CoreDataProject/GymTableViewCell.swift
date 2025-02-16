//
//  GymTableViewCell.swift
//  CoreDataProject
//
//  Created by ednardo alves on 16/02/25.
//

import UIKit

class GymTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbCategoria: UILabel!
    @IBOutlet weak var lbTreino: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
