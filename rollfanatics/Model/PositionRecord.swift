//
//  PositionRecord.swift
//  rollfanatics
//
//  Created by Борис Рябов on 6/29/23.
//

import Foundation

struct PositionRecord:Identifiable, Codable  {
    let id: UUID
    var name: String
    var listOfTechniques: [UUID]
    
    init(id: UUID = UUID(), name: String, listOfTechniques: [UUID]) {
        self.id = id
        self.name = name
        self.listOfTechniques = listOfTechniques
        
    }
    
    func listTechniques(records: [TechniqueRecord]) -> [TechniqueRecord] {
        var returnList: [TechniqueRecord] = []
        
        for record in records {
            if (listOfTechniques.contains(record.id)) {
                returnList.append(record)
            }
        }
        
        return returnList
    }
    
    mutating func deleteAssosiatedTechnique(recordId: UUID) {
        listOfTechniques.removeAll{ $0 == recordId }
    }
    
    mutating func addAssosiatedTechnique(recordId: UUID) {
        listOfTechniques.append(recordId)
    }
}

extension PositionRecord {
    static var EmptyPosition: PositionRecord {
        PositionRecord(
            name: "",
            listOfTechniques: []
        )
    }
}

extension PositionRecord {
    static let sampleRecord: [PositionRecord] = [
        PositionRecord(
            name: "Open Guard",
            listOfTechniques: []
        ),
        PositionRecord(
            name: "Standing",
            listOfTechniques: []
        )
    ]
}
