//
//  DeleteBookViewController.swift
//  Leonardo
//
//  Created by Guest User on 23/05/2019.
//  Copyright © 2019 Guest User. All rights reserved.
//

import UIKit
import CoreData

class DeleteBookViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var allBookUsername = [String]()
    var allBookDate = [String]()
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return allBookUsername.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllBookListCell", for: indexPath)
        cell.textLabel?.text = allBookUsername[indexPath.item]
        cell.detailTextLabel?.text = allBookDate[indexPath.item]
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveData()
        
        allBookList.dataSource = self
        allBookList.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func deleteData()
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        
        var fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BookList")
        fetchRequest.predicate = NSPredicate(format: "username = %@", selectedUsername.text!)
        
        do
        {
            let test = try managedContext.fetch(fetchRequest)
            
            if (test.count > 0)
            {
                for data in test
                {
                    let objectToDelete = data as! NSManagedObject
                    managedContext.delete(objectToDelete)
                    
                    do
                    {
                        try managedContext.save()
                    }
                    
                }
              
            }
                
            else
            {
                let alert = UIAlertController(title: "Warning!", message: "Book not found!", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
                
            }
        }
        catch
        {
            print(error)
        }
            
    }
    
    func retrieveData()
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let bookListFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "BookList")
        
        do{
            let result = try managedContext.fetch(bookListFetch)
            for data in result as! [NSManagedObject]{
                
                let bookUsername = data.value(forKey: "username")
                let bookDate = data.value(forKey: "date")
                
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy hh:mm"
                let dateString = formatter.string(from: bookDate as! Date)
                
                allBookUsername.append(bookUsername as! String)
                allBookDate.append(dateString)
            }
        }
        catch {
            print("Error")
        }
        
    }
    
    @IBOutlet weak var allBookList: UITableView!
    
    @IBOutlet weak var selectedUsername: UITextField!
    
    @IBAction func deleteButton(_ sender: UIButton) {
        if selectedUsername.text == ""
        {
            let alert = UIAlertController(title: "Warning!", message: "Plese fill the customer book!", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            deleteData()
            performSegue(withIdentifier: "DeleteBookingBack", sender: nil)
        }

    }
    
}
