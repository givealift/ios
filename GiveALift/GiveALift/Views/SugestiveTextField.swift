//
//  SugestiveTextField.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 17.04.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit
import SearchTextField

final class SugestiveTextField: SearchTextField {
    
    private var cities: [City]!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.cities = loadCities()
        self.filterStrings(cities.map({$0.name}))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.cities = loadCities()
        self.filterStrings(cities.map({$0.name}))
    }
    
    func selectedCityId() -> Int? {
        if let cityText = self.text {
            if let city = cities.first(where: {$0.name == cityText}) {
                return city.cityID
            }
        }
        return nil
    }
    
    func setPlaceholder(with text: String) {
        setupGrayTextfield(withText: text)
    }
    
    private func setupGrayTextfield(withText text: String) {
        self.textColor = UIColor.lightGray
        self.text = text
    }
    
    private func setupBlackTextfield(withText text: String?) {
        self.textColor = UIColor.black
        self.text = text
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
    
    override func textFieldDidBeginEditing() {
        setupBlackTextfield(withText: nil)
    }
}
