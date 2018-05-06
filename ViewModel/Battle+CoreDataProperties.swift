//
//  Battle+CoreDataProperties.swift
//  GameofThrones
//
//  Created by Abhishek on 05/05/18.
//  Copyright © 2018 Abhishek. All rights reserved.
//
//

import Foundation
import CoreData


extension Battle {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Battle> {
        return NSFetchRequest<Battle>(entityName: "Battle")
    }

    @NSManaged public var attacker_king: String?
    @NSManaged public var attacker_outcome: String?
    @NSManaged public var battle_number: String?
    @NSManaged public var defender_king: String?
    @NSManaged public var name: String?

}
