//
//  ViewController.swift
//  testCoreData
//
//  Created by behnam hajian on 2016-10-05.
//  Copyright © 2016 bluekernel. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var ageLabel: UITextField!
    @IBOutlet weak var phoneLabel: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    let delegate = UIApplication.shared.delegate as! AppDelegate
    var people = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveTouch(_ sender: AnyObject) {
        let managedObjectContext = delegate.persistentContainer.viewContext
        
        let entity =  NSEntityDescription.entity(forEntityName: "Person",
                                                 in:managedObjectContext)
        
        
        
        let person = NSManagedObject(entity: entity!,
                                     insertInto: managedObjectContext)
        
        
        
        //3
        person.setValue(nameLabel.text, forKey: "name")
        
        //4
        do {
            try managedObjectContext.save()
            //5
            people.append(person)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
        
    }

    
    @IBAction func findTouch(_ sender: AnyObject) {
        
    }
    

}

