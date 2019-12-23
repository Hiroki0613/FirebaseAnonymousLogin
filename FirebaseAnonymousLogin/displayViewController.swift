//
//  displayViewController.swift
//  FirebaseAnonymousLogin
//
//  Created by 宏輝 on 23/12/2019.
//  Copyright © 2019 宏輝. All rights reserved.
//

import UIKit
import Firebase

class displayViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var chatArray = [Message]()
       
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchChatData()
        tableView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return chatArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            
        let displayMessageLabel1 = cell.contentView.viewWithTag(1) as! UILabel
        let displayMessageLabel2 = cell.contentView.viewWithTag(2) as! UILabel
        
        displayMessageLabel1.text = self.chatArray[indexPath.row].displayMessage1
        displayMessageLabel2.text = self.chatArray[indexPath.row].displayMessage2
        
        return cell
            
    }
    
    //firebaseからデータを引っ張ってくる(取得する）
    func fetchChatData(){
        
        //どこからデータを引っ張ってくるのか
        let fetchDataRef = Database.database().reference().child("chats")
        
        //新しく更新があったときだけ取得したい
        fetchDataRef.observe(.childAdded) { (snapShot) in
            
            let snapShotData = snapShot.value as! AnyObject
            let text = snapShotData.value(forKey: "message")
            let sender = snapShotData.value(forKey: "sender")
            
            let message = Message()
            message.displayMessage1 = text as! String
            message.displayMessage2 = sender as! String
            
            self.chatArray.append(message)
            self.tableView.reloadData()
        }
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
