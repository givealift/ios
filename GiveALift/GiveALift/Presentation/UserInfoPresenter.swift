//
//  UserInfoPresenter.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 14.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

final class UserInfoPresenter: BasePresenter {
 
    private weak var connector: UserInfoConnectorDelegate?
    let editModeEnabled: Bool
    let userData: GALUserInfo
    
    init(connector: UserInfoConnectorDelegate, userData: GALUserInfo, editModeEnabled: Bool) {
        self.connector = connector
        self.editModeEnabled = editModeEnabled
        self.userData = userData
    }
}
