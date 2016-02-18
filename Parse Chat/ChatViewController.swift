//
//  ChatViewController.swift
//  Parse Chat
//
//  Created by Zubair Khan on 2/17/16.
//  Copyright © 2016 Michael R. Bock. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var composeTextField: UITextField!

    struct ChatMessageObject {
        let chatMessage: String
        let user: String
    }

    var chatMessageObjects: [ChatMessageObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension

        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "onTimer", userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSendButton(sender: AnyObject) {
        let chatMessage = PFObject(className:"Message_iOSFeb2016")
        chatMessage["text"] = composeTextField.text
        chatMessage["user"] = PFUser.currentUser()

        chatMessage.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                print("successfully saved the message!")
            } else {
                print("error occurred")
            }
        }
        composeTextField.text = ""
    }

    func onTimer() {
        let query = PFQuery(className:"Message_iOSFeb2016")
        query.includeKey("user")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects

                //self.chatMessageObjects = []
                for object in objects! {
                    var userName = ""
                    if let user = object["user"] as? PFUser {
                        print("hello")
                        userName = user.username!
                        print("world")
                    }

                    let chatObject = ChatMessageObject.init(
                        chatMessage: object["text"] as! String,
                        user: userName
                    )
                    self.chatMessageObjects.append(chatObject)
                }
                self.tableView.reloadData()
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
}

extension ChatViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessageObjects.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ChatTableViewCell", forIndexPath: indexPath) as! ChatTableViewCell

        cell.chatLabel.text = chatMessageObjects[indexPath.row].chatMessage
        cell.usernameLabel.text = chatMessageObjects[indexPath.row].user

        return cell
    }
}
