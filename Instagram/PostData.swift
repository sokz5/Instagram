//
//  PostData.swift
//  Instagram
//
//  Created by 井口創太 on 2021/03/04.
//

import UIKit
import Firebase

class PostData: NSObject {
  var id: String
  var name: String?
  var caption: String?
  var date: Date?
  var likes: [String] = []
  var isLiked: Bool = false
  var commentAuthor: [String] = []
  
  init(document: QueryDocumentSnapshot) {
    self.id = document.documentID
    
    let postDic = document.data()
    
    self.name = postDic["name"] as? String
    
    self.caption = postDic["caption"] as? String
    
    //コメント
    if let commentAuthor = postDic["commentAuthor"] as? [String] {
      self.commentAuthor = commentAuthor
    }
    
    let timestamp = postDic["date"] as? Timestamp
    self.date = timestamp?.dateValue()
    
    if let likes = postDic["likes"] as? [String] {
      self.likes = likes
    }
    if let myid = Auth.auth().currentUser?.uid {
      //likesの配列の中にmyidが含まれているかチェックすることで、自分がいいねを教えているか確認
      if self.likes.firstIndex(of: myid) != nil {
        //myidがあれば、いいねを押していると認識する。
        self.isLiked = true
      }
    }
  }
}
