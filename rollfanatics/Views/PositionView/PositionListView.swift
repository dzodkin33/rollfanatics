//
//  PositionListView.swift
//  rollfanatics
//
//  Created by Борис Рябов on 7/11/23.
//

import SwiftUI

struct PositionListView: View {
    @State var isPresentingNew = false
    
    @State private var sortType: PositionSortTypes = .none
    
    @Binding var positions: [PositionRecord]
    
    @Binding var records: [TechniqueRecord]
    
    @Binding var bindings: [PositionTechniqueBinding]
    
    @Environment(\.scenePhase) private var scenePhase
    
    let saveAction: ()->Void
    
    var sortedPositions: [PositionRecord] {
        switch sortType {
        case .name:
            return positions.sorted {
                $0.name < $1.name
            }
        case .number:
            return positions.sorted {
                let lhs: PositionRecord = $0
                let rhs: PositionRecord = $1
                return bindings.first(where: {$0.position == lhs})!.listOfTechniques.count > bindings.first(where: {$0.position == rhs})!.listOfTechniques.count
            }
        case .none:
            return positions
        }
    }
    
    // sort by name and number of techniques
    var body: some View {
        NavigationStack {
            
            List(sortedPositions) {position in
                NavigationLink(destination: PositionView(
                    position: $positions[positions.firstIndex(of: position)!],
                    positions: $positions,
                    records: $records,
                    bindings: $bindings)) {
                    PositionCardView(position: position,
                                     bindings: $bindings)
                }
            }
            .navigationTitle("Position Wiki")
            .toolbar {
                ToolbarItemGroup {
                    Button(action: {
                        isPresentingNew = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
                
                ToolbarItemGroup(placement: .navigation) {
                    HStack {
                        Picker("Sort",selection: $sortType) {
                            ForEach(PositionSortTypes.allCases, id: \.self) { value in
                                VStack(alignment: .leading) {
                                    HStack{
                                        Image(systemName: "line.3.horizontal.decrease")
                                        Text(value.toName)
                                    }.tag(value)
                                }
                            }
                        }.labelsHidden()

                    }
                }
                
            }
        }
        .sheet(isPresented: $isPresentingNew) {
            NewPositionView(
                isPresentingNew: $isPresentingNew,
                positions: $positions,
                records: $records,
                bindings: $bindings
            )
            
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive {saveAction()}
        }
    }
}

enum PositionSortTypes: CaseIterable {
    case number, name, none
    
    var toName : String {
        switch self {
        case .name: return "Name"
        case .number: return "Number"
        case .none: return "None"
            
        }
    }
}
