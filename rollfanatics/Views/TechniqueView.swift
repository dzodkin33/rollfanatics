//
//  TechniqueView.swift
//  rollfanatics
//
//  Created by Борис Рябов on 6/25/23.
//

import SwiftUI

struct TechniqueView: View {
    @Binding var record: TechniqueRecord
    @State private var newNote = ""
    
    var body: some View {
        NavigationView{
            List {
                Section (header: Text("Basic Info")) {
                    HStack {
                        Text("Name:")
                        TextField("Name", text: $record.name)
                            .multilineTextAlignment(.trailing)

                    }
                    HStack {
                        Text("From position:")
                        Spacer()
                        Text(record.position)
                    }
                    
                    HStack {
                        Text("Type:")
                        Spacer()
                        Text("\(record.type.name)")
                            .padding(4)
                            .background(record.type.theme.mainColor)
                            .foregroundColor(record.type.theme.accentColor)
                            .cornerRadius(4)
                    }
                }
                Section (header: Text("Notes")) {
                    ForEach(record.notes) { note in
                        HStack {
                            Image(systemName: "list.bullet")
                            Text(note.note)
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
        }
    }
    func moveItem(from source: IndexSet, to destination: Int) {
        record.notes.move(fromOffsets: source, toOffset: destination)
    }

}

struct TechniqueView_Previews: PreviewProvider {
    static var previews: some View {
        TechniqueView(record: .constant(TechniqueRecord.sampleData[0]))
    }
}
