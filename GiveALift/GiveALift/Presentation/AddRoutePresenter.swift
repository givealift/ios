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
    private let addRoute: AddRoute
    
    let fromTextFieldPlaceholder = "Wprowadź miasto startowe"
    let fromLocationPlaceholder = "Podaj miejsce spotkania"
    let toTextFieldPlaceholder = "Wproawdź miasto docelowe"
    let toLocationPlaceholder = "Podaj miejsce docelowe"
    
    init(connector: AddRouteConnectorDelegate) {
        self.connector = connector
        self.addRoute = AddRoute()
    }
    
    func showIndirectionView(fromCityId: Int, fromLocation: String, toCityId: Int, toLocation: String) {
        updateModel(fromCityId: fromCityId, fromLocation: fromLocation, toCityId: toCityId, toLocation: toLocation)
        connector?.showIndirectionsView(addRoute: addRoute)
    }
    
    private func updateModel(fromCityId: Int, fromLocation: String, toCityId: Int, toLocation: String) {
        addRoute.from = RouteLocation()
        addRoute.from.city = AddRouteCity()
        addRoute.from.city.cityId = fromCityId
        addRoute.from.placeOfMeeting = fromLocation
        addRoute.to = RouteLocation()
        addRoute.to.city = AddRouteCity()
        addRoute.to.city.cityId = toCityId
        addRoute.to.placeOfMeeting = toLocation
    }
}
