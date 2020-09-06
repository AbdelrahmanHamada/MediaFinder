//
//  MoviesCell.swift
//  MediaFinder
//
//  Created by Mohamed Tarek on 6/25/20.
//  Copyright © 2020 Mohamed Fahem. All rights reserved.
//

import UIKit


class MoviesCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var longDescription: UILabel!
    
    var movie :Media?

    override func awakeFromNib() {
        super.awakeFromNib()
        imgView.layer.cornerRadius = imgView.frame.size.width/2

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
