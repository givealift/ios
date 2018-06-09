//
//  RouteOptionalDescription.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 12.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

final class RouteOptionalDescriptionPresenter: AddRoutePresenter {
    
    let textViewPlaceholder = "Dodatkowo możesz zamieścić jakieś ważne infromacje np. 'nie przeworzę psów', 'Proszę o punktualnośc', lecz nie jest to wymagane"
    
    func showHomeView(description: String?) {
        if let desc = description {
            updateModel(description: desc)
        } else {
            updateModel(description: route.description)
        }
        uploadToServer()
    }
    
    func showPreviousView(description: String?) {
        if let desc = description {
            updateModel(description: desc)
        } else {
            updateModel(description: route.description)
        }
        connector?.showPreviuosView()
    }
     
    private func updateModel(description: String?) {
        route.description = description
        route.ownerId = User.shared.userID!
    }
}
