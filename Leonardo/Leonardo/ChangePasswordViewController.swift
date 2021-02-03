//
//  ChangePasswordViewController.swift
//  Leonardo
//
//  Created by Leonardo on 23/05/19.
//  Copyright © 2019 Guest User. All rights reserved.
//

import UIKit
import CoreData

class ChangePasswordViewController: UIViewController {
    
    // required data to be passed
    var userName : String?
    var userUsername : String?
    var userPassword : String?
    var userEmail : String?
    var userAddress : String?

    
    func updateData ()
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Customer")
        fetchRequest.predicate = NSPredicate(format: "username = %@", userUsername!)
        
        do
        {
            let test = try managedContext.fetch(fetchRequest)
            
            let objectUpdate = test[0] as! NSManagedObject
            
            objectUpdate.setValue(txtNewPassword.text, forKey: "password")
            
            do
            {
                try managedContext.save()
            }
            catch
            {
                print(error)
            }
        }
        catch
        {
            print(error)
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
    
    @IBOutlet weak var txtNewPassword: UITextField!
    
    @IBAction func changeButton(_ sender: UIButton) {
        if txtNewPassword.text == ""
        {
            let alert = UIAlertController(title: "Warning!", message: "Please fill the new password!", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            updateData()
            performSegue(withIdentifier: "ChangeBackSegue", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ChangeBackSegue"
        {
            let newpage = segue.destination as! ServiceMenuViewController
            newpage.userName = userName
            newpage.userUsername = userUsername
            newpage.userPassword = userPassword
            newpage.userEmail = userEmail
            newpage.userAddress = userAddress
        }
    }
}
