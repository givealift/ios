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
    
    init(connector: UserInfoConnectorDelegate) {
        self.connector = connector
    }
}
