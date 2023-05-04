//
//  SummarizeResultStorage.swift
//  TLDR
//
//  Created by 유정주 on 2023/04/19.
//

import Foundation
import CoreData

struct SummarizeResultStorage: Loggable {
    typealias EntityType = SummarizeResultEntity
    private let entityName = "SummarizeResultEntity"
    
    //코어데이터에 저장된 통신 결과 앱들 반환
    func fetch() -> [SummarizeResult] {
        let summarizeResults = fetchEntity().compactMap { createSummarizeResult($0) }
        return summarizeResults
    }
    
    func fetch(text: String) -> SummarizeResult? {
        let filter = filteredRequestUsingText(text)
        
        if let item = fetchEntity(filter: filter).first {
            return createSummarizeResult(item)
        }
        
        return nil
    }

    private func fetchEntity(filter: NSFetchRequest<NSFetchRequestResult>? = nil) -> [EntityType] {
        do {
            if let filter = filter {
                let queryEntities = try CoreDataStorage.shared.backgroundContext.fetch(filter)
                return queryEntities as? [EntityType] ?? []
            } else {
                let request: NSFetchRequest<EntityType> = EntityType.fetchRequest()
                
                let fetchData = try CoreDataStorage.shared.backgroundContext.fetch(request)
                
                return fetchData
            }
        } catch {

        }

        return []
    }
    
    func save(_ summarizeResult: SummarizeResult) {
        do {
            try saveObjectUsing(summarizeResult: summarizeResult, context: CoreDataStorage.shared.context)
            
            try CoreDataStorage.shared.context.save()
        } catch {
            
        }
    }
    
    func deleteAll() {
        //write 연산은 sync 수행
        CoreDataStorage.shared.backgroundContext.performAndWait {
            do {
                fetchEntity().forEach {
                    CoreDataStorage.shared.backgroundContext.delete($0)
                }
                
                try CoreDataStorage.shared.backgroundContext.save()
            } catch {

            }
        }
    }
    
    private func filteredRequestUsingText(_ text: String) -> NSFetchRequest<NSFetchRequestResult> {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "text = %@", "\(text)")
        return fetchRequest
    }
}

extension SummarizeResultStorage {
    private func saveObjectUsing(summarizeResult: SummarizeResult, context: NSManagedObjectContext) throws {
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) else {
            return
        }
        
        let entityObject = NSManagedObject(entity: entity, insertInto: context)
        
        entityObject.setValue(summarizeResult.text, forKey: KeyName.text.rawValue)
        entityObject.setValue(summarizeResult.summarizeText, forKey: KeyName.summarizeText.rawValue)
        entityObject.setValue(summarizeResult.textKeywords, forKey: KeyName.textKeywords.rawValue)
        entityObject.setValue(summarizeResult.summarizeKeywords, forKey: KeyName.summarizeKeywords.rawValue)
        entityObject.setValue(Date(), forKey: KeyName.createdAt.rawValue)
    }

    func createSummarizeResult(_ item: EntityType) -> SummarizeResult? {
        guard let text = item.text,
              let summarizeText = item.summarizeText,
              let textKeywords = item.textKeywords,
              let summarizeKeywords = item.summarizeKeywords else {
                  return nil
        }
        
        return SummarizeResult(text: text,
                               summarizeText: summarizeText,
                               textKeywords: textKeywords,
                               summarizeKeywords: summarizeKeywords)
    }
}

extension SummarizeResultStorage {
    enum KeyName: String {
        case createdAt
        case text, summarizeText
        case textKeywords, summarizeKeywords
    }
}
