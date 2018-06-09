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
    
    @IBOutlet weak var lastDotImage: UIImageView!
    @IBOutlet weak var firstDotImage: UIImageView!
    @IBOutlet weak var descriptionStackView: UIStackView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var usersLabel: UILabel!
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
    @IBOutlet weak var usersStackView: UIStackView!
    @IBOutlet weak var userStackView: UIStackView!
    @IBOutlet weak var reserveOrResignButton: GALPinkButton!
    @IBOutlet weak var usersStackViewHeightConstaraint: NSLayoutConstraint!
    @IBOutlet weak var routesStackViewHeightConstraint: NSLayoutConstraint!
    
    //MARK:- VC's life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.isUserOwner ? setupForOwner() : nil
        presenter.isSubscribed ? setupResignButton() : setupReserveButton()
        if (presenter.route.numberOfSeats == presenter.route.numberOfOccupiedSeats) {
            reserveOrResignButton.isHidden = presenter.isSubscribed ? false : true
        }
        usersLabel.text = presenter.isUserOwner ? "Pasażerowie:" : "Kierowca:"
        setupViewData()
    }
    
    //MARK:- IBActions
    @IBAction func reserveOrResignTapped(_ sender: Any) {
        presenter.reserveOrResign()
    }
    
    //MARK:- Main
    private func setupForOwner() {
        reserveOrResignButton.isHidden = true
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
        setupDescriptionView()
        presenter.route.stops.forEach({addIndirect(with: $0)})
    }
    
    private func setupDescriptionView() {
        guard let description = presenter.route.description else { return }
        descriptionStackView.isHidden = false
        descriptionLabel.text = description
    }
    
    private func addIndirect(with location: Location) {
        let cityLabel = createIndirectLabel(with: location.city.cityID.name(), fontSize: 17.0, bold: true)
        let locationLabel = createIndirectLabel(with: "   " + location.placeOfMeeting, fontSize: 13.0, bold: false)
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
        stackView.spacing = 15.0
        return stackView
    }
    
    private func createIndirectLabel(with text: String, fontSize: CGFloat, bold: Bool) -> UILabel {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        label.text = text
        label.textColor = UIColor.GALBlue
        label.font = bold ? UIFont.boldSystemFont(ofSize: fontSize) : UIFont.systemFont(ofSize: fontSize)
        return label
    }
    
    func addUser(_ user: RouteUser, with tag: Int) {
        let image = user.image != nil ? user.image! : #imageLiteral(resourceName: "logo-2")
        let imageView = createImageView(with: image)
        let label = createUserLabel(user: user.user)
        let userStackView = createUserStackView(with: [imageView, label])
        userStackView.tag = tag
        addObserverToStackView(userStackView)
        setupConstraintForImage(imageView, stackView: userStackView)
        usersStackView.addArrangedSubview(userStackView)
        if usersStackViewHeightConstaraint.constant == 0 {
            usersStackViewHeightConstaraint.constant = 40
        } else {
            usersStackViewHeightConstaraint.constant += 50
        }
        UIView.animate(withDuration: 0.0) {
            self.view.layoutSubviews()
        }
    }
    
    private func setupConstraintForImage(_ image: UIImageView, stackView: UIStackView) {
        let height = NSLayoutConstraint(item: image, attribute: .height, relatedBy: .equal, toItem: stackView, attribute: .height, multiplier: 1, constant: 0)
        let aspectRatio = NSLayoutConstraint(item: image, attribute: .width, relatedBy: .equal, toItem: image, attribute: .height, multiplier: 1, constant: 0)
        stackView.addConstraints([height, aspectRatio])
    }
    
    private func createImageView(with image: UIImage) -> UIImageView {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 20.0
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1.5
        imageView.layer.borderColor = UIColor.GALBlue.cgColor
        return imageView
    }
    
    private func createUserStackView(with views: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 10.0
        return stackView
    }
    
    private func createUserLabel(user: GALUserInfo) -> UILabel {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        label.text = user.firstName!
        return label
    }
    
    private func addObserverToStackView(_ stackView: UIStackView) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(userInfoTapped))
        stackView.addGestureRecognizer(tap)
        stackView.isUserInteractionEnabled = true
    }
    
    @objc private func userInfoTapped(gesture: UITapGestureRecognizer) {
        guard let view = gesture.view else { return }
        presenter.showUserInfoView(index: view.tag)
    }
}
