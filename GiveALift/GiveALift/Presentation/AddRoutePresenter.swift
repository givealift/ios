//
//  AddRoutePresenter.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 11.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

final class AddRoutePresenter: BasePresenter {
    
    private weak var connector: AddRouteConnectorDelegate?
    var route: Route
    var isUpdating: Bool
    
    let fromTextFieldPlaceholder = "Wprowadź miasto startowe"
    let fromLocationPlaceholder = "Podaj miejsce spotkania"
    let toTextFieldPlaceholder = "Wproawdź miasto docelowe"
    let toLocationPlaceholder = "Podaj miejsce docelowe"
    
    init(connector: AddRouteConnectorDelegate, route: Route, isUpdating: Bool) {
        self.connector = connector
        self.route = route
        self.isUpdating = isUpdating
    }
    
    func showIndirectionView(fromCityId: Int, fromLocation: String, toCityId: Int, toLocation: String) {
        updateModel(fromCityId: fromCityId, fromLocation: fromLocation, toCityId: toCityId, toLocation: toLocation)
        connector?.showIndirectionsView(route: route, isUpdating: false)
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
}
