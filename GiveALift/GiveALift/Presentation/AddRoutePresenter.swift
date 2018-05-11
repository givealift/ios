//
//  AddRoutePresenter.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 11.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

final class AddRoutePresenter: BasePresenter {
    
    private weak var connector: AddRouteConnectorDelegate?
    
    let fromTextFieldPlaceholder = "Wprowadź miasto startowe"
    let toTextFieldPlaceholder = "Wproawdź miasto docelowe"
    let indirectTextFieldPlaceHolder = "Wprowadź miasto pośrednie"
    
    init(connector: AddRouteConnectorDelegate) {
        self.connector = connector
    }
    
    func showRouteTimeView() {
        connector?.showRouteTimeView()
    }
}
