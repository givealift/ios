//
//  RouteTableViewCell.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 18.04.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

class RouteTableViewCell: UITableViewCell {

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
        setupCellDesign()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func setupCell(route: Route, fromCityID: Int?, toCityID: Int?) {
        fromHour.text = "\(route.from.date.extractHourString())"
        toHour.text = "\(route.to.date.extractHourString())"
        price.text = String(describing: route.price!) + " zł"
        numberOfSeats.text = "Miejsca: " +  String(describing: route.numberOfSeats - route.numberOfOccupiedSeats)
        from.text = route.from.city.cityID.name()
        to.text = route.to.city.cityID.name()
        guard let fromCityID = fromCityID, let toCityID = toCityID else { return }
        checkIfStopIsMainRoute(route: route, fromCityID: fromCityID, toCityID: toCityID)
    }
    
    func setupCellDesign() {
        price.textColor = UIColor.GALBlue
        from.font = UIFont.boldSystemFont(ofSize: 17.0)
        to.font = UIFont.boldSystemFont(ofSize: 17.0)
        fromHour.font = UIFont.boldSystemFont(ofSize: 17.0)
        toHour.font = UIFont.boldSystemFont(ofSize: 17.0)
        price.font = UIFont.boldSystemFont(ofSize: 25.0)
        numberOfSeats.textColor = UIColor.GALBlue
        numberOfSeats.font = UIFont.boldSystemFont(ofSize: 16.0)
    }
    
    private func checkIfStopIsMainRoute(route: Route, fromCityID: Int, toCityID: Int) {
        if route.from.city.cityID != fromCityID {
            let stop = route.stops.first(where: {$0.city.cityID == fromCityID})
            fromIndirectStackView.isHidden = false
            fromIndirectCity.text = stop?.city.cityID.name()
            fromIndirectHour.text = stop?.date.extractHourString()
        }
        if route.to.city.cityID != toCityID {
            let stop = route.stops.first(where: {$0.city.cityID == toCityID})
            toIndirectStackView.isHidden = false
            toIndirectCity.text = stop?.city.cityID.name()
            toIndirectHour.text = stop?.date.extractHourString()
        }
    }
}
