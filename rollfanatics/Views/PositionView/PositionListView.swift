//
//  PositionListView.swift
//  rollfanatics
//
//  Created by Борис Рябов on 7/11/23.
//

import SwiftUI

struct PositionListView: View {
    @State var isPresentingNew = false
    @Binding var positions: [PositionRecord]
    @Binding var records: [TechniqueRecord]
    @Binding var bindings: [PositionTechniqueBinding]
    
    // sort by name and number of techniques
    var body: some View {
        NavigationStack {
            List($positions) {$position in
                NavigationLink(destination: PositionView(
                    position: $position,
                    positions: $positions,
                    records: $records,
                    bindings: $bindings)) {
                    PositionCardView(position: $position,
                                     bindings: $bindings)
                }
            }
            .navigationTitle("Position Wiki")
            .toolbar {
                Button(action: {
                    isPresentingNew = true
                }) {
                    Image(systemName: "plus")
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
    }
}

struct PositionListView_Previews: PreviewProvider {
    static var previews: some View {
        PositionListView(
            positions: .constant(PositionRecord.sampleRecord),
            records: .constant(TechniqueRecord.sampleData),
            bindings: .constant(PositionTechniqueBinding.exampleBindings)
        )
    }
}
