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
}
