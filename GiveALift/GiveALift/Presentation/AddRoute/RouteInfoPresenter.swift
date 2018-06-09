//
//  RouteInfoPresenter.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 11.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

final class RouteInfoPresenter: AddRoutePresenter {
    
    //MARK:- Constants
    let pricePlaceholder = "Cena przejazdu"
    let numberOfSeatsPlaceholder = "Ilość wolnych miejsc"
    
    func showRouteOptionalDescriptionView(price: Int, numberOfSeats: Int) {
        updateModel(price: price, numberOfSeats: numberOfSeats)
        connector?.showRouteOptionalDescriptionView(route: route, isUpdating: false)
    }
    
    func showEditRouteInfoView(price: Int, numberOfSeats: Int) {
        updateModel(price: price, numberOfSeats: numberOfSeats)
        connector?.showPreviuosView()
    }
    
    private func updateModel(price: Int, numberOfSeats: Int) {
        route.price = price
        route.numberOfSeats = numberOfSeats
        route.numberOfOccupiedSeats = 0
    }
}
