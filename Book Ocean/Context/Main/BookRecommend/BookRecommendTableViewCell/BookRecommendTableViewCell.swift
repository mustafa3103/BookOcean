//
//  BookRecommendTableViewCell.swift
//  Book Ocean
//
//  Created by Mustafa on 10.04.2023.
//

import UIKit

final class BookRecommendTableViewCell: UITableViewCell {

    @IBOutlet private var bookRecommendImageView: UIImageView!
    @IBOutlet private var bookRecomenndSubject: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(imageName: String, subject: String) {
        bookRecomenndSubject.text = subject
        bookRecommendImageView.image = UIImage(named: imageName)
    }
}
