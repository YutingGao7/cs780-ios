//
//  UserScore+CoreDataProperties.swift
//  RockPaperScissors4
//
//  Created by Candy Gao on 5/12/22.
//
//

import Foundation
import CoreData


extension UserScore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserScore> {
        return NSFetchRequest<UserScore>(entityName: "UserScore")
    }
    
    @nonobjc public class func deleteRequest() -> NSBatchDeleteRequest {
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "UserScore")
        return NSBatchDeleteRequest(fetchRequest: fetchReq)
    }

    @NSManaged public var losses: Int16
    @NSManaged public var ties: Int16
    @NSManaged public var wins: Int16
    @NSManaged public var name: String?
    @NSManaged public var date: Date?

}

extension UserScore : Identifiable {

}
