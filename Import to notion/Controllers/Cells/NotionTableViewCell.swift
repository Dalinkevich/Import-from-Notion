//
//  NotionTableViewCell.swift
//  Import to notion
//
//  Created by Роман далинкевич on 09.08.2021.
//

import UIKit

class NotionTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
