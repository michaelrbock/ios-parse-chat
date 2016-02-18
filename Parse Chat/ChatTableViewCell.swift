//
//  ChatTableViewCell.swift
//  Parse Chat
//
//  Created by Michael Bock on 2/17/16.
//  Copyright © 2016 Michael R. Bock. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var chatLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
