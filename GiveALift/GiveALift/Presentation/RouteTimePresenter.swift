//
//  RouteTimePresenter.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 11.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

final class RouteTimePresenter: BasePresenter {
    
    let datePlaceholder = "Wybierz datę odjazdu"
    let timePlaceholder = "Wybierz godzinę odjazdu"
    
    private weak var connector: AddRouteConnector?
    
    init(connector: AddRouteConnector) {
        self.connector = connector
    }
    
    func showRouteInfoView() {
        connector?.showRouteInfoView()
    }
}
