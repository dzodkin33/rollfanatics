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
    @Binding var bindings: [PositionTechniqueBinding]
    
    var body: some View {
        Picker(selection: $record.position,
               label: Text("Position:")) {
            // todo: it still kinda messes up a lot
            ForEach($positions, id: \.id) { $position in
                PositionPickerCardView(position: $position).tag(position)
            }
        }
               .labelsHidden()
               .pickerStyle(.navigationLink)
               .onChange(of: record.position) {[oldPosition = record.position] newPosition in
                   
                   // Delete a previouse binding
                   let oldIndex: Int? = bindings.firstIndex(where: {$0.position == oldPosition})
                   
                   if oldIndex == nil {
                       
                   } else {
                       bindings[oldIndex!] = bindings[oldIndex!].deleteAssosiatedTechnique(recordId: record.id)
                   }

                   
                   
                   // Add or create a new binding of a record to a new position
                   let index: Int? = bindings.firstIndex(where: {$0.position == newPosition})
                   
                   if index == nil {
                       let newBinding = PositionTechniqueBinding(position: newPosition, listOfTechniques: [record.id])
                       bindings.append(newBinding)
                   } else {
                       bindings[index!] = bindings[index!].addAssosiatedTechnique(recordId: record.id)
                   }
                   
                   print(bindings)
            }
    }
    
    
}

struct PositionPicker_Previews: PreviewProvider {
    static var previews: some View {
        PositionPicker(
            record: .constant(TechniqueRecord.sampleData[0]),
            positions: .constant(PositionRecord.sampleRecord),
            bindings: .constant(PositionTechniqueBinding.exampleBindings)
        )
    }
}
