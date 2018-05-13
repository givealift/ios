//
//  RegisterViewController.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 26.03.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

final class RegisterViewController: UIViewController {

    //MARK:- Constants
    private let cellsData: [RegisterCellType] = [NameCell(), SurnameCell(), EmailCell(), PasswordCell(), CompatibilePasswordCell(), PhoneNumberCell(), GenderCell()]
    
    //MARK:- IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- VC life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        setupTableView()
        setObserverForPasswordCell()
    }
    
    //MARK:- Private methods
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ValidatorTextFiledTVC.self)
        tableView.register(SegControllerTableViewCell.self)
    }
    
    private func setObserverForPasswordCell() {
        let passwordCell = cellsData[3] as! PasswordCell
        let compatibileCell = cellsData[4] as! CompatibilePasswordCell
        compatibileCell.passwordCell = passwordCell
    }
    
    //MARK:- IBActions
    @IBAction func registerTapped(_ sender: Any) {
        let result = cellsData.filter{!$0.isValid()}
        if result.count == 1 {
            if let email = cellsData[2].value, let firstName = cellsData[0].value, let lastName = cellsData[1].value, let password = cellsData[4].value, let phoneNumber = cellsData[5].value, let gender = cellsData[6] as? GenderCell {
                let registeRequest = RegisterRequest(address: "", birthYear: 1960, email: email, firstName: firstName, gender: gender.gender.rawValue, lastName: lastName, password: password, phone: phoneNumber, rate: 0)
                APIManager.shared.register(request: registeRequest) { (result) in
                    switch result {
                    case .Error(error: let error):
                        print(error.localizedDescription)
                    case .Success(result: let result):
                        print(result)
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    }
}

//MARK:- UITableView
extension RegisterViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch cellsData[indexPath.row].type {
        case .textfield:
            let cell: ValidatorTextFiledTVC = tableView.dequeueReusableCell(for: indexPath)
            cell.setup(cellType: cellsData[indexPath.row])
            return cell
        case .segController:
            let cell: SegControllerTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setupCell(genderCell: cellsData[indexPath.row] as! GenderCell)
            return cell
        }
    }
}


