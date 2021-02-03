//
//  CancelViewController.swift
//  Leonardo
//
//  Created by Leonardo on 22/05/19.
//  Copyright © 2019 Guest User. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class CancelViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // required data to be passed
    var userName : String?
    var userUsername : String?
    var userPassword : String?
    var userEmail : String?
    var userAddress : String?
    
    var bookUsernameArray = [String]()
    var bookDateArray = [String]()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookUsernameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookListCell", for: indexPath)
        cell.textLabel?.text = bookUsernameArray[indexPath.item]
        cell.detailTextLabel?.text = bookDateArray[indexPath.item]
        return cell
    }
    
    func retrieveData()
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let bookListFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "BookList")
        
        bookListFetch.predicate = NSPredicate(format: "username = %@", userUsername!)
        bookListFetch.sortDescriptors = [NSSortDescriptor.init(key: "date", ascending: false)]
        
        do{
            let result = try managedContext.fetch(bookListFetch)
            for data in result as! [NSManagedObject]{
                
                let bookUsername = data.value(forKey: "username")
                let bookDate = data.value(forKey: "date")
                
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy hh:mm"
                let dateString = formatter.string(from: bookDate as! Date)
                
                bookUsernameArray.append(bookUsername as! String)
                bookDateArray.append(dateString)
            }
        }
        catch {
            print("Error")
        }

    }
    
    func deleteData()
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BookList")
        fetchRequest.predicate = NSPredicate(format: "username = %@", userUsername!)
        
        do {
            
            let test = try managedContext.fetch(fetchRequest)
            
            if (test.count > 0)
            {
                for data in test
                {
                    let objectToDelete = data as! NSManagedObject
                    managedContext.delete(objectToDelete)
                    
                    do {
                        try managedContext.save()
                    }
                }
            }
        }
        catch
        {
            print(error)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveData()
        
        bookTableList.dataSource = self
        bookTableList.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBOutlet weak var bookTableList: UITableView!
    
    @IBAction func cancelButton(_ sender: UIButton) {
        deleteData()
        performSegue(withIdentifier: "CancelBack", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CancelBack"
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
