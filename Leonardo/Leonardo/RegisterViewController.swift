//
//  RegisterViewController.swift
//  Leonardo
//
//  Created by Guest User on 21/05/2019.
//  Copyright © 2019 Guest User. All rights reserved.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController {
    
    var managedContext : NSManagedObjectContext = NSManagedObjectContext()
    var customerEntity : NSEntityDescription = NSEntityDescription()

    func Load() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        managedContext = appDelegate.persistentContainer.viewContext
        
        customerEntity = NSEntityDescription.entity(forEntityName: "Customer", in: managedContext)!
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Load()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var txtFullName: UITextField!
    
    @IBOutlet weak var txtUsername: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtAddress: UITextField!
    
    
    @IBAction func registerButton(_ sender: UIButton) {
        let customer = NSManagedObject(entity: customerEntity, insertInto: managedContext)
        
        customer.setValue(txtFullName.text, forKey:"name")
        customer.setValue(txtUsername.text, forKey:"username")
        customer.setValue(txtPassword.text, forKey:"password")
        customer.setValue(txtEmail.text, forKey:"email")
        customer.setValue(txtAddress.text, forKey:"address")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        performSegue(withIdentifier: "RegisterBack", sender: nil)
        
    }
}
