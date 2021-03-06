//
//  UserInfoConnector.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 14.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

protocol UserInfoConnectorDelegate: class {
    func showUserInfoView(userData: GALUserInfo ,editModeEnabled: Bool, userID: Int)
    var searchConnector: SearchConnectorDelegate? { get set }
}

final class UserInfoConnector {
    
    private unowned let navigationController: UINavigationController
    weak var searchConnector: SearchConnectorDelegate?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}


extension UserInfoConnector: UserInfoConnectorDelegate {
    
    func showUserInfoView(userData: GALUserInfo ,editModeEnabled: Bool, userID: Int) {
        let presenter = UserInfoPresenter(connector: self,userData: userData ,editModeEnabled: editModeEnabled, userID: userID)
        let view = UserInfoViewController(presenter: presenter)
        presenter.view = view
        navigationController.present(view, animated: true, completion: nil)
    }
}
