//
//  AddRoutePresenter.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 11.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

class AddRoutePresenter: BasePresenter, AddRouteService {
    
    
    weak var connector: AddRouteConnectorDelegate?
    private var routesService = RoutesService()
    var route: Route {
        didSet {
            print(route)
        }
    }
    var isUpdating: Bool
    
    init(connector: AddRouteConnectorDelegate, route: Route, isUpdating: Bool) {
        self.connector = connector
        self.route = route
        self.isUpdating = isUpdating
        super.init()
        routesService.addDelegate = self
    }
    
    func uploadToServer() {
        routesService.uploadRoute(route: route)
    }
    
    func updateToServer() {
        routesService.updateRoute(route)
    }
    
    func updateSuccess() {
        connector?.showHomeView()
    }
    
    func serviceError(_ error: APIError) {
        print(error)
    }
}


