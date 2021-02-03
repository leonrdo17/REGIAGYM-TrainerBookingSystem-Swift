//
//  EditMenuViewController.swift
//  Leonardo
//
//  Created by Leonardo on 23/05/19.
//  Copyright © 2019 Guest User. All rights reserved.
//

import UIKit

class EditMenuViewController: UIViewController {
    
    // required data to be passed
    var userName : String?
    var userUsername : String?
    var userPassword : String?
    var userEmail : String?
    var userAddress : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ChangePasswordSegue"
        {
            let newpage = segue.destination as! ChangePasswordViewController
            
            newpage.userName = userName
            newpage.userUsername = userUsername
            newpage.userPassword = userPassword
            newpage.userEmail = userEmail
            newpage.userAddress = userAddress
            
        }
    }
}
