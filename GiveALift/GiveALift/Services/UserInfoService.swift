//
//  UserInfoService.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 31.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

protocol UserInfoServiceError: class{
    func serviceError(error: APIError)
}

protocol UserInfoUpdateService: UserInfoServiceError {
    func updateSuccess()
}

final class UserInfoUpdate {
    
    fileprivate let requestBuilder: RequestBuilderType
    fileprivate let urlBuilder: URLBuilderType
    weak var updateDelegate: UserInfoUpdateService?
    
    // MARK: Initializers
    init(urlBuilder: URLBuilderType = URLBuilder(), requestBuilder: RequestBuilderType = RequestBuilder()) {
        self.urlBuilder = urlBuilder
        self.requestBuilder = requestBuilder
    }
    
    func updateUserInfo(_ userInfo: GALUserInfo, userID: Int) {
        requestBuilder.PUTRequest(withURL: urlBuilder.editUserInfoURL(userID: userID), withData: userInfo, authToken: User.shared.token!) { [weak self] (result) in
            switch result {
            case .Error(error: let error):
                DispatchQueue.main.async {
                    self?.updateDelegate?.serviceError(error: error)
                }
            case .Success(result: _):
                DispatchQueue.main.async {
                    self?.updateDelegate?.updateSuccess()
                }
            }
        }
    }
}
