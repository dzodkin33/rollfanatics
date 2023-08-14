//
//  CardView.swift
//  rollfanatics
//
//  Created by Борис Рябов on 6/23/23.
//

import SwiftUI

struct CardView: View {
    let record: TechniqueRecord
    var body: some View {
        VStack (alignment: .leading) {
            Text(record.name)
                .font(.headline)
            Spacer()
            HStack {
                            
                Label("\(record.type.name)", systemImage: "puzzlepiece")
                Spacer()
                Label("\(record.position.name)", systemImage: "folder")
                
            }
            .font(.caption)
        }
        .padding()
        .foregroundColor(record.type.theme.accentColor)
    }
}

struct CardView_Previews: PreviewProvider {
    static var sampleData: TechniqueRecord = TechniqueRecord.sampleData[0]
    static var previews: some View {
        CardView(record: sampleData)
            .background(sampleData.type.theme.mainColor)
            .previewLayout(.fixed(width: 400, height: 100))
    }
}
