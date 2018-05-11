//
//  RouteInfoPresenter.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 11.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

final class RouteInfoPresenter: BasePresenter {
    
    private weak var connector: AddRouteConnectorDelegate?
    
    init(connector: AddRouteConnectorDelegate) {
        self.connector = connector
    }
    
    
}
