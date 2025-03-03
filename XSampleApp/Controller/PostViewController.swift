//
//  PostViewController.swift
//  XSampleApp
//
//  Created by Masaya Suzuki on 2025/03/02.
//

import UIKit
import RealmSwift

class PostViewController: UIViewController {
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var postButton: UIButton!
    
    var postData = PostDataModel()
    
    var dateFormat: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        return dateFormatter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        display()
        setDoneButton()
        configurePostButton()
    }
    
    func configure(post: PostDataModel)
    {
        postData.text = post.text
        postData.userName = post.userName
        postData.recordDate = post.recordDate
        print("データ：\(postData.userName),\(postData.text),\(postData.recordDate)")
    }
    
    func display()
    {
        userNameField.text = postData.userName
        textView.text = postData.text
        //navigationItem.title =  dateFormat.string(from: postData.recordDate)
    }
  
    @IBAction func tappedPostButton(_ sender: UIButton) {
        savePostData()
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
    
    func savePostData() {
        let realm = try! Realm()
        try! realm.write {
            if let userName = userNameField.text {
                postData.userName = userName
            }
            if let text = textView.text {
                postData.text = text
            }
            postData.recordDate = Date()
            realm.add(postData)
        }
        dismiss(animated: true, completion: nil)
        print("userName: \(postData.userName), date: \(postData.recordDate), text: \(postData.text)")
    }
    
    func configurePostButton() {
        postButton.layer.cornerRadius = 15
    }
}
