//
//  NewPositionView.swift
//  rollfanatics
//
//  Created by Борис Рябов on 8/2/23.
//

import SwiftUI

struct NewPositionView: View {

    @State private var newPosition = PositionRecord.EmptyPosition
    @Binding var isPresentingNew: Bool
    @Binding var positions: [PositionRecord]
    @Binding var records: [TechniqueRecord]
    @Binding var bindings: [PositionTechniqueBinding]
    
    
    var body: some View {
        NavigationStack {
            PositionView(
                position: $newPosition,
                positions: $positions,
                records: $records,
                bindings: $bindings
            )
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Dissmiss") {
                        isPresentingNew = false
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        positions.append(newPosition)
                        isPresentingNew = false
                    }
                }
            }
        }
    }
}

struct NewPositionView_Previews: PreviewProvider {
    static var previews: some View {
        NewPositionView(
            isPresentingNew: .constant(true),
            positions: .constant(PositionRecord.sampleRecord),
            records: .constant(TechniqueRecord.sampleData),
            bindings: .constant(PositionTechniqueBinding.exampleBindings)
        )
    }
}
