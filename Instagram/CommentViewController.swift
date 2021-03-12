//
//  CommentViewController.swift
//  Instagram
//
//  Created by 井口創太 on 2021/03/11.
//

import UIKit
import Firebase
import SVProgressHUD

class CommentViewController: UIViewController /*UITextFieldDelegate*/ {
  
  @IBOutlet weak var commentField: UITextField!
  @IBOutlet weak var handleCommentButton: UIButton!
  
  var postData:PostData!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //commentField.delegate = self
    commentField.text = ""
    //handleCommentButton.isEnabled = false
  }
  
  /*
  @IBAction func checkComment(_ sender: Any) {
    if commentField.text == "" {
      handleCommentButton.isEnabled = false
    } else {
      handleCommentButton.isEnabled = true
    }
  }
 */
  
  @IBAction func handleCommentButton(_ sender: Any) {
    // HUDで処理中を表示
    SVProgressHUD.show()
    
    //定義
    let comment = commentField.text
    let author = Auth.auth().currentUser?.displayName
    let commentAuthor = "\(author!): \(comment!)"
    var updateComment: FieldValue
    
    updateComment = FieldValue.arrayUnion([commentAuthor])
    
    //書き込み
    let postRef = Firestore.firestore().collection(Const.PostPath).document(postData.id)
    postRef.updateData(["commentAuthor": updateComment])
    
    SVProgressHUD.showSuccess(withStatus: "コメントを投稿しました！")
    
    //画面遷移
    UIApplication.shared.windows.first{$0.isKeyWindow}?.rootViewController?.dismiss(animated: true, completion: nil)
  }
  
  //キャンセルボタン
  @IBAction func handleCancelButton(_ sender: Any) {
    UIApplication.shared.windows.first{$0.isKeyWindow}?.rootViewController?.dismiss(animated: true, completion: nil)
  }
  
}
