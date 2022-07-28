//
//  MainTableViewCell.swift
//  MobiMovie
//
//  Created by Narkoz on 28.07.2022.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet var movieImage: UIImageView!
    @IBOutlet var filmTitle: UILabel!
    @IBOutlet var filmDate: UILabel!
    @IBOutlet var filmOverview: UILabel!
    @IBOutlet var arrowIcon: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
