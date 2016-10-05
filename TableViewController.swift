//
//  TableViewController.swift
//  testCoreData
//
//  Created by behnam hajian on 2016-10-05.
//  Copyright © 2016 bluekernel. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class TableViewController: UIViewController, UITableViewDataSource {
    let delegate = UIApplication.shared.delegate as! AppDelegate
    var people = [NSManagedObject]()
    var names = [String]()
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\"The List\""
        tableView.register(UITableViewCell.self,
                                forCellReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //1
        let managedContext = delegate.persistentContainer.viewContext
        //2
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
//        let fetchRequest = NSFetchRequest(entityName: "Person")
        
        //3
        do {
            let results =
                try managedContext.fetch(fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
            people = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    
    //Replace both UITableViewDataSource methods
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt
        indexPath: IndexPath) -> UITableViewCell {
        
        let cell =
            tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        let person = people[indexPath.row]
        
        cell!.textLabel!.text =
            person.value(forKey: "name") as? String
        
        return cell!
    }
    
    
    
    @IBAction func add(_ sender: AnyObject) {
        let alert = UIAlertController(title: "New Name",
                                      message: "Add a new name",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default,
                                       handler: { (action:UIAlertAction) -> Void in
                                        
                                        let textField = alert.textFields!.first
                                        self.saveName(name: textField!.text!)
                                        self.tableView.reloadData()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default) { (action: UIAlertAction) -> Void in
        }
        
        alert.addTextField {
            (textField: UITextField) -> Void in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert,
                              animated: true,
                              completion: nil)
    }
    
    
    
    func saveName(name: String) {
        //1
        let managedObjectContext = delegate.persistentContainer.viewContext
        
        let entity =  NSEntityDescription.entity(forEntityName: "Person",
                                                 in:managedObjectContext)
        
        
        
        let person = NSManagedObject(entity: entity!,
                                     insertInto: managedObjectContext)
        
        
        //3
        person.setValue(name, forKey: "name")
        
        //4
        do {
            try managedObjectContext.save()
            //5
            people.append(person)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    
}
