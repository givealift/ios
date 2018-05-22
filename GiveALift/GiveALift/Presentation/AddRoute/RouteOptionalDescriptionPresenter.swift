//
//  RouteOptionalDescription.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 12.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

final class RouteOptionalDescriptionPresenter: AddRoutePresenter {
    
    func showHomeView(description: String?) {
        updateModel(description: description)
        addRouteToServer()
        connector?.showHomeView()
    }
    
    private func updateModel(description: String?) {
        route.description = description
    }
    
    private func addRouteToServer() {
        //let galUserPublicResponse = GalUserPublicResponse(userId: User.shared.userID)
        //route.galUserPublicResponse = galUserPublicResponse
        route.ownerId = User.shared.userID
        APIManager.shared.addRoute(route: route)
    }
}
