//
//  SearchPresenter.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 17.04.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

final class SearchPresenter: BasePresenter {
    
    fileprivate let requestBuilder: RequestBuilderType
    fileprivate let urlBuilder: URLBuilderType
    fileprivate weak var connector: SearchConnectorDelegate?
    private var cellRouteData = [CellRouteData]()
    private var routes = [Route]()
    
    // MARK: Initializers
    
    init(urlBuilder: URLBuilderType = URLBuilder(), requestBuilder: RequestBuilderType = RequestBuilder(), connector: SearchConnectorDelegate) {
        self.urlBuilder = urlBuilder
        self.requestBuilder = requestBuilder
        self.connector = connector
    }
    
    func findRoutesFor(from: Int, to: Int, date: String) {
        requestBuilder.GETRequest(withURL: urlBuilder.searchRouteURL(from: from, to: to, date: date), authToken: User.shared.token) { [weak self] (result) in
            switch result {
            case .Error(error: let error):
                print(error)
            case .Success(result: let result):
                let decoder = JSONDecoder()
                do {
                    self?.routes = try decoder.decode([Route].self, from: result)
                    self?.getUsersInfo()
                } catch {
                    print(error)
                    fatalError("Faild to parse Route")
                }
            }
        }
    }
    
    func checkProgress() {
        if routes.count == cellRouteData.count {
            displayRoutesView()
        }
    }
    
    func getUsersInfo() {
        routes.forEach({getUserInfo(route: $0)})
    }
    
    func getUserInfo(route: Route) {
        requestBuilder.GETRequest(withURL: urlBuilder.userInfoURL(id: route.ownerId), authToken: User.shared.token) { [weak self] (result) in
            switch result {
            case .Error(error: let error):
                print(error)
            case .Success(result: let result):
                let decoder = JSONDecoder()
                do {
                    let userInfo = try decoder.decode(GALUserInfo.self, from: result)
                    DispatchQueue.main.async {
                        self?.cellRouteData.append(CellRouteData(userInfo: userInfo, routeInfo: route))
                    }
                } catch {
                    print(error)
                }
            }
        }
    }
    
    func displayRoutesView() {
        let userInfo = GALUserInfo(address: "", birthYear: 1960, email: "mwloczko@gmail.com", firstName: "Marcin", gender: "male", lastName: "Włoczko", phone: "12312415", rate: 5)
        let location = Location(city: City(cityID: 1, name: "wa", country: "Pols", province: "dsa", cityInfo: CityInfo(cityInfoID: 1, population: 1, citySize: 1)), placeOfMeeting: "Kabanos", date: "2018-05-14 17:00", localizationId: 1)
        let routeInfo = Route(routeId: 14, ownerId: 13, from: location, to: location, stops: [], numberOfSeats: 4, numberOfOccupiedSeats: 1, price: 20)
        let cellRoutesssData = CellRouteData(userInfo: userInfo, routeInfo: routeInfo)
        connector?.showRoutesView(routes: [cellRoutesssData])
    }
}
