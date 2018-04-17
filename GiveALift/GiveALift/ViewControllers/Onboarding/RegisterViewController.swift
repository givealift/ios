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
    private let cellsData: [RegisterCellType] = [NameCell(), SurnameCell(), EmailCell(), PasswordCell(), CompatibilePasswordCell(), PhoneNumberCell()]
    private let onboardingService = OnboardingService()
    
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
    }
    
    private func setObserverForPasswordCell() {
        let passwordCell = cellsData[3] as! PasswordCell
        let compatibileCell = cellsData[4] as! CompatibilePasswordCell
        compatibileCell.passwordCell = passwordCell
    }
    
    //MARK:- IBActions
    @IBAction func registerTapped(_ sender: Any) {
        let result = cellsData.filter{$0.isValid()}
//        if result.count == cellsData.count {
            onboardingService.register(email: cellsData[2].value!, password: cellsData[3].value!) { (result) in
                switch result {
                case .Error(error: let error):
                    print(error)
                case .Success(result: let result):
                    //MARK:-TODO cos z resultatem
                    print(result)
                }
            }
//        } else {
//            //MARK:- TODO bład
//            print("bład")
//        }
    }
}

//MARK:- UITableView
extension RegisterViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ValidatorTextFiledTVC = tableView.dequeueReusableCell(for: indexPath)
        cell.setup(cellType: cellsData[indexPath.row])
        return cell
    }
}


