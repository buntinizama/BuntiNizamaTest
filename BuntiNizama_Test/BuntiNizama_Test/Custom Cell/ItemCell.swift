//
//  ItemCell.swift
//  BuntiNizama_Test
//
//  Created by Bunti Nizama on 01/07/20.
//

import UIKit

class ItemCell: UITableViewCell {
    
    @IBOutlet var titleLabel : UILabel!
    @IBOutlet var descriptionLabel : UILabel!
    @IBOutlet var checkMarkButton : UIButton!
    
    var item = Item()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(item : Item){
        titleLabel.text = item.title
        descriptionLabel.text = item.itemDescription
        checkMarkButton.isSelected = item.isSelected
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
