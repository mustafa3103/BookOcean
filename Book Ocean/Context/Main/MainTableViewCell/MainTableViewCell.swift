//
//  MainTableViewCell.swift
//  Book Ocean
//
//  Created by MUSTAFA PALA on 25.03.2023.
//

import UIKit

final class MainTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userComment: UILabel!
    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var bookName: UILabel!
    @IBOutlet weak var authorName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
