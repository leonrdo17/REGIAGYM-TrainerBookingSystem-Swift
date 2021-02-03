//
//  LogInViewController.swift
//  Leonardo
//
//  Created by Guest User on 21/05/2019.
//  Copyright © 2019 Guest User. All rights reserved.
//

import UIKit
import CoreData


class LogInViewController: UIViewController {
    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    var result = NSArray()
    
    // required data to be passed
    var userName : String?
    var userUsername : String?
    var userPassword : String?
    var userEmail : String?
    var userAddress : String?
    
    
    @IBAction func SignInButton(_ sender: UIButton) {
        
        if txtUsername.text == "" && txtPassword.text == ""
        {
            let alert = UIAlertController(title: "Alert!", message: "Username and Password cannot be blank!", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            
        }
            
        else if txtUsername.text == "" || txtPassword.text == ""
        {
            let alert = UIAlertController(title: "Alert!", message: "Please fill the empty section!", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            
        }
            
        else
        {
            self.CustomerUsernameAndPasswordValidation(username: txtUsername.text! as String, password: txtPassword.text! as String)
        }
        
    }
    
    func CustomerUsernameAndPasswordValidation(username: String, password: String)
    {
        let app = UIApplication.shared.delegate as! AppDelegate
        
        let context = app.persistentContainer.viewContext
        
        let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Customer")
        
        let predicate = NSPredicate(format: "username = %@", username)
        
        fetchrequest.predicate = predicate
        
        do
        {
            result = try context.fetch(fetchrequest) as NSArray
    
            if result.count>0
            {
                for data in result as! [NSManagedObject]
                {
                    userName = data.value(forKey: "name") as? String
                    userUsername = data.value(forKey: "username") as? String
                    userPassword = data.value(forKey: "password") as? String
                    userEmail = data.value(forKey: "email") as? String
                    userAddress = data.value(forKey: "address") as? String
                    
                    let objectentity = result.firstObject as! Customer
                    
                    if objectentity.username == username && objectentity.password == password
                    {
                        print("Login Successfully")
                        performSegue(withIdentifier: "MainMenu", sender: self)
                        return
                    }
                        
                    else
                    {
                        let alert = UIAlertController(title: "Alert!", message: "Wrong username or password!", preferredStyle: .alert)
                        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(ok)
                        self.present(alert, animated: true, completion: nil)
                        
                        print("Wrong username or password !")
                        return
                    }
                }
            }
        }
        
        catch
        {
            let fetch_error = error as NSError
            print("error", fetch_error.localizedDescription)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MainMenu"
        {
            let newpage = segue.destination as! MainMenuTabController
            newpage.userName = userName
            newpage.userUsername = userUsername
            newpage.userPassword = userPassword
            newpage.userEmail = userEmail
            newpage.userAddress = userAddress
            
        }
    }
    
    @IBAction func adminLoginButton(_ sender: UIButton) {
        
        if txtUsername.text == "admin1" && txtPassword.text == "123"
        {
            performSegue(withIdentifier: "AdminSegue", sender: self)
        }
        
        else if txtUsername.text == "admin2" && txtPassword.text == "123"
        {
            performSegue(withIdentifier: "AdminSegue", sender: self)
        }
        
        else if txtUsername.text == "admin3" && txtPassword.text == "123"
        {
            performSegue(withIdentifier: "AdminSegue", sender: self)
        }
            
        else
        {
            let alert = UIAlertController(title: "Warning!", message: "Admin Login Failed!", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
