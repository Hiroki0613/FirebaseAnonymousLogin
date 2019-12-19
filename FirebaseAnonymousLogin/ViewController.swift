//
//  ViewController.swift
//  FirebaseAnonymousLogin
//
//  Created by 宏輝 on 18/12/2019.
//  Copyright © 2019 宏輝. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLoginID: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func loginButton(_ sender: Any) {
        
        Auth.auth().signInAnonymously { (authResult, error) in
            
            if error != nil {
                print("ログインに成功しました")
            } else {
                print("ログイン失敗やで")
            }
            guard let user = authResult?.user else {
                return
            }
            
            //ログインしたユーザーが匿名であるかをbool
            //ログイン成功で匿名が保証されているので必要なし
            //let isAnonymous = user.isAnonymous
            self.displayLoginID.text = "   ID:\(user.uid)"
            
        }
    }
}

/*
 参考URL
 iOS で Firebase 匿名認証を行う
 https://firebase.google.com/docs/auth/ios/anonymous-auth?hl=ja
 */

