//
//  SummarizeResultEntity+CoreDataProperties.swift
//  TLDR
//
//  Created by 유정주 on 2023/04/19.
//
//

import Foundation
import CoreData


extension SummarizeResultEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SummarizeResultEntity> {
        return NSFetchRequest<SummarizeResultEntity>(entityName: "SummarizeResultEntity")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var text: String?
    @NSManaged public var summarizeText: String?
    @NSManaged public var textKeywords: [String]?
    @NSManaged public var summarizeKeywords: [String]?

}

extension SummarizeResultEntity : Identifiable {

}
