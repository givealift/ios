//
//  RouteDetailsViewController.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 13.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit
import SVProgressHUD

class RouteDetailsViewController: TextFieldViewController<RouteDetailsPresenter>, RouteDetailView {

    @IBOutlet weak var toLocationLabel: UILabel!
    @IBOutlet weak var fromLocationLabel: UILabel!
    @IBOutlet weak var routesStackView: UIStackView!
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
    @IBOutlet weak var reserveOrResignButton: GALPinkButton!
    @IBOutlet weak var routesStackViewHeightConstraint: NSLayoutConstraint!
    
    //MARK:- VC's life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.isUserOwner ? setupForOwner() : setupOwnerInfo()
        presenter.isSubscribed ? setupResignButton() : setupReserveButton()
        if (presenter.route.numberOfSeats == presenter.route.numberOfOccupiedSeats) {
            reserveOrResignButton.isHidden = presenter.isSubscribed ? false : true
        }
        setupViewData()
        addObserverToStackView()
        setupImageView()
    }
    
    //MARK:- IBActions
    @IBAction func reserveOrResignTapped(_ sender: Any) {
        presenter.reserveOrResign()
    }
    
    //MARK:- Main
    private func setupForOwner() {
        reserveOrResignButton.isHidden = true
        userStackView.isHidden = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edytuj", style: .plain, target: self, action: #selector(editTapped))
    }
    
    @objc private func editTapped() {
        presenter.showEditRouteInfo()
    }
    
    private func setupResignButton() {
        reserveOrResignButton.setTitle("Zrezygnuj", for: .normal)
    }
    
    private func setupReserveButton() {
        reserveOrResignButton.setTitle("Zarezerwuj", for: .normal)
    }
    
    
    func success(with message: String) {
        numberOfSeats.text = String(describing: presenter.route.numberOfSeats - presenter.route.numberOfOccupiedSeats)
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.setMinimumDismissTimeInterval(1.0)
        SVProgressHUD.showSuccess(withStatus: message)
        presenter.isSubscribed ? setupReserveButton() : setupResignButton()
    }
    
    private func setupOwnerInfo() {        
        userLabel.text = presenter.route.galUserPublicResponse!.firstName
    }
    
    private func setupViewData() {
        numberOfSeats.text = String(describing: presenter.route.numberOfSeats - presenter.route.numberOfOccupiedSeats)
        price.text = String(describing: presenter.route.price!) + " zł"
        dateLabel.text = presenter.route.from.date.extractDateString()
        fromCityLabel.text = presenter.route.from.city.cityID.name()
        toCityLabel.text = presenter.route.to.city.cityID.name()
        fromHourLabel.text = presenter.route.from.date.extractHourString()
        toCityHour.text = presenter.route.to.date.extractHourString()
        fromLocationLabel.text = "   " + presenter.route.from.placeOfMeeting
        toLocationLabel.text = "   " + presenter.route.to.placeOfMeeting
        presenter.route.stops.forEach({addIndirect(with: $0)})
    }
    
    private func addIndirect(with location: Location) {
        let cityLabel = createIndirectLabel(with: location.city.cityID.name(), fontSize: 17.0, bold: true)
        let locationLabel = createIndirectLabel(with: location.placeOfMeeting, fontSize: 13.0, bold: false)
        let hourLabel = createIndirectLabel(with: location.date.extractHourString(), fontSize: 14.0, bold: false)
        let dotView = UIImageView(image: #imageLiteral(resourceName: "simpleDot"))
        dotView.contentMode = .scaleAspectFit
        let hourStackView = createHourDotStackView(label: hourLabel, imageView: dotView)
        let locationStackView = createLocationStackView(city: cityLabel, location: locationLabel)
        let stopStackView = createStopStackView(with: [hourStackView, locationStackView])
        routesStackView.insertArrangedSubview(stopStackView, at: 1)
        routesStackViewHeightConstraint.constant += 40
        UIView.animate(withDuration: 0.2) {
            self.view.layoutSubviews()
        }
    }
    
    private func createStopStackView(with stackViews: [UIStackView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: stackViews)
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 15.0
        return stackView
    }
    
    private func createLocationStackView(city: UILabel, location: UILabel) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [city, location])
        stackView.axis = .vertical
        return stackView
    }
    
    private func createHourDotStackView(label: UILabel, imageView: UIImageView) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [label, imageView])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 10.0
        return stackView
    }
    
    private func createIndirectLabel(with text: String, fontSize: CGFloat, bold: Bool) -> UILabel {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        label.text = text
        label.textColor = UIColor.GALBlue
        label.font = bold ? UIFont.boldSystemFont(ofSize: fontSize) : UIFont.systemFont(ofSize: fontSize)
        return label
    }
    
    func updateUserImage(_ image: UIImage) {
        userImage.image = image
    }
    
    private func setupImageView() {
        userImage.layer.cornerRadius = userImage.frame.size.height / 2
        userImage.clipsToBounds = true
        userImage.layer.borderWidth = 1.5
        userImage.layer.borderColor = UIColor.GALBlue.cgColor
        
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
