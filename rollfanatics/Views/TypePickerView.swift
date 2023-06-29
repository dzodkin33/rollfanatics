//
//  TypePickerView.swift
//  rollfanatics
//
//  Created by Борис Рябов on 6/29/23.
//

import SwiftUI

struct TypePickerView: View {
    @Binding var selected: TechniqueType
    
    var body: some View {
        Picker("Techique Type:", selection: $selected) {
            ForEach(TechniqueType.allCases) {type in
                TypeView(type: type).tag(type)
            }
        }.pickerStyle(.navigationLink)
    }
}

struct TypePickerView_Previews: PreviewProvider {
    static var previews: some View {
        TypePickerView(selected: .constant(.sweep))
    }
}
