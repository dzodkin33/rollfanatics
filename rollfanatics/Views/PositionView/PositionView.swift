//
//  PositionView.swift
//  rollfanatics
//
//  Created by Борис Рябов on 7/19/23.
//

import SwiftUI

struct PositionView: View {
    @State private var showAlert = false
    
    @Binding var position: PositionRecord
    
    @Binding var positions: [PositionRecord]
    
    @Binding var records: [TechniqueRecord]
    
    @Binding var bindings: [PositionTechniqueBinding]
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        
        // Title [x]
        // Editable name [x]
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
                        // todo later add the navigation link to these cards
                        ForEach($records) { $record in
                            if record.position == position {
                                CardView(record: record).listRowBackground(record.type.theme.mainColor)
                            }
                        }
                }
            }
            .toolbar {
                Button("Delete") {
                    showAlert = true
                }
            }
            .alert(isPresented: $showAlert) { 
                Alert(
                    title: Text("Confirm Deletion"),
                    message: Text("Are you sure you want to delete a Position?"),
                    primaryButton: .destructive(Text("Delete")) {
                        deletePosition()
                        presentation.wrappedValue.dismiss()
                    },
                    secondaryButton: .cancel()

                )
            }
        }.onChange(of: position) {[oldposition = position] newPosition in
            
            // performe the change the binding's and binded recrod's position to newly edited position
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
    
    
    func deletePosition() {
        for index in $positions.indices {
            if $positions[index].id == position.id  {
                positions.remove(at: index)
                return
            }
        }
        
        // todo: delete the binding as well
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
