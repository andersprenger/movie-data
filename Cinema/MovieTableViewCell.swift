//
//  MovieTableViewCell.swift
//  Cinema
//
//  Created by Anderson Sprenger on 17/03/22.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var length: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var revenue: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
