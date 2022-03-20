//
//  MovieCell.swift
//  Cinema
//
//  Created by Anderson Sprenger on 19/03/22.
//

import UIKit

class MovieCell: UITableViewCell {
    
    static let id = "MovieCell"

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var length: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var revenue: UILabel!
    @IBOutlet weak var productionCompany: UILabel!
    
}
