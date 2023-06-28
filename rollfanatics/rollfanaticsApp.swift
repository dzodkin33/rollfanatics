//
//  rollfanaticsApp.swift
//  rollfanatics
//
//  Created by Борис Рябов on 6/23/23.
//

import SwiftUI

@main
struct rollfanaticsApp: App {
    @State var records:[TechniqueRecord] = TechniqueRecord.sampleData
    var body: some Scene {
        WindowGroup {
           TechniqueListView(records: $records)
        }
    }
}
