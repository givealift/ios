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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(route: CellRouteData) {
        userName.text = route.userInfo.firstName
        rate.text = "Ocena: \(String(describing: route.userInfo.rate!)).0/5.0"
        from.text = "Warszawa"
        fromHour.text = "\(route.routeInfo.from.date.extractHourString())"
        userProfileImage.image = #imageLiteral(resourceName: "background1")
        to.text = "Kraków"
        toHour.text = "\(route.routeInfo.to.date.extractHourString())"
        price.text = String(describing: route.routeInfo.price) + " zł"
        numberOfSeats.text = "Miejsca: " +  String(describing: route.routeInfo.numberOfSeats - route.routeInfo.numberOfOccupiedSeats)
    }
}
