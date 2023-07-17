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
    
    @Binding var recordPsitionBindings: [PositionTechniqueBinding]
    
    
    var body: some View {
        NavigationStack {
            List($records) {$record in
                NavigationLink(destination: TechniqueView(
                    positions: $positions,
                    record: $record,
                    records: $records,
                    recordPsitionBindings: $recordPsitionBindings)) {
                    CardView(record: record)
                    
                } .listRowBackground(record.type.theme.mainColor)
            }
            .navigationTitle("Technique Wiki")
            .toolbar {
                Button(action: {
                    isPresentingNew = true
                }) {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $isPresentingNew) {
            NewTechniqueView(records: $records, isPresentingNew: $isPresentingNew, positions: $positions, recordPsitionBindings: $recordPsitionBindings)
        }
    }
}

struct TechniqueListView_Previews: PreviewProvider {
    static var previews: some View {
        TechniqueListView(records: .constant(TechniqueRecord.sampleData),
                          positions: .constant(PositionRecord.sampleRecord),
                          recordPsitionBindings: .constant(PositionTechniqueBinding.exampleBindings))
    }
}
