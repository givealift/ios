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
    private let addRoute: AddRoute
    
    init(connector: AddRouteConnectorDelegate, addRoute: AddRoute) {
        self.connector = connector
        self.addRoute = addRoute
    }
    
    
}
