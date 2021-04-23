//
//  GameTableViewCell.swift
//  MyGame
//
//  Created by Gilmar Queiroz on 22/04/21.
//  Copyright © 2021 Gilmar Queiroz. All rights reserved.
//

import UIKit

class GameTableViewCell: UITableViewCell {

    //MARK: - outlet
    @IBOutlet weak var ivCapa: UIImageView!
    @IBOutlet weak var lbGame: UILabel!
    @IBOutlet weak var lbConsole: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
