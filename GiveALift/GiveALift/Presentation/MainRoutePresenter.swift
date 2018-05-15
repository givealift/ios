//
//  MainRoutePresenter.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 15.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

final class MainRoutePresenter: AddRoutePresenter {
    
    let fromTextFieldPlaceholder = "Wprowadź miasto startowe"
    let fromLocationPlaceholder = "Podaj miejsce spotkania"
    let toTextFieldPlaceholder = "Wproawdź miasto docelowe"
    let toLocationPlaceholder = "Podaj miejsce docelowe"
    
    func showIndirectionView(fromCityId: Int, fromLocation: String, toCityId: Int, toLocation: String) {
        if isUpdating {
            updateOldModel(fromCityId: fromCityId, fromLocation: fromLocation, toCityId: toCityId, toLocation: toLocation)
            connector?.showPreviuosView()
        } else {
            updateModel(fromCityId: fromCityId, fromLocation: fromLocation, toCityId: toCityId, toLocation: toLocation)
            connector?.showIndirectionsView(route: route, isUpdating: false)
        }
    }
    
    private func updateModel(fromCityId: Int, fromLocation: String, toCityId: Int, toLocation: String) {
        route.from = Location()
        route.from.city = City()
        route.from.city.cityID = fromCityId
        route.from.placeOfMeeting = fromLocation
        route.to = Location()
        route.to.city = City()
        route.to.city.cityID = toCityId
        route.to.placeOfMeeting = toLocation
    }
    
    private func updateOldModel(fromCityId: Int, fromLocation: String, toCityId: Int, toLocation: String) {
        route.from.city.cityID = fromCityId
        route.to.city.cityID = toCityId
        route.from.placeOfMeeting = fromLocation
        route.to.placeOfMeeting = toLocation
    }
}
