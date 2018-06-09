//
//  UserInfoPresenter.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 14.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

protocol UserInfoView: class {
    func showError(with message: String)
    func updateSuccess()
    func updateUserImage(_ image: UIImage)
}

final class UserInfoPresenter: BasePresenter, UserInfoUpdateService {
    
    private weak var connector: UserInfoConnectorDelegate?
    private var userInfoService = UserInfoUpdate()
    let editModeEnabled: Bool
    let userID: Int
    var userData: GALUserInfo
    weak var view: UserInfoView?
    
    private lazy var dateFormatter: DateFormatter = {
        $0.dateFormat = "yyyy-MM-dd"
        return $0
    }(DateFormatter())
    
    var textFieldData: [RegisterCellType] = [NameCell(), SurnameCell(), EmailCell(), BirthdayCell(), PhoneNumberCell()]
    
    init(connector: UserInfoConnectorDelegate, userData: GALUserInfo, editModeEnabled: Bool, userID: Int) {
        self.connector = connector
        self.editModeEnabled = editModeEnabled
        self.userData = userData
        self.userID = userID
        super.init()
        userInfoService.updateDelegate = self
        downloadUserImage(userID: userID)
    }
    
    private func downloadUserImage(userID: Int) {
        let urlBuilder = URLBuilder()
        ImageProvider.getImage(urlBuilder.userPhotoURL(userID: userID)) { [weak self] (image) in
            if let image = image {
                DispatchQueue.main.async {
                    self?.view?.updateUserImage(image)
                }
            }
        }
    }
    
    func updateUserInfo() {
        let dateText = textFieldData[3] as! BirthdayCell
        let date = dateFormatter.date(from: dateText.value!)
        let user = GALUserInfo(address: nil, birthDate: date, email: textFieldData[2].value!, firstName: textFieldData[0].value!, lastName: textFieldData[1].value!, gender: nil, phone: textFieldData[4].value!, rate: nil, password: nil)
        userData = user
        let userid = User.shared.userID
        let token = User.shared.token
        User.shared.logOut()
        User.shared.logIn(user: GALUserLogin(userID: userid!, token: token!), userInfo: user)
        userInfoService.updateUserInfo(user, userID: User.shared.userID!)
    }
    
    func updateSuccess() {
        view?.updateSuccess()
    }
    
    func serviceError(_ error: APIError) {
        view?.showError(with: error.description)
    }
}
