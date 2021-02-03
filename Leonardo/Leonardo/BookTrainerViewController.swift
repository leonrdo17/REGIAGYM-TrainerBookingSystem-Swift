//
//  BookTrainerViewController.swift
//  Leonardo
//
//  Created by Leonardo on 22/05/19.
//  Copyright © 2019 Guest User. All rights reserved.
//

import UIKit
import CoreData

class BookTrainerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // required data to be passed
    var userName : String?
    var userUsername : String?
    var userPassword : String?
    var userEmail : String?
    var userAddress : String?
    
    var selectedTrainer : String?
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return trainerList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        selectedTrainer = trainerList[row]
        return trainerList[row]
    }
    
    

    var trainerList: [String] = [String]()
    
    var managedContext : NSManagedObjectContext = NSManagedObjectContext()
    var booklistEntity : NSEntityDescription = NSEntityDescription()
   
    
    func createData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
        {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let bookListEntity = NSEntityDescription.entity(forEntityName: "BookList", in: managedContext)!
        
        let bookList = NSManagedObject(entity: bookListEntity, insertInto: managedContext)
        bookList.setValue(userUsername, forKey: "username")
        
        let bookDate = datePicker.date
        bookList.setValue(bookDate, forKey: "date")
        
        let bookTrainer = selectedTrainer
        bookList.setValue(selectedTrainer, forKey: "trainer")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            
        }
        
    }
    
    
    
    func Load() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        managedContext = appDelegate.persistentContainer.viewContext
        
        booklistEntity = NSEntityDescription.entity(forEntityName: "BookList", in: managedContext)!
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Load()
        
        self.trainerPicker.delegate = self
        self.trainerPicker.dataSource = self
        
        trainerList = ["Josh", "Eric", "Liza", "Carrol"]


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BookBack"
        {
            let newpage = segue.destination as! ServiceMenuViewController
            newpage.userName = userName
            newpage.userUsername = userUsername
            newpage.userPassword = userPassword
            newpage.userEmail = userEmail
            newpage.userAddress = userAddress
        }
    }
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var trainerPicker: UIPickerView!
    
    @IBAction func bookConfirmButton(_ sender: UIButton) {
        createData()
        performSegue(withIdentifier: "BookBack", sender: self)
        
    }
}
