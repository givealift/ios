//
//  Int.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 15.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

extension Int {
    
    func name() -> String {
        let cities = loadCities()
        let city = cities.first(where: { $0.cityID == self })
        return city!.name!
    }
    
    private func loadCities() -> [City] {
        if let path = Bundle.main.path(forResource: "Cities", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .dataReadingMapped)
                let decoder = JSONDecoder()
                let cities = try decoder.decode([City].self, from: data)
                return cities
            } catch {
                fatalError("Couldn't load cities")
            }
        }
        return []
    }
}
