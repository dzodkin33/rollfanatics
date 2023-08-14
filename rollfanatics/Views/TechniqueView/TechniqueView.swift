//
//  TechniqueView.swift
//  rollfanatics
//
//  Created by Борис Рябов on 6/25/23.
//

import SwiftUI

struct TechniqueView: View {
    
    @Binding var positions: [PositionRecord]
    
    // A current desplayed record
    @Binding var record: TechniqueRecord
    
    // A list of all records
    @Binding var records: [TechniqueRecord]
    
    // An empty placeholder note
    @State private var newNote = ""
    
    // Determines if to show a conformation pop up
    @State private var showAlert = false
    
    @Binding var recordPsitionBindings: [PositionTechniqueBinding]
    
    var isViewOnly: Bool // referce to if it's possible to change the position of the technique

    @Environment(\.presentationMode) var presentation
    
    var body: some View {
            List {
                Section (header: Text("Basic Info")) {
                    HStack {
                        Text("Name:")
                        TextField("Name", text: $record.name)
                            .multilineTextAlignment(.trailing)

                    }
                    
                    if !isViewOnly {
                        PositionPicker(record: $record,
                                       positions: $positions,
                                       bindings: $recordPsitionBindings)
                    } else {
                        HStack {
                            Text("Position:")
                            Spacer()
                            Text(record.position.name)
                        }
                    }
                    TypePickerView(selected: $record.type)
                }
                Section (header: Text("Notes")) {
                    ForEach($record.notes) { note in
                        HStack {
                            Image(systemName: "list.bullet")
                            TextField("Note", text: note.note, axis: .vertical)
                            Spacer()
                        }
                    }.onDelete { indexSet in
                        record.notes.remove(atOffsets: indexSet)
                    }.onMove(perform: moveItem)
                    
                    HStack {
                        TextField("New Note",
                                  text: $newNote)
                        Button(action: {
                            withAnimation {
                                let newNoteObject = TechniqueRecord.Note(note: newNote)
                                record.notes.append(newNoteObject)
                                newNote = ""
                            }
                        }) {
                            Image(systemName: "plus.circle")
                        }
                        .disabled(newNote.isEmpty)
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
                message: Text("Are you sure you want to delete a technique?"),
                primaryButton: .destructive(Text("Delete")) {
                    deleteRecord()
                    presentation.wrappedValue.dismiss()
                },
                secondaryButton: .cancel()

            )

        }
    }
    
    // Moves notes up and down
    func moveItem(from source: IndexSet, to destination: Int) {
        record.notes.move(fromOffsets: source, toOffset: destination)
    }
    
    // Delete current record and go back to navigation view 
    func deleteRecord() {
        for index in $records.indices {
            if $records[index].id == record.id  {
                records.remove(at: index)
                return
            }
        }
        
        // todo: delete the binding as well
    }

}

struct TechniqueView_Previews: PreviewProvider {
    static var previews: some View {
        TechniqueView(positions: .constant(PositionRecord.sampleRecord),
                    record: .constant(TechniqueRecord.sampleData[0]),
                      records:  .constant(TechniqueRecord.sampleData),
                      recordPsitionBindings: .constant(PositionTechniqueBinding.exampleBindings),
                      isViewOnly: false
        )
    }
}
