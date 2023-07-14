//
//  PositionPicker.swift
//  rollfanatics
//
//  Created by Борис Рябов on 7/10/23.
//

import SwiftUI

struct PositionPicker: View {
    @Binding var record: TechniqueRecord
    @Binding var positions: [PositionRecord]
    
    var body: some View {
        Picker(selection: $record.position,
               label: Text("Position: \(record.position.name)")) {
            // todo: it still kinda messes up a lot
            ForEach($positions, id: \.id) { $position in
                PositionPickerCardView(position: $position).tag(position)
            }
        }
               .labelsHidden()
               .pickerStyle(.navigationLink)
               .onChange(of: record.position) {newPosition in
                guard let positionRecordIndex = positions.firstIndex(of: newPosition) else {
                    return
                }
                positions[positionRecordIndex].addAssosiatedTechnique(recordId: record.id)
            }
    }
    
    
    // TODO: change ID bidning for position record on change
}

struct PositionPicker_Previews: PreviewProvider {
    static var previews: some View {
        PositionPicker(
            record: .constant(TechniqueRecord.sampleData[0]),
            positions: .constant(PositionRecord.sampleRecord)
        )
    }
}
