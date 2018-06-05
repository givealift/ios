//
//  RouteDetailsViewController.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 13.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

class RouteDetailsViewController: BaseViewController<RouteDetailsPresenter> {

    @IBOutlet weak var routesStackViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var routesStackView: UIStackView!
    @IBOutlet weak var numberOfSeats: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var fromHourLable: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var toHourLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var userStackView: UIStackView!
    @IBOutlet weak var reserveButton: GALPinkButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserIsOwner()
        setupViewData()
        addObserverToStackView()
    }
    
    @IBAction func reserveTapped(_ sender: Any) {
        //APIManager.shared.reserve(route: presenter.route.routeInfo, userID: 2)
    }
    
    private func checkIfUserIsOwner() {
        //MARK:- FAST
        if User.shared.userID == presenter.route.galUserPublicResponse!.userID {
         //if User.shared.userID == presenter.route.routeInfo.ownerId! {
            reserveButton.isHidden = true
            userStackView.isHidden = true
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edytuj", style: .plain, target: self, action: #selector(editTapped))
        }
    }
    
    @objc private func editTapped() {
        presenter.showEditRouteInfo()
    }
    
    private func setupViewData() {
        numberOfSeats.text = String(describing: presenter.route.numberOfSeats - presenter.route.numberOfOccupiedSeats)
        price.text = String(describing: presenter.route.price)
        dateLabel.text = presenter.route.from.date
        fromLabel.text = presenter.route.from.city.name
        toLabel.text = presenter.route.to.city.name
        fromHourLable.text = presenter.route.from.date.extractHourString()
        toHourLabel.text = presenter.route.to.date.extractHourString()
        userLabel.text = presenter.route.galUserPublicResponse!.firstName
        presenter.route.stops.forEach({addIndirectLabelsIfNeeded(location: $0)})
    }
    
    private func addIndirectLabelsIfNeeded(location: Location) {
        let cityLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        cityLabel.text = location.city.cityID.name()
        let hourLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        hourLabel.text = location.date.extractHourString()
        let stackView = UIStackView(arrangedSubviews: [cityLabel, hourLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        routesStackView.insertArrangedSubview(stackView, at: 1)
    }
    
    private func addObserverToStackView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(userInfoTapped))
        userStackView.addGestureRecognizer(tap)
        userStackView.isUserInteractionEnabled = true
    }
    
    @objc private func userInfoTapped() {
        presenter.showUserInfoView()
    }
}
