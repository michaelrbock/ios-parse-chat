//
//  ViewController.swift
//  Parse Chat
//
//  Created by Michael Bock on 2/17/16.
//  Copyright © 2016 Michael R. Bock. All rights reserved.
//

import Parse
import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextFIeld: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogin(sender: UIButton) {
        PFUser.logInWithUsernameInBackground(emailTextField.text!, password: passwordTextFIeld.text!) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                // Do stuff after successful login.

                let vc : ChatViewController = self.storyboard!.instantiateViewControllerWithIdentifier("ChatViewController") as! ChatViewController
                let navigationController = UINavigationController(rootViewController: vc)
                self.presentViewController(navigationController, animated: true, completion: nil)

                print("login worked")
            } else {
                if let error = error {
                    let errorString = error.userInfo["error"] as? NSString
                    // Show the errorString somewhere and let the user try again.
                    let alertController = UIAlertController(title: "Login Failed", message: String(errorString!), preferredStyle: .Alert)
                    // create an OK action
                    let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                        // handle response here.
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }
                    // add the OK action to the alert controller
                    alertController.addAction(OKAction)
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
            }
        }
    }

    @IBAction func onSignup(sender: UIButton) {
        let user = PFUser()
        user.username = emailTextField.text
        user.password = passwordTextFIeld.text
        user.email = emailTextField.text

        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo["error"] as? NSString
                // Show the errorString somewhere and let the user try again.
                let alertController = UIAlertController(title: "Signup Failed", message: String(errorString!), preferredStyle: .Alert)
                // create an OK action
                let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                    // handle response here.
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
                // add the OK action to the alert controller
                alertController.addAction(OKAction)
                self.presentViewController(alertController, animated: true, completion: nil)
            } else {
                // Hooray! Let them use the app now.
                print("signup worked")
            }
        }
    }
}

