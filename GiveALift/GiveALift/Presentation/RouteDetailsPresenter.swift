//
//  RouteDetailsPresenter.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 13.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

final class RouteDetailsPresenter: BasePresenter {
    
    private weak var connector: SearchConnectorDelegate?
    let route: Route
    var isUserOwner: Bool {
        if let galUserResponse = route.galUserPublicResponse {
            return galUserResponse.userID == User.shared.userID!
        } else {
            return route.ownerId! == User.shared.userID!
        }
    }
    
    init(connector: SearchConnectorDelegate, route: Route) {
        self.connector = connector
        self.route = route
    }
    
    func showUserInfoView() {
       // connector?.showUserInfoView(userData: route.galUserPublicResponse!.toGALUserInfo())
    }
    
    func showEditRouteInfo() {
        connector?.showEditRouteView(route: route)
    }
}
