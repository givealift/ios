//
//  UserInfoService.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 31.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

protocol UserInfoServiceError: class{
    func serviceError(_ error: APIError)
}

protocol UserInfoUpdateService: UserInfoServiceError {
    func updateSuccess()
}

protocol GetUserInfoService: UserInfoServiceError {
    func userInfo(_ user: GALUserInfo, userID: Int)
}

final class UserInfoUpdate {
    
    fileprivate let requestBuilder: RequestBuilderType
    fileprivate let urlBuilder: URLBuilderType
    weak var updateDelegate: UserInfoUpdateService?
    weak var getDelegate: GetUserInfoService?
    
    // MARK: Initializers
    init(urlBuilder: URLBuilderType = URLBuilder(), requestBuilder: RequestBuilderType = RequestBuilder()) {
        self.urlBuilder = urlBuilder
        self.requestBuilder = requestBuilder
    }
    
    func getUserInfo(userID: Int) {
        requestBuilder.GETRequest(withURL: urlBuilder.userInfoURL(id: userID), authToken: User.shared.token) { [weak self] (result) in
            switch result {
            case .Success(result: let result):
                do  {
                    let decoder = JSONDecoder()
                    let galUserInfo = try decoder.decode(GALUserInfo.self, from: result)
                    DispatchQueue.main.async {
                        self?.getDelegate?.userInfo(galUserInfo, userID: userID)
                    }
                } catch {
                    print(error)
                }
            case .Error(error: let error):
                DispatchQueue.main.async {
                    self?.getDelegate?.serviceError(error)
                }
            }
        }
    }
    
    func updateUserInfo(_ userInfo: GALUserInfo, userID: Int) {
        requestBuilder.PUTRequest(withURL: urlBuilder.editUserInfoURL(userID: userID), withData: userInfo, authToken: User.shared.token!) { [weak self] (result) in
            switch result {
            case .Error(error: let error):
                DispatchQueue.main.async {
                    self?.updateDelegate?.serviceError(error)
                }
            case .Success(result: _):
                DispatchQueue.main.async {
                    self?.updateDelegate?.updateSuccess()
                }
            }
        }
    }
}
