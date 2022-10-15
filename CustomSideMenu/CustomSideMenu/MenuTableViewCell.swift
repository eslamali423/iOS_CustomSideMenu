//
//  MenuTableViewCell.swift
//  CustomSideMenu
//
//  Created by Eslam Ali  on 15/10/2022.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var itemNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(itemName: String){
        self.itemNameLabel.text = itemName
        
    }

}
