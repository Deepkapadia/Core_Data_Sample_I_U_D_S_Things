//
//  CurtomCell.swift
//  Core_DATA_Sample_File_Swift4
//
//  Created by DeEp KapaDia on 29/01/19.
//  Copyright © 2019 DeEp KapaDia. All rights reserved.
//

import UIKit

class CurtomCell: UITableViewCell {

    @IBOutlet weak var ID_lbl: UILabel!
    @IBOutlet weak var name_LBL: UILabel!
    @IBOutlet weak var add_LBL: UILabel!
    @IBOutlet weak var ImageVC_Cell: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
