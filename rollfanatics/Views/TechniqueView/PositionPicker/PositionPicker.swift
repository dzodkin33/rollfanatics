//
//  PositionPicker.swift
//  rollfanatics
//
//  Created by Борис Рябов on 7/10/23.
//

import SwiftUI

struct PositionPicker: View {
    @Binding var selected: PositionRecord
    @Binding var positions: [PositionRecord]
    
    var body: some View {
        Picker("Position:",
               selection: $selected) {
            ForEach($positions) { position in
                PositionPickerCardView(position: position).tag(position.id)
            }
        }.pickerStyle(.navigationLink)
    }
    
    
    // TODO: change ID bidning for position record on change
}

struct PositionPicker_Previews: PreviewProvider {
    static var previews: some View {
        PositionPicker(
            selected: .constant(PositionRecord.sampleRecord[0]),
            positions: .constant(PositionRecord.sampleRecord)
        )
    }
}
