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
    
    var dateFormat: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCell(postDataModel: PostDataModel) {
        self.userNameField.text = postDataModel.userName
        self.recordDateField.text = dateFormat.string(from: postDataModel.recordDate) // Date型をString型に変換させてLabel表示
        
        self.textField.text = postDataModel.text
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
