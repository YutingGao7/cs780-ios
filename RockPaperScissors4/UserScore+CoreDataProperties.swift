//
//  UserScore+CoreDataProperties.swift
//  RockPaperScissors4
//
//  Created by Candy Gao on 5/11/22.
//
//

import Foundation
import CoreData


extension UserScore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserScore> {
        return NSFetchRequest<UserScore>(entityName: "UserScore")
    }

    @NSManaged public var losses: Int16
    @NSManaged public var ties: Int16
    @NSManaged public var wins: Int16

}

extension UserScore : Identifiable {

}
