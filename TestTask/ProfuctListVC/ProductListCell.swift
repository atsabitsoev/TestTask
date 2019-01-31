//
//  ProductListCell.swift
//  TestTask
//
//  Created by Ацамаз on 31/01/2019.
//  Copyright © 2019 a.s.bitsoev. All rights reserved.
//

import UIKit

class ProductListCell: UITableViewCell {

    
    
    
    @IBOutlet weak var labName: UILabel!
    @IBOutlet weak var labTagline: UILabel!
    @IBOutlet weak var labUpvotes: UILabel!
    @IBOutlet weak var imThumbnail: UIImageView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
