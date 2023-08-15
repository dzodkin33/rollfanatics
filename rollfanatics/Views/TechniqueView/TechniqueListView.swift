//
//  TechniqueListView.swift
//  rollfanatics
//
//  Created by Борис Рябов on 6/25/23.
//

import SwiftUI

struct TechniqueListView: View {
    @State private var isPresentingNew = false
    
    @Binding var records: [TechniqueRecord]
    
    @Binding var positions: [PositionRecord]
    
    @Binding var bindings: [PositionTechniqueBinding]
    
    @Environment(\.scenePhase) private var scenePhase
    
    let saveAction: ()->Void
    
    @State private var sortType: RecordsSortType = .none
    
    var sortedRecords: [TechniqueRecord] {
        switch sortType {
        case .type:
            return records.sorted {
                $0.type.name < $1.type.name
            }
        case .position:
            return records.sorted {
                $0.position.name < $1.position.name
            }
        case .name:
            return records.sorted {
                $0.name < $1.name
            }
        case .none:
            return records
        }
    }
    
    var body: some View {
        NavigationStack {
            List(sortedRecords) {record in
                NavigationLink(destination: TechniqueView(
                    positions: $positions,
                    record: $records[records.firstIndex(of: record)!],
                    records: $records,
                    bindings: $bindings,
                    isViewOnly: false)) {
                    CardView(record: record)
                    
                } .listRowBackground(record.type.theme.mainColor)
            }
            .navigationTitle("Technique Wiki")
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
                            ForEach(RecordsSortType.allCases, id: \.self) { value in
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
            NewTechniqueView(records: $records, isPresentingNew: $isPresentingNew, positions: $positions, recordPsitionBindings: $bindings)
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive {saveAction()}
        }
    }
}

struct TechniqueListView_Previews: PreviewProvider {
    static var previews: some View {
        TechniqueListView(records: .constant(TechniqueRecord.sampleData),
                          positions: .constant(PositionRecord.sampleRecord),
                          bindings: .constant(PositionTechniqueBinding.exampleBindings), saveAction: {})
    }
}

enum RecordsSortType: CaseIterable {
    case type, position, name, none
    
    var toName : String {
        switch self {
        case .type: return "Type"
        case .name: return "Name"
        case .position: return "Position"
        case .none: return "None"
            
        }
    }
}
