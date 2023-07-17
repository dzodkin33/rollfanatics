//
//  PositionRecord.swift
//  rollfanatics
//
//  Created by Борис Рябов on 6/29/23.
//

import Foundation

struct PositionRecord:Identifiable, Codable, Hashable, Equatable  {
    let id: UUID
    var name: String
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    init(id: UUID = UUID(), name: String, listOfTechniques: [UUID]) {
        self.id = id
        self.name = name
    }
}

extension PositionRecord {
    static var EmptyPosition: PositionRecord {
        PositionRecord(
            name: "default",
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
