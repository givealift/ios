//
//  RouteDetailsViewController.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 13.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

class RouteDetailsViewController: BaseViewController<RouteDetailsPresenter> {

    @IBOutlet weak var toLocationLabel: UILabel!
    @IBOutlet weak var fromLocationLabel: UILabel!
    @IBOutlet weak var routeImagesStackView: UIStackView!
    //@IBOutlet weak var routesStackView: UIStackView!
    @IBOutlet weak var fromHourLabel: UILabel!
    @IBOutlet weak var fromCityLabel: UILabel!
    @IBOutlet weak var toCityHour: UILabel!
    @IBOutlet weak var numberOfSeats: UILabel!
    @IBOutlet weak var toCityLabel: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var userStackView: UIStackView!
    @IBOutlet weak var reserveButton: GALPinkButton!
    @IBOutlet weak var routesStackViewHeightConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.isUserOwner ? setupForOwner() : setupOwnerInfo()
        setupViewData()
        addObserverToStackView()
    }
    
    @IBAction func reserveTapped(_ sender: Any) {
        //APIManager.shared.reserve(route: presenter.route.routeInfo, userID: 2)
    }
    
    private func setupForOwner() {
        reserveButton.isHidden = true
        userStackView.isHidden = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edytuj", style: .plain, target: self, action: #selector(editTapped))
    }
    
    @objc private func editTapped() {
        presenter.showEditRouteInfo()
    }
    
    private func setupOwnerInfo() {        
        userLabel.text = presenter.route.galUserPublicResponse!.firstName
    }
    
    private func setupViewData() {
        numberOfSeats.text = String(describing: presenter.route.numberOfSeats - presenter.route.numberOfOccupiedSeats)
        price.text = String(describing: presenter.route.price)
        dateLabel.text = presenter.route.from.date
        fromCityLabel.text = presenter.route.from.city.cityID.name()
        toCityLabel.text = presenter.route.to.city.cityID.name()
        fromHourLabel.text = presenter.route.from.date.extractHourString()
        toCityHour.text = presenter.route.to.date.extractHourString()
        fromLocationLabel.text = presenter.route.from.placeOfMeeting
        toLocationLabel.text = presenter.route.to.placeOfMeeting
        presenter.route.stops.forEach({addIndirect(with: $0)})
    }
    
    private func addIndirect(with location: Location) {
        let cityLabel = createIndirectLabel(with: location.city.cityID.name())
        let hourLabel = createIndirectLabel(with: location.date.extractHourString())
        let stackView = UIStackView(arrangedSubviews: [hourLabel, cityLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 15.0
        //routesStackView.insertArrangedSubview(stackView, at: 1)
        //addIndirectImages()
    }
    
    private func createIndirectLabel(with text: String) -> UILabel {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        label.text = text
        label.textColor = UIColor.GALBlue
        label.font = UIFont.boldSystemFont(ofSize: 17.0)
        return label
    }
    
    private func addIndirectImages() {
        let dotView = UIImageView(image: #imageLiteral(resourceName: "simpleDot"))
        dotView.contentMode = .scaleAspectFit
        let lineView = UIImageView(image: #imageLiteral(resourceName: "Line"))
        lineView.contentMode = .scaleAspectFit
        routeImagesStackView.insertArrangedSubview(dotView, at: 2)
        routeImagesStackView.insertArrangedSubview(lineView, at: 3)
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
