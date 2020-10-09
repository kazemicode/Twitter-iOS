//
//  LoginViewController.swift
//  Twitter
//
//  Created by Sara Kazemi on 10/9/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onLoginButton(_ sender: Any) {
        let twitterAPI = "https://api.twitter.com/oauth/request_token";
        TwitterAPICaller.client?.login(url: twitterAPI, success: {
            // go to the home screen -- perform a segue
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }, failure: { (Error) in
            // show error message
            print("Could not login")
        })
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
