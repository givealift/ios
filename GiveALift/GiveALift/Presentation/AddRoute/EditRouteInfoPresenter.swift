//
//  EditRouteInfoPresenter.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 15.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

final class EditRouteInfoPresenter: AddRoutePresenter {
    
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
    
    func deleteRoute() {
        //MARK:- TODO usunięcie ze stronki
        connector?.showHomeView()
    }
}
