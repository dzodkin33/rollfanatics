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
            let index: Int? = recordBindings.firstIndex(where: {$0.position == pos})
            
            if (index != nil) {
                recordBindings[index!] = recordBindings[index!].addAssosiatedTechnique(recordId: record.id) // might work or not lol
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
            NavigationView {
                VStack {
                    NavigationLink(destination:TechniqueListView(records: $records, positions: $positions, bindings: $recordBindings)) {
                        Text("To techniques").font(.headline)
                    }
                    
                    NavigationLink(destination:PositionListView(positions: $positions, records: $records, bindings: $recordBindings)) {
                        Text("To positions").font(.headline)
                    }
                }
            }
        }
    }
}
