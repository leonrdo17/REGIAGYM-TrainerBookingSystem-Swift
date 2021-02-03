//
//  ServiceMenuViewController.swift
//  Leonardo
//
//  Created by Leonardo on 22/05/19.
//  Copyright © 2019 Guest User. All rights reserved.
//

import UIKit

class ServiceMenuViewController: UIViewController {
    
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
        if segue.identifier == "BookSegue"
        {
            let newpage = segue.destination as! BookTrainerViewController
           
            newpage.userName = userName
            newpage.userUsername = userUsername
            newpage.userPassword = userPassword
            newpage.userEmail = userEmail
            newpage.userAddress = userAddress
            
        }
        else if segue.identifier == "CancelSegue"
        {
            let newpage = segue.destination as! CancelViewController
            
            newpage.userName = userName
            newpage.userUsername = userUsername
            newpage.userPassword = userPassword
            newpage.userEmail = userEmail
            newpage.userAddress = userAddress
            
        }
        else if segue.identifier == "EditMenuSegue"
        {
            let newpage = segue.destination as! EditMenuViewController
            
            newpage.userName = userName
            newpage.userUsername = userUsername
            newpage.userPassword = userPassword
            newpage.userEmail = userEmail
            newpage.userAddress = userAddress
            
        }
        
        
        
        
        
        
        
        
    }
}
