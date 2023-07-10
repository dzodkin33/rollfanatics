//
//  PositionPickerCardView.swift
//  rollfanatics
//
//  Created by Борис Рябов on 7/10/23.
//

import SwiftUI

struct PositionPickerCardView: View {
    @Binding var position: PositionRecord
    
    var body: some View {
        Text(position.name)
            .padding(4)
            .frame(maxWidth: .infinity)
            .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}

struct PositionPickerCardView_Previews: PreviewProvider {
    static var previews: some View {
        PositionPickerCardView(position: .constant(PositionRecord.sampleRecord[0]))
    }
}
