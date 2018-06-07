//
//  URLBuilderType.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 15.04.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

protocol URLBuilderType {
    func loginURL() -> URL
    func registerURL() -> URL
    func searchRouteURL(from: Int, to: Int, date: String) -> URL
    func addRouteURL() -> URL
    func userInfoURL(id: Int) -> URL
    func userPublicInfoURL(id: Int) -> URL
    func resere(routeID: Int) -> URL
    func editUserInfoURL(userID: Int) -> URL
    func userRoutes(userID: Int) -> URL
    func updateRoute(routeID: Int) -> URL
    func userPhotoURL(userID: Int) -> URL
    func resignURL(routeID: Int, userID: Int) -> URL
    func userReservedRoutes(userID: Int) -> URL
}
