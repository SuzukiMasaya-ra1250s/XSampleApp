//
//  PostViewCell.swift
//  XSampleApp
//
//  Created by Masaya Suzuki on 2025/03/01.
//

import UIKit

class PostViewCell: UITableViewCell {

    @IBOutlet weak var userNameField: UILabel!
    @IBOutlet weak var recordDateField: UILabel!
    @IBOutlet weak var textField: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCell(postDataModel: PostDataModel) {
        self.userNameField.text = postDataModel.userName
        // self.recordDateField.text = postDataModel.recordDate
        self.textField.text = postDataModel.text
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
