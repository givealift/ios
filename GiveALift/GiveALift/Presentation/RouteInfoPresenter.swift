//
//  RouteInfoPresenter.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 11.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

final class RouteInfoPresenter: BasePresenter {
    
    //MARK:- Constants
    let pricePlaceholder = "Wpisz cenę przejazdu"
    let numberOfSeatsPlaceholder = "Wpisz ilość wolnych miejsc"
    
    private weak var connector: AddRouteConnectorDelegate?
    private var route: Route
    
    init(connector: AddRouteConnectorDelegate, route: Route, isUpdating: Bool) {
        self.connector = connector
        self.route = route
    }
    
    func showRouteOptionalDescriptionView(price: Int, numberOfSeats: Int) {
        updateModel(price: price, numberOfSeats: numberOfSeats)
        connector?.showRouteOptionalDescriptionView(route: route, isUpdating: false)
    }
    
    private func updateModel(price: Int, numberOfSeats: Int) {
        route.price = price
        route.numberOfSeats = numberOfSeats
    }
}
