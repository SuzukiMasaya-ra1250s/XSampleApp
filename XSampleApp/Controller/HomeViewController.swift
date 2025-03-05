//
//  HomeViewController.swift
//  XSampleApp
//
//  Created by Masaya Suzuki on 2025/02/27.
//

import Foundation
import UIKit
import RealmSwift

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    // 投稿リストを表示するためのPostDataModel配列プロパティ
    var postDataList: [PostDataModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Xアイコン設定
        let xIcon = UIImageView(image: UIImage(named: "XIcon"))
        xIcon.contentMode = .scaleAspectFit
        self.navigationItem.titleView = xIcon
        // 投稿画面のbackBarButtonを”キャンセル”に変更
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "キャンセル", style: .plain, target: nil, action: nil)
        
        tableView.separatorColor = .lightGray
        tableView.separatorStyle = .singleLine
        if #available(iOS 18.2, *) {
            tableView.fillerRowHeight = 50
        }
        
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.register(UINib(nibName: "PostViewCell", bundle: nil), forCellReuseIdentifier: "PostViewCell")
        tableView.rowHeight = UITableView.automaticDimension

        configureButton() // 投稿追加ボタンの表示設定メソッド呼び出し
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setPostData() // 画面表示の際に投稿データを格納するメソッド呼び出す
        tableView.reloadData()
    }
    
    // 投稿追加ボタンの表示設定
    func configureButton() {
        addButton.layer.cornerRadius = addButton.bounds.width / 2
    }
    
    @IBAction func tappedAddButton(_ sender: UIButton) {
        transitionToPostView()
    }
    
    func transitionToPostView() {
        let storyboard = UIStoryboard(name: "PostViewController", bundle: nil)
        guard let postViewController = storyboard.instantiateInitialViewController() as? PostViewController else { return }
        navigationController?.pushViewController(postViewController, animated: true)
    }
    
    
    // 投稿データを配列に格納するメソッド
    func setPostData() {
        let realm = try! Realm()
        var result = Array(realm.objects(PostDataModel.self))
        result.sort(by: { $0.recordDate > $1.recordDate })
        postDataList = result
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostViewCell", for: indexPath ) as! PostViewCell
        cell.setCell(postDataModel: postDataList[indexPath.row])
        return cell
    }
    // 投稿データの削除（左スワイプでの削除）
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let targetPostData = postDataList[indexPath.row]
        let realm = try! Realm()
        try! realm.write {
            realm.delete(targetPostData)
        }
        postDataList.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    // 投稿データ削除時の表示を”削除”に指定
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "削除"
    }
}

// セル選択時に投稿画面へ遷移させる（UITableViewDelegeteを使った処理）
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "PostViewController", bundle: nil)
        let postViewController = storyboard.instantiateViewController(identifier: "PostViewController") as! PostViewController
        // 画面遷移させる際にデータを合わせて渡す
        let postData = postDataList[indexPath.row]
        postViewController.configure(post: postData)
        // セル選択状態を解除する
        tableView.deselectRow(at: indexPath, animated: true)
        // 投稿画面へ遷移させる
        navigationController?.pushViewController(postViewController, animated: true)
    }
}
