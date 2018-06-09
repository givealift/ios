//
//  RoutesViewController.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 18.04.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

class RoutesViewController: BaseViewController<RoutesPresenter>, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RouteTableViewCell.self)
        tableView.register(LabelTableViewCell.self)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.routes.count == 0 ? 1 : presenter.routes.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(20.0)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if presenter.routes.count == 0 {
            let cell: LabelTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setup(with: "Nie znaleźliśmy żadnych przejazdów")
            cell.layer.cornerRadius = 20.0
            return cell
        } else {
            let cell: RouteTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setupCell(route: presenter.routes[indexPath.section], fromCityID: presenter.fromCityID, toCityID: presenter.toCityID)
            cell.layer.cornerRadius = 20.0
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if presenter.routes.count != 0 {
            presenter.showRouteDetailsView(route: presenter.routes[indexPath.section])
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //MARK:- TODO sprawdzenie czy stop jest startem albo docelowym
        if presenter.routes.count == 0 {
            return 70
        }
        if checkIfIsIndirect(route: presenter.routes[indexPath.section], fromCityID: presenter.fromCityID, toCityID: presenter.toCityID) {
            return 150
        } else {
            return 190
        }
    }
    
    private func checkIfIsIndirect(route: Route, fromCityID: Int?, toCityID: Int?) -> Bool {
        if route.from.city.cityID != fromCityID {
            return true
        }
        if route.to.city.cityID != toCityID {
            return true
        }
        return false
    }

}
