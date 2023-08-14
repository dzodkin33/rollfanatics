//
//  rollfanaticsApp.swift
//  rollfanatics
//
//  Created by Борис Рябов on 6/23/23.
//

import SwiftUI

@main
struct rollfanaticsApp: App {
    @StateObject private var store = DataStore()
    
    @State var recordBindings:[PositionTechniqueBinding] =  []
    
    var body: some Scene {
        WindowGroup {
            
            TabView {
                TechniqueListView(records: $store.records, positions: $store.positions, bindings: $recordBindings) {
                    Task {
                                                do {
                                                    try await store.saveRecords(recods: store.records)
                                                    try await store.savePositions(positions: store.positions)
                                                } catch {
                                                    fatalError(error.localizedDescription)
                                                }
                    }
                }
                .tabItem {
                    Label("Techniques", systemImage: "rectangle.stack.fill")
                }
                
                PositionListView(positions: $store.positions, records: $store.records, bindings: $recordBindings) {
                    Task {
                                                do {
                                                    try await store.savePositions(positions: store.positions)
                                                } catch {
                                                    fatalError(error.localizedDescription)
                                                }
                    }
                }
                .tabItem {
                    Label("Positions", systemImage: "folder")
                }
            }.task {
                do {
                    try await store.load()
                    
                    for record in store.records {
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
                    
                } catch {
                    fatalError(error.localizedDescription)
                }
            }
        }
    }
}
