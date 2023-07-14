//
//  TechniqueRecord.swift
//  rollfanatics
//
//  Created by Борис Рябов on 6/23/23.
//

import Foundation


struct TechniqueRecord: Identifiable, Codable, Equatable {
    

    
    
    let id: UUID
    var name: String
    var position: PositionRecord
    var type: TechniqueType
    var bodyParts: [BodyPart]
    var notes: [Note]
    
    
    init(id: UUID = UUID(), name: String, position: PositionRecord, type: TechniqueType, bodyParts: [BodyPart], notes: [String]) {
        self.id = id
        self.name = name
        self.position = position
        self.type = type
        self.bodyParts = bodyParts
        self.notes = notes.map {Note(note: $0)}
    }
    
    mutating func setPosition(positionRecord: inout PositionRecord) {
        self.position = positionRecord
        self.position.addAssosiatedTechnique(recordId: self.id)
    }

    mutating func removePosition() {
        var local = position
        local.deleteAssosiatedTechnique(recordId: id)
        position = PositionRecord.EmptyPosition
    }

}

extension TechniqueRecord {
    struct Note: Identifiable, Codable, Equatable {
        let id: UUID
        var note: String
        
        init(id: UUID = UUID(), note: String) {
            self.id = id
            self.note = note
        }
    }
    
    static var emptyRecord: TechniqueRecord {
        TechniqueRecord(
            name: "",
            position: PositionRecord.EmptyPosition,
            type: .new,
            bodyParts:[],
            notes: [])
    }
}

extension TechniqueRecord {
    static let sampleData: [TechniqueRecord] =
    [
        TechniqueRecord(
            name: "Sweep N1 from open guard",
            position: PositionRecord.sampleRecord[0],
            type: .sweep,
            bodyParts:[.leftWrist, .leftThigh, .leftAnkle],
            notes: ["Grab opponent by left wrist, and left ankle, put your leg against their hip, while spinning your body clockwise",
                   "Pull wrist and ankle, while pushing with a knee",
                   "As opponent falls, release his wris, do a technical standup, lift their leg whith your body"]),
        
        TechniqueRecord(
            name: "Open guard pass N1",
            position: PositionRecord.sampleRecord[0],
            type: .guardPass,
            bodyParts: [.leftShin],
            notes: ["Pull your body weight on one of the legs of your oppentn, sit on your toes",
                    "Keep pushing your opponent down, until you're able to walk across your opponent"])
    ]
    
}
