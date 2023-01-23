//
//  ModelData.swift
//  Elev8r
//
//  Created by Thomas Boggs on 1/22/23.
//

import Foundation

final class ModelData: ObservableObject {
    @Published var elevators: [Elevator] = load("elevatorData.json")
}

func load<T: Decodable>(_ filename: String) -> T {
    var data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't Load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        var decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

func save<T: Encodable>(_ elevators: T) {
    let encoder = JSONEncoder()
    
    if let encoded = try? encoder.encode(elevators) {
        print(encoded)
    }
}
