//
//  EditRouteInfoPresenter.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 15.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation
import SVProgressHUD

final class EditRouteInfoPresenter: BasePresenter, AddRouteService {
    
    private let routeService = RoutesService()
    private weak var connector: AddRouteConnectorDelegate?
    private var route: Route
    
    init(connector: AddRouteConnectorDelegate, route: Route, isUpdating: Bool) {
        self.connector = connector
        self.route = route
        super.init()
        routeService.addDelegate = self
    }
    
    func showMainRouteView() {
        connector?.showMainRouteView(route: route, isUpdating: true)
    }
    
    func showIndirectsView() {
        connector?.showIndirectionsView(route: route, isUpdating: true)
    }
    
    func showRouteTimeView() {
        connector?.showRouteTimeView(route: route, isUpdating: true)
    }
    
    func showRouteInfoView() {
        connector?.showRouteInfoView(route: route, isUpdating: true)
    }
    
    func showOptionalDescriotionView() {
        connector?.showRouteOptionalDescriptionView(route: route, isUpdating: true)
    }
    
    func updateToServer() {
        route.stops = nil
        routeService.updateRoute(route)
    }
    
    func deleteRoute() {
        routeService.deleteRoute(route.routeId)
        connector?.showHomeView()
    }
    
    func updateSuccess() {
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.setMinimumDismissTimeInterval(1.0)
        SVProgressHUD.showSuccess(withStatus: "Powodzenie")
        connector?.showHomeView()
    }
    
    func serviceError(_ error: APIError) {
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.setMinimumDismissTimeInterval(1.0)
        SVProgressHUD.showError(withStatus: "Niepowodzenie")
    }
    
}
