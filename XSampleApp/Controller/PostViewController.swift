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
    var isFirstPost: Bool = true // 初期投稿:true、編集投稿:false
    
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
        textView.delegate = self
        userNameField.delegate = self
        print(postData)
        
    }
    // 画面表示時に実行
    func display()
    {
        userNameField.text = postData.userName
        textView.text = postData.text
        postButton.isEnabled = false // 初期画面表示時には投稿ボタンを無効化しておく
        // 編集投稿の場合に投稿ボタン表示を"編集"に変更
        if isFirstPost == false {
            postButton.setTitle("編集", for: .normal)
        }
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
    // 投稿データ保存メソッド（投稿したら投稿画面を閉じる）
    func savePostData() {
        let realm = try! Realm()
        try! realm.write {
            if let userName = userNameField.text {
                postData.userName = userName
            }
            if let text = textView.text {
                postData.text = text
            }
            if isFirstPost {
                postData.recordDate = Date()
            }
            realm.add(postData)
        }
        navigationController?.popViewController(animated: true)
    }
    
    func configurePostButton() {
        postButton.layer.cornerRadius = 15
    }
    // 投稿可否判断メソッド（投稿可なら投稿ボタンを有効化する）
    func postRegulationCheck() {
        var textCount: Int = 0
        textCount = textView.text.count
        var isTextEnable: Bool = false
        
        // ユニットテスト用にメソッド切り出し
        isTextEnable = textCount1To140(textCount2: textCount)
        
        if userNameField.text?.isEmpty == true || textView.text?.isEmpty == true || isTextEnable == false {
            postButton.isEnabled = false
        } else {
            postButton.isEnabled = true
        }
        print(textCount)
    }
    // ユニットテスト用にメソッド切り出し（文字数確認）
    func textCount1To140(textCount2: Int) -> Bool {
        return textCount2 >= 1 && textCount2 <= 140
    }
}
// UITextViewの内容が変更されたら投稿可否判断（投稿ボタン有効化）するメソッドを実行する
extension PostViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        postRegulationCheck()
    }
}
// UITextFieldの内容が変更されたら投稿可否判断（投稿ボタン有効化）するメソッドを実行する
extension PostViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ userNameField: UITextField) {
        postRegulationCheck()
    }
}
