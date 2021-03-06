//
//  RouteDetailsPresenter.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 13.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

protocol RouteDetailView: class {
    func addUser(_ user: RouteUser, with tag: Int)
    func showError(with message: String)
    func success(with message: String)
}

struct RouteUser {
    let userID: Int
    let user: GALUserInfo
    let image: UIImage?
}

final class RouteDetailsPresenter: BasePresenter, AddRouteService, GetUserInfoService {
    
    private weak var connector: SearchConnectorDelegate?
    private let routeService = RoutesService()
    private let userInfoService = UserInfoUpdate()
    var users = [RouteUser]()
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
        print(route)
        super.init()
        routeService.addDelegate = self
        userInfoService.getDelegate = self
        isUserOwner ? getUsersInfo(usersID: route.passengers!) : downloadUserProfileImage(user: route.galUserPublicResponse!.toGALUserInfo(), userID: route.galUserPublicResponse!.userID)
        
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
    
    func userInfo(_ user: GALUserInfo, userID: Int) {
        downloadUserProfileImage(user: user, userID: userID)
    }
    
    func reserveOrResign() {
        if isSubscribed {
            routeService.resign(userID: User.shared.userID!, routeID: route.routeId)
        } else {
            routeService.reserve(userID: User.shared.userID!, routeID: route.routeId)
        }
    }
    
    func showUserInfoView(index: Int) {
        connector?.startUserInfoConnector(userInfo: users[index].user, editModeEnabled: false, userID: users[index].userID)
    }
    
    func showEditRouteInfo() {
        connector?.showEditRouteView(route: route)
    }
    
    //MARK:- Privates
    
    private func downloadUserProfileImage(user: GALUserInfo, userID: Int) {
        let urlBuilder = URLBuilder()
        ImageProvider.getImage(urlBuilder.userPhotoURL(userID: userID)) { [weak self] (image) in
            guard let `self` = self else { return }
            if let image = image {
                DispatchQueue.main.async {
                    let user = RouteUser(userID: userID, user: user, image: image)
                    self.users.append(user)
                    self.view?.addUser(user, with: self.users.count - 1)
                }
            } else {
                DispatchQueue.main.async {
                    let user = RouteUser(userID: userID, user: user, image: image)
                    self.users.append(user)
                    self.view?.addUser(user, with: self.users.count - 1)
                }
            }
        }
    }
    
    private func getUsersInfo(usersID: [Int]) {
        usersID.forEach({ userInfoService.getUserInfo(userID: $0) })
    }
}
