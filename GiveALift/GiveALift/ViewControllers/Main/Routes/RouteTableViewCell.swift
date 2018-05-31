//
//  RouteTableViewCell.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 18.04.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

class RouteTableViewCell: UITableViewCell {

    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var rate: UILabel!
    @IBOutlet weak var from: UILabel!
    @IBOutlet weak var fromHour: UILabel!
    @IBOutlet weak var to: UILabel!
    @IBOutlet weak var toHour: UILabel!
    @IBOutlet weak var numberOfSeats: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var fromIndirectStackView: UIStackView!
    @IBOutlet weak var fromIndirectCity: UILabel!
    @IBOutlet weak var fromIndirectHour: UILabel!
    @IBOutlet weak var toIndirectStackView: UIStackView!
    @IBOutlet weak var toIndirectCity: UILabel!
    @IBOutlet weak var toIndirectHour: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(route: Route, fromCityID: Int, toCityID: Int) {
        userName.text = route.galUserPublicResponse!.firstName
        rate.text = "Ocena: \(String(describing: route.galUserPublicResponse!.rate)).0/5.0"
        fromHour.text = "\(route.from.date.extractHourString())"
        userProfileImage.image = #imageLiteral(resourceName: "logo-2")
        toHour.text = "\(route.to.date.extractHourString())"
        price.text = String(describing: route.price!) + " zł"
        numberOfSeats.text = "Miejsca: " +  String(describing: route.numberOfSeats - route.numberOfOccupiedSeats)
        checkIfStopIsMainRoute(route: route, fromCityID: fromCityID, toCityID: toCityID)
    }
    
    private func checkIfStopIsMainRoute(route: Route, fromCityID: Int, toCityID: Int) {
        from.text = route.from.city.cityID.name()
        if route.from.city.cityID != fromCityID {
            let stop = route.stops.first(where: {$0.city.cityID == fromCityID})
            fromIndirectStackView.isHidden = false
            fromIndirectCity.text = stop?.city.cityID.name()
            fromIndirectHour.text = stop?.date.extractHourString()
        }
        to.text = route.to.city.cityID.name()
        if route.to.city.cityID != toCityID {
            let stop = route.stops.first(where: {$0.city.cityID == toCityID})
            toIndirectStackView.isHidden = false
            toIndirectCity.text = stop?.city.cityID.name()
            toIndirectHour.text = stop?.date.extractHourString()
        }
    }
}
