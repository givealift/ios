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
        self.filterStrings(cities.map({$0.name!}))
        setBottomLine(borderColor: .black)
        setupFont()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.cities = loadCities()
        self.filterStrings(cities.map({$0.name!}))
        setBottomLine(borderColor: .black)
        setupFont()
    }
    
    func selectedCityId() -> Int? {
        if let cityText = self.text {
            if let city = cities.first(where: {$0.name == cityText}) {
                return city.cityID
            }
        }
        return nil
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
    
    func setBottomLine(borderColor: UIColor) {
        self.borderStyle = .none
        self.backgroundColor = .clear
        let borderLine = UIView()
        let height = 1.0
        let textFieldHeight = Double(self.frame.height)
        borderLine.frame = CGRect(x: 0, y: textFieldHeight*0.85, width: Double(self.frame.width), height: height)
        borderLine.backgroundColor = borderColor
        self.addSubview(borderLine)
    }
    
    override func textFieldDidBeginEditing() {
        setupBlackTextfield(withText: nil)
    }
    
    private func setupFont() {
        self.font = UIFont.systemFont(ofSize: 14)
    }
}
