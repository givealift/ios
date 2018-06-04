//
//  UserInfoPresenter.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 14.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

protocol UserInfoView: class {
    func showError(with message: String)
}

final class UserInfoPresenter: BasePresenter, UserInfoUpdateService {
    
    private weak var connector: UserInfoConnectorDelegate?
    private var userInfoService = UserInfoUpdate()
    let editModeEnabled: Bool
    let userData: GALUserInfo
    weak var view: UserInfoView?
    
    private lazy var dateFormatter: DateFormatter = {
        $0.dateFormat = "yyyy-MM-dd"
        return $0
    }(DateFormatter())
    
    var textFieldData: [RegisterCellType] = [NameCell(), SurnameCell(), EmailCell(), BirthdayCell(), PhoneNumberCell()]
    
    init(connector: UserInfoConnectorDelegate, userData: GALUserInfo, editModeEnabled: Bool) {
        self.connector = connector
        self.editModeEnabled = editModeEnabled
        self.userData = userData
        super.init()
        userInfoService.updateDelegate = self
    }
    
    func updateUserInfo() {
        let dateText = textFieldData[3] as! BirthdayCell
        let date = dateFormatter.date(from: dateText.value!)
        let user = GALUserInfo(address: nil, birthYear: date, email: textFieldData[2].value!, firstName: textFieldData[0].value!, lastName: textFieldData[1].value!, gender: nil, phone: textFieldData[4].value!, rate: nil, password: nil)
        userInfoService.updateUserInfo(user, userID: User.shared.userID!)
    }
    
    func updateSuccess() {
        //MARK:- TODO wyśietlić powodzenie operacji
        
    }
    
    func serviceError(error: APIError) {
        view?.showError(with: error.description)
    }
}
