//
//  ActorTableViewCell.swift
//  Cinema
//
//  Created by Anderson Sprenger on 18/03/22.
//

import UIKit

class ActorTableViewCell: UITableViewCell {
    
    static let id = "ActorTableViewCell"

    @IBOutlet weak var actorName: UILabel!
    @IBOutlet weak var actorGender: UILabel!
    @IBOutlet weak var birthDate: UILabel!
    
}
