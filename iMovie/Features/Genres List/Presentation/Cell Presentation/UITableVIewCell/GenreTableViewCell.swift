//
//  GenreTableViewCell.swift
//  iMovie
//
//  Created by UN A on 11/02/21.
//

import UIKit

class GenreTableViewCell: UITableViewCell {

    @IBOutlet weak var genreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
