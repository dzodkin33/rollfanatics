//
//  PositionTechniqueBinding.swift
//  rollfanatics
//
//  Created by Борис Рябов on 7/15/23.
//

import Foundation


struct PositionTechniqueBinding {
    var position: PositionRecord
    var listOfTechniques: [UUID]
    
    
    func listTechniques(records: [TechniqueRecord]) -> [TechniqueRecord] {
        var returnList: [TechniqueRecord] = []
        
        for record in records {
            if (listOfTechniques.contains(record.id)) {
                returnList.append(record)
            }
        }
        
        return returnList
    }
    
    mutating func deleteAssosiatedTechnique(recordId: UUID) -> PositionTechniqueBinding {
        
        if (listOfTechniques.contains(recordId)) {
            listOfTechniques.removeAll{ $0 == recordId }
        }

        return self
    }
    
    mutating func addAssosiatedTechnique(recordId: UUID) -> PositionTechniqueBinding {
        
        
        if (listOfTechniques.contains(recordId)) {
            return self
        }
        self.listOfTechniques.append(recordId)
        
        return self
    }
}

extension PositionTechniqueBinding {
    static var emptyBind: PositionTechniqueBinding {
        PositionTechniqueBinding(
            position: PositionRecord.EmptyPosition,
            listOfTechniques: [])
        
    }
}

extension PositionTechniqueBinding {
    static let exampleBindings: [PositionTechniqueBinding] = [
    ]
}
