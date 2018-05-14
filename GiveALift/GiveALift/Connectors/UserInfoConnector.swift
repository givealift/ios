//
//  UserInfoConnector.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 14.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

protocol UserInfoConnectorDelegate: class {

}

final class UserInfoConnector {
    
    private unowned let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        showUserInfoView()
    }
    
    private func showUserInfoView() {
        
    }
}


extension UserInfoConnector: UserInfoConnectorDelegate {
    
}