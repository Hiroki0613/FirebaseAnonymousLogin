//
//  sendViewController.swift
//  FirebaseAnonymousLogin
//
//  Created by 宏輝 on 23/12/2019.
//  Copyright © 2019 宏輝. All rights reserved.
//

import UIKit
import Firebase

class sendViewController: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet weak var sendTextField1: UITextField!
    @IBOutlet weak var sendTextField2: UITextField!
    
    
    @IBOutlet weak var sendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sendTextField1.delegate = self
        sendTextField2.delegate = self

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        sendTextField1.resignFirstResponder()
        sendTextField2.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendTextField1.resignFirstResponder()
        sendTextField2.resignFirstResponder()
        return true
    }
    
    @IBAction func sendButton(_ sender: Any) {
        
        //メッセージの入力終わり
        sendTextField1.endEditing(true)
        sendTextField2.endEditing(true)
        
        //messageTextField、sendButtonの機能を無効にする
        sendTextField1.isEnabled = false
        sendTextField2.isEnabled = false
        sendButton.isEnabled = false
        
        
        //15文字以上を入力した時に、行う処理
        if sendTextField1.text!.count > 15 {
            print("15文字以上です。")
            
            //ここのreturnがあることによりsendActionの処理が終了。
            //つまり、chatDBでのdatabase処理などが行われない。
            return
        }
        
        //15文字以上を入力した時に、行う処理
        if sendTextField2.text!.count > 15 {
            print("15文字以上です。")
            
            //ここのreturnがあることによりsendActionの処理が終了。
            //つまり、chatDBでのdatabase処理などが行われない。
            return
        }
        
        //chatsという分類をFirebaseのdatabaseに用意する
        let chatDB = Database.database().reference().child("chats")
        
        //キーバリュー型(Dictionary型)で内容を送信する
        //currentUserは今ログインしているユーザーのこと
        //emailの後のカンマはAPIでの最後のカンマと同じもの、つまり次のdictionary型の値を入れている
        let messageInfo = ["sender":sendTextField1.text!,"message":sendTextField2.text!]
        
        //chatDBに入れる。
        //その下にAutoIdをつけて、さらに下にmessageInfoをつける。
        chatDB.childByAutoId().setValue(messageInfo) { (error, result) in
            
            //エラーがnilでないなら、つまりエラーが存在しているなら
            if error != nil {
                print(error)
                
            } else {
                
                //result結果はsetValueの関数が呼ばれた時点で、自動的にfirebaseに送信しているので処理を記載する必要はない。
                print("送信完了！！")
                self.sendTextField1.isEnabled = true
                self.sendTextField2.isEnabled = true
                self.sendButton.isEnabled = true
                self.sendTextField1.text = ""
                self.sendTextField2.text = ""
                
            }
        }
        
    }
    
    
    @IBAction func goToNext(_ sender: Any) {
        performSegue(withIdentifier: "next2", sender: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
