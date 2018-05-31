//
//  RouteOptionalDescription.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 12.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

final class RouteOptionalDescriptionPresenter: AddRoutePresenter {
    
    //MARK:- TODO Ominąć ten krok NIE ZAPOMNIES O USER ID
    
    let textViewPlaceholder = "Dodatkowo możesz zamieścić jakieś ważne infromacje np. 'nie przeworzę psów', 'Proszę o punktualnośc', lecz nie jest to wymagane"
    
    func showHomeView(description: String?) {
        updateModel(description: description)
        uploadToServer()
    }
    
    private func updateModel(description: String?) {
        route.description = description
        route.ownerId = User.shared.userID!
    }
}
