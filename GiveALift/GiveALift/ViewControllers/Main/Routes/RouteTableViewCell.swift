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
    
    func setupCell(route: CellRouteData, fromCityID: Int, toCityID: Int) {
        userName.text = route.userInfo.firstName
        rate.text = "Ocena: \(String(describing: route.userInfo.rate)).0/5.0"
        fromHour.text = "\(route.routeInfo.from.date.extractHourString())"
        userProfileImage.image = #imageLiteral(resourceName: "logo-2")
        toHour.text = "\(route.routeInfo.to.date.extractHourString())"
        price.text = String(describing: route.routeInfo.price!) + " zł"
        numberOfSeats.text = "Miejsca: " +  String(describing: route.routeInfo.numberOfSeats - route.routeInfo.numberOfOccupiedSeats)
        checkIfStopIsMainRoute(route: route, fromCityID: fromCityID, toCityID: toCityID)
    }
    
    private func checkIfStopIsMainRoute(route: CellRouteData, fromCityID: Int, toCityID: Int) {
        from.text = route.routeInfo.from.city.cityID.name()
        if route.routeInfo.from.city.cityID != fromCityID {
            let stop = route.routeInfo.stops.first(where: {$0.city.cityID == fromCityID})
            fromIndirectStackView.isHidden = false
            fromIndirectCity.text = stop?.city.cityID.name()
            fromIndirectHour.text = stop?.date.extractHourString()
        }
        to.text = route.routeInfo.to.city.cityID.name()
        if route.routeInfo.to.city.cityID != toCityID {
            let stop = route.routeInfo.stops.first(where: {$0.city.cityID == toCityID})
            toIndirectStackView.isHidden = false
            toIndirectCity.text = stop?.city.cityID.name()
            toIndirectHour.text = stop?.date.extractHourString()
        }
    }
}
