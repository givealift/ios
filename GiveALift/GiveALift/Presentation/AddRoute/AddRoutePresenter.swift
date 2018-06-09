//
//  AddRoutePresenter.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 11.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation
import SVProgressHUD

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
        SVProgressHUD.show()
        routesService.uploadRoute(route: route)
    }
    
    func updateToServer() {
        routesService.updateRoute(route)
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
        print(error)
    }
}


