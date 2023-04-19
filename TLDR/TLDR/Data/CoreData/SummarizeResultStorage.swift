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
        do {
            let request: NSFetchRequest<EntityType> = EntityType.fetchRequest()
            
            let fetchData = try CoreDataStorage.shared.backgroundContext.fetch(request)
            let summarizeResults = fetchData.compactMap { createSummarizeResult($0) }
            
            return summarizeResults
        } catch {
            //todo: 에러 핸들링
        }
        
        return []
    }
    
    func save(_ summarizeResult: SummarizeResult) {
        do {
            try saveObjectUsing(summarizeResult: summarizeResult, context: CoreDataStorage.shared.context)
        } catch {
            
        }
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
