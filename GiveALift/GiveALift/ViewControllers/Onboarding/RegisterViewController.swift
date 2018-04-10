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
    let cellsData: [RegisterCellType] = [NameCell(), SurnameCell(), EmailCell(), PasswordCell(), CompatibilePasswordCell(), PhoneNumberCell()]
    
    //MARK:- IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- VC life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    //MARK:- Private methods
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ValidatorTextFiledTVC.self)
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
