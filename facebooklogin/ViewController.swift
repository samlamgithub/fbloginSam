//
//  ViewController.swift
//  facebooklogin
//
//  Created by Jiahao Lin on 01/06/2015.
//  Copyright (c) 2015 Jiahao Lin. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKShareKit
import FBSDKLoginKit

class ViewController: UIViewController , FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var logButton: FBSDKLoginButton!
    
    @IBOutlet weak var thisLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println()
        // Do any additional setup after loading the view, typically from a nib.
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {
            // User is already logged in, do work such as go to next view controller.
            //performSegueWithIdentifier("logined", sender: nil)
            println("already logged in")
            thisLabel.text = thisLabel.text! + " , you have logged in"
            
            println(FBSDKAccessToken.currentAccessToken())
          //  println(FBSDKProfile.currentProfile().name)
           // println(FBSDKProfile.currentProfile().firstName)
             logButton = FBSDKLoginButton()
            logButton.readPermissions = ["public_profile", "email", "user_friends"]
            logButton.delegate = self
            returnUserData()
            // println(FBSDKProfile.currentProfile().firstName)
        } else {
            thisLabel.text = thisLabel.text! + " , please logg in"
            println("displaying login button")
            logButton = FBSDKLoginButton()
            logButton.center = self.view.center
            logButton.readPermissions = ["public_profile", "email", "user_friends"]
            logButton.delegate = self
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Facebook Delegate Methods
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        println("User Logged In")
        
        if ((error) != nil) {
            // Process error
            println("My error: " + error.description)
        } else if result.isCancelled {
            // Handle cancellations
        }
        else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email")
            {
                println("Got permissioned!")
                //result.grantedPermissions;
                // Do work
                performSegueWithIdentifier("logined", sender: nil)
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        println("User Logged Out")
        thisLabel.text = "This is first VC, please logg in"
    }
    
    func returnUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                println("Error: \(error)")
            }
            else
            {
                println("fetched user: \(result)")
                let userName : NSString = result.valueForKey("name") as! NSString
                println("User Name is: \(userName)")
                let userEmail : NSString = result.valueForKey("email") as! NSString
                println("User Email is: \(userEmail)")
            }
        })
    }
    
    
}

