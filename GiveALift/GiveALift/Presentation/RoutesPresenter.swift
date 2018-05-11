//
//  RoutesPresenter.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 18.04.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

final class RoutesPresenter: BasePresenter {
    
    let routes: [Route]
    
    init(routes: [Route]) {
        self.routes = routes
    }
}
