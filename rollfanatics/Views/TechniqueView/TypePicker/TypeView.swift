//
//  TypeView.swift
//  rollfanatics
//
//  Created by Борис Рябов on 6/29/23.
//

import SwiftUI

struct TypeView: View {
    let type: TechniqueType
    
    var body: some View {
        Text(type.name)
            .padding(4)
            .frame(maxWidth: .infinity)
            .background(type.theme.mainColor)
            .foregroundColor(type.theme.accentColor)
            .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}

struct TypeView_Previews: PreviewProvider {
    static var previews: some View {
        TypeView(type: .sweep)
    }
}
