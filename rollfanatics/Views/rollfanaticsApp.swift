//
//  rollfanaticsApp.swift
//  rollfanatics
//
//  Created by Борис Рябов on 6/23/23.
//

import SwiftUI

@main
struct rollfanaticsApp: App {
    @State var positions: [PositionRecord] = PositionRecord.sampleRecord
    @State var records:[TechniqueRecord] = TechniqueRecord.sampleData// todo: populate here
    @State var recordBindings:[PositionTechniqueBinding] =  []
    
    // TODO: here we also have to load up data from
    init() {
        
        
        // Performs binding population
        for record in records {
            let pos: PositionRecord = record.position
            var binding = recordBindings.first(where: {$0.position == pos})
            
            if (binding != nil) {
                binding?.addAssosiatedTechnique(recordId: record.id)
            } else {
                let binding = PositionTechniqueBinding(
                position: pos,
                listOfTechniques: [record.id])
                recordBindings.append(binding)
            }
        }
        
    }
    
    var body: some Scene {
        WindowGroup {
            TechniqueListView(records: $records, positions: $positions, recordPsitionBindings: $recordBindings)
        }
    }
}
