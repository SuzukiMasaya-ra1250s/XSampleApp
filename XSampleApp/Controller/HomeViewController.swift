//
//  HomeViewController.swift
//  XSampleApp
//
//  Created by Masaya Suzuki on 2025/02/27.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    // 投稿リストを表示するためのPostDataModel配列プロパティ
    var postDataList: [PostDataModel] = []
    
    override func viewDidLoad() {
        
        let xIcon = UIImageView(image: UIImage(named: "XIcon"))
        xIcon.contentMode = .scaleAspectFit
        self.navigationItem.titleView = xIcon
        
        tableView.separatorColor = .lightGray
        tableView.separatorStyle = .singleLine
        if #available(iOS 18.2, *) {
            tableView.fillerRowHeight = 50
        }
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PostViewCell", bundle: nil), forCellReuseIdentifier: "PostViewCell")
        tableView.rowHeight = UITableView.automaticDimension
        setPostData() // 画面表示の際に投稿データを格納するメソッドを呼び出す
    }
    
    // 投稿データを配列に格納するメソッド
    func setPostData() {
        for i in 1...20 {
            let postDataModel = PostDataModel(userName: "testUser", text: "この投稿は\(i)番目の投稿です。この投稿は\(i)番目の投稿です。この投稿は\(i)番目の投稿です。この投稿は\(i)番目の投稿です。この投稿は\(i)番目の投稿です。この投稿は\(i)番目の投稿です。この投稿は\(i)番目の投稿です。この投稿は\(i)番目の投稿です。この投稿は\(i)番目の投稿です。この投稿は\(i)番目の投稿です。この投稿は\(i)番目の投稿です。この投稿は\(i)番目の投稿です。", recordDate: Date())
            postDataList.append(postDataModel)
        }
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
}
