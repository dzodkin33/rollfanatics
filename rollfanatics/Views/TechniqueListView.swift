//
//  TechniqueListView.swift
//  rollfanatics
//
//  Created by Борис Рябов on 6/25/23.
//

import SwiftUI

struct TechniqueListView: View {
    var records: [TechniqueRecord]
    var body: some View {
        List(records) {record in
            VStack {
                CardView(record: record)

            } .listRowBackground(record.type.theme.mainColor)
        }
    }
}

struct TechniqueListView_Previews: PreviewProvider {
    static var previews: some View {
        TechniqueListView(records: TechniqueRecord.sampleData)
    }
}
