//
//  PostViewController.swift
//  XSampleApp
//
//  Created by Masaya Suzuki on 2025/03/02.
//

import UIKit

class PostViewController: UIViewController {
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    var text: String = ""
    var userName: String = ""
    var recordDate: Date = Date()
    
    var dateFormat: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        return dateFormatter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        display()
        setDoneButton()
    }
    
    func configure(post: PostDataModel)
    {
        text = post.text
        userName = post.userName
        recordDate = post.recordDate
        print("データ：\(userName),\(text),\(recordDate)")
    }
    
    func display()
    {
        userNameField.text = userName
        textView.text = text
        navigationItem.title =  dateFormat.string(from: recordDate)
    }
    
    // キーボード閉じるボタン動作
    @objc func tapDoneButton() {
        view.endEditing(true)
    }
    // キーボード閉じるボタンを追加する
    func setDoneButton() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        let commitButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tapDoneButton))
        toolBar.items = [commitButton]
        userNameField.inputAccessoryView = toolBar
        textView.inputAccessoryView = toolBar
    }
}
