//
//  DataStore.swift
//  rollfanatics
//
//  Created by Борис Рябов on 8/8/23.
//

import Foundation

class DataStore: ObservableObject   {
    @Published var positions: [PositionRecord] = []
    @Published var records: [TechniqueRecord] = []
     
    private static func positionsFileUrl() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                            in: .userDomainMask,
                                            appropriateFor: nil,
                                            create: false)
                .appendingPathComponent("positions.data")

    }
    
    private static func recordsFileUrl() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                            in: .userDomainMask,
                                            appropriateFor: nil,
                                            create: false)
                .appendingPathComponent("records.data")

    }
    
    func load() async throws {
            let loadPositionsTask = Task<[PositionRecord], Error> {
                let fileURL = try Self.positionsFileUrl()
                guard let data = try? Data(contentsOf: fileURL) else {
                    return []
                }
                let positions = try JSONDecoder().decode([PositionRecord].self, from: data)
                return positions
            }
            let positions = try await loadPositionsTask.value
            self.positions = positions
        
        
            let loadRecordsTask = Task<[TechniqueRecord], Error> {
                let fileURL = try Self.recordsFileUrl()
                guard let data = try? Data(contentsOf: fileURL) else {
                    return []
                }
                let records = try JSONDecoder().decode([TechniqueRecord].self, from: data)
                return records
            }
            let records = try await loadRecordsTask.value
            self.records = records

        }
    
    
    func savePositions(positions: [PositionRecord]) async throws {
            let savePositionsTask = Task {
                let data = try JSONEncoder().encode(positions)
                let outfile = try Self.positionsFileUrl()
                try data.write(to: outfile)
            }
        
            _ = try await savePositionsTask.value
        }
    
    func saveRecords(recods: [TechniqueRecord]) async throws {
        let saveRecordsTask = Task {
            let data = try JSONEncoder().encode(records)
            let outfile = try Self.recordsFileUrl()
            try data.write(to: outfile)
        }
        
        _ = try await saveRecordsTask.value
    }
    
}
