//
//  RouteDetailsPresenter.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 13.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

protocol RouteDetailView: class {
    func updateUserImage(_ image: UIImage)
    func showError(with message: String)
    func success(with message: String)
}

final class RouteDetailsPresenter: BasePresenter, AddRouteService {
    
    private weak var connector: SearchConnectorDelegate?
    private let routeService = RoutesService()
    var route: Route
    lazy var isSubscribed: Bool = {
        return isUserOwner ? false : route.passengers!.contains(User.shared.userID!)
    }()
    weak var view: RouteDetailView?
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
        super.init()
        routeService.addDelegate = self
        downloadUserProfileImage(userID: route.galUserPublicResponse!.userID)
    }
    
    private func downloadUserProfileImage(userID: Int) {
        let urlBuilder = URLBuilder()
        ImageProvider.getImage(urlBuilder.userPhotoURL(userID: userID)) { [weak self] (image) in
            if let image = image {
                DispatchQueue.main.async {
                    self?.view?.updateUserImage(image)
                }
            }
        }
    }
    
    func updateSuccess() {
        let value = isSubscribed ? -1 : 1
        let message = isSubscribed ? "Zrezygnowano" : "Zarezerwowano"
        route.numberOfOccupiedSeats = value + route.numberOfOccupiedSeats
        view?.success(with: message)
        isSubscribed = !isSubscribed
    }
    
    func serviceError(_ error: APIError) {
        view?.showError(with: error.description)
    }
    
    func reserveOrResign() {
        if isSubscribed {
            routeService.resign(userID: User.shared.userID!, routeID: route.routeId)
        } else {
            routeService.reserve(userID: User.shared.userID!, routeID: route.routeId)
        }
    }
    
    func showUserInfoView() {
        connector?.startUserInfoConnector(userInfo: route.galUserPublicResponse!.toGALUserInfo(), editModeEnabled: false, userID: route.galUserPublicResponse!.userID)
    }
    
    func showEditRouteInfo() {
        connector?.showEditRouteView(route: route)
    }
}
