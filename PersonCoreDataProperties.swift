//
//  Person+CoreDataProperties.swift
//  testCoreData
//
//  Created by behnam hajian on 2016-10-05.
//  Copyright © 2016 bluekernel. All rights reserved.
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person");
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int32
    @NSManaged public var phone: String?

}
