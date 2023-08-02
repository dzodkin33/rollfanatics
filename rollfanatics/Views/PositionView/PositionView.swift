//
//  PositionView.swift
//  rollfanatics
//
//  Created by Борис Рябов on 7/19/23.
//

import SwiftUI

struct PositionView: View {
    @Binding var position: PositionRecord
    @Binding var positions: [PositionRecord]
    @Binding var records: [TechniqueRecord]
    @Binding var bindings: [PositionTechniqueBinding]
    
    var body: some View {
        
        // Title [x]
        // Editable name [x]
        // Change color theme??
        // List of assosiated techniques -> ListView w these techniques [x]
        // Filter and sort of list of techniques and their properties
        
        VStack {
            List {
                Section(header: Text("Basic Info")) {
                    HStack {
                        Text("Name: ")
                        TextField("Name", text: $position.name)
                            .multilineTextAlignment(.trailing)
                    }
                }
                Section(header: Text("List of techniques")) {
                        ForEach($records) { $record in
                            if record.position == position {
                                NavigationLink(destination: TechniqueView(
                                    positions: $positions,
                                    record: $record,
                                    records: $records,
                                    recordPsitionBindings: $bindings,
                                    isViewOnly: true
                                )) {
                                        CardView(record: record).background(record.type.theme.mainColor)
                                    }.listRowBackground(record.type.theme.mainColor)
                            }
                        }
                }
            }
        }.onChange(of: position) {[oldposition = position] newPosition in
            
            // performce the change the binding's and binded recrod's position to newly edited position
            let index: Int? = bindings.firstIndex(where: {$0.position == oldposition})
            
            if (index == nil) {
                return
            } else {
                self.bindings[index!].position = newPosition
                
                for recordId in bindings[index!].listOfTechniques {
                    let recordIndex: Int? = records.firstIndex(where: {$0.id == recordId})
                    records[recordIndex!].position = newPosition
                }
            }
            
        }
        
    }
}

struct PositionView_Previews: PreviewProvider {
    static var previews: some View {
        PositionView(position: .constant(PositionRecord.sampleRecord[0]),
                     positions: .constant(PositionRecord.sampleRecord),
                     records: .constant(TechniqueRecord.sampleData),
                     bindings: .constant(PositionTechniqueBinding.exampleBindings))
    }
}
