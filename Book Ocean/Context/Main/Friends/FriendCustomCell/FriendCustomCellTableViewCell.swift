//
//  FriendCustomCellTableViewCell.swift
//  Book Ocean
//
//  Created by Mustafa on 20.04.2023.
//

import UIKit

class FriendCustomCellTableViewCell: UITableViewCell {
    
    @IBOutlet var userName: UILabel!
    @IBOutlet var userSurname: UILabel!
    @IBOutlet var userEmail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
