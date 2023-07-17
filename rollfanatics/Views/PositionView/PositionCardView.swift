//
//  PositionCardView.swift
//  rollfanatics
//
//  Created by Борис Рябов on 7/11/23.
//

import SwiftUI

struct PositionCardView: View {
    @Binding var position: PositionRecord
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(position.name).font(.headline)
            Spacer()
            HStack {
                HStack {
                    Text("Number of techniques")
                    // Text("\(position.listOfTechniques.count)")
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
        PositionCardView(position: .constant(PositionRecord.sampleRecord[0])).previewLayout(.fixed(width: 400, height: 100))
    }
}
