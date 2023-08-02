//
//  NewTechniqueView.swift
//  rollfanatics
//
//  Created by Борис Рябов on 6/28/23.
//

import SwiftUI

struct NewTechniqueView: View {
    @State private var newRecord = TechniqueRecord.emptyRecord
    @Binding var records: [TechniqueRecord]
    @Binding var isPresentingNew: Bool
    @Binding var positions: [PositionRecord]
    @Binding var recordPsitionBindings: [PositionTechniqueBinding]
    
    var body: some View {
        NavigationStack {
            TechniqueView(
                positions: $positions,
                record: $newRecord,
                records: $records,
                recordPsitionBindings: $recordPsitionBindings,
                isViewOnly: false
            )
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Dissmiss") {
                            isPresentingNew = false
                        }
                    }
                    
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") {
                            records.append(newRecord)
                            isPresentingNew = false
                        }
                    }
                }
        }
    }
}

struct NewTechniqueView_Previews: PreviewProvider {
    static var previews: some View {
        NewTechniqueView(
            records: .constant(TechniqueRecord.sampleData),
            isPresentingNew: .constant(true),
            positions: .constant(PositionRecord.sampleRecord),
            recordPsitionBindings: .constant(PositionTechniqueBinding.exampleBindings))
    }
}
