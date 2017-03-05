//
//  ChatController.swift
//  aimalaif
//
//  Created by Oriol Marí Marqués on 05/03/2017.
//  Copyright © 2017 Oriol Marí Marqués. All rights reserved.
//

import UIKit

class ChatController: UIViewController, UITableViewDelegate, UITextViewDelegate, UIGestureRecognizerDelegate {
    
    
    @IBOutlet weak var sendText: UITextView!
    @IBAction func sendButton(_ sender: Any) {
        if sendText.text.characters.count > 0 {
            SocketIOManager.sharedInstance.sendMessage(message: sendText.text!, withNickname: "nickname")
            sendText.text = ""
            sendText.resignFirstResponder()
        }
    }
    
    @IBOutlet weak var tblChat: UITableView!
    
    var chatMessages = [[String: AnyObject]]()


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureTableView()
        //configureNewsBannerLabel()
        //configureOtherUserActivityLabel()
        
        //tvMessageEditor.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        SocketIOManager.sharedInstance.getChatMessage { (messageInfo) -> Void in
            DispatchQueue.main.async(execute: { () -> Void in
                self.chatMessages.append(messageInfo)
                self.tblChat.reloadData()
                //                self.scrollToBottom()
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func configureTableView() {
        tblChat.delegate = self
        //tblChat.dataSource = self
        tblChat.register(UINib(nibName: "ChatCell", bundle: nil), forCellReuseIdentifier: "idCellChat")
        tblChat.estimatedRowHeight = 90.0
        tblChat.rowHeight = UITableViewAutomaticDimension
        //tblChat.tableFooterView = UIView(frame: CGRectZero)
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages.count
    }
    
    
    @nonobjc func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "idCellChat", for: indexPath as IndexPath) as! ChatCell
        let currentChatMessage = chatMessages[indexPath.row]
        let senderNickname = currentChatMessage["nickname"] as! String
        let message = currentChatMessage["message"] as! String
        let messageDate = currentChatMessage["date"] as! String
        
        if senderNickname == "nickname" {
            cell.lblChatMessage.textAlignment = NSTextAlignment.right
            cell.lblMessageDetails.textAlignment = NSTextAlignment.right
            
            //cell.lblChatMessage.textColor = lblNewsBanner.backgroundColor
        }
        
        cell.lblChatMessage.text = message
        cell.lblMessageDetails.text = "by \(senderNickname.uppercased()) @ \(messageDate)"
        
        cell.lblChatMessage.textColor = UIColor.darkGray
        
        return cell
    }
    
    
}
