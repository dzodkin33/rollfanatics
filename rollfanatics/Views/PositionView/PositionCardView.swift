//
//  PositionCardView.swift
//  rollfanatics
//
//  Created by Борис Рябов on 7/11/23.
//

import SwiftUI

struct PositionCardView: View {
    let position: PositionRecord
    @Binding var bindings: [PositionTechniqueBinding]
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(position.name).font(.headline)
            Spacer()
            HStack {
                HStack {
                    Label("Number of techniques", systemImage: "number")
                    Text("\(countTechniques(position: position, bindings: bindings))")
                }
                Spacer()
            }
            .font(.caption)
        }
        .padding()
    }
}

struct PositionCardView_Previews: PreviewProvider {
    static var previews: some View {
        PositionCardView(position: PositionRecord.sampleRecord[0],
                         bindings: .constant(PositionTechniqueBinding.exampleBindings))
            .previewLayout(.fixed(width: 400, height: 100))
    }
}


func countTechniques(position: PositionRecord, bindings: [PositionTechniqueBinding]) -> Int {
    let index: Int? = bindings.firstIndex(where: {$0.position == position})
    
    if (index != nil) {
        return bindings[index!].listOfTechniques.count
    }
    return 0;
}
