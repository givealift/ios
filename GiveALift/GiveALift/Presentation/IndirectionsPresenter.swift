//
//  IndirectionsPresenter.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 12.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

final class IndirectionsPresenter: BasePresenter {
    
    private let routeLocation: AddRoute
    
    let indirectTextFieldPlaceHolder = "Wprowadź miasto pośrednie"
    let indirectLocationPlaceholder = "Wprowadź miejsce odbioru"
    
    init(routeLocation: AddRoute) {
        self.routeLocation = routeLocation
    }
}
