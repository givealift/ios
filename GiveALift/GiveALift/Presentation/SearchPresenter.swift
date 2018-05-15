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
    private var from: Int!
    private var to: Int!
    private var cellRouteData = [CellRouteData]() {
        didSet {
            self.checkProgress()
        }
    }
    private var routes = [Route]()
    
    // MARK: Initializers
    
    init(urlBuilder: URLBuilderType = URLBuilder(), requestBuilder: RequestBuilderType = RequestBuilder(), connector: SearchConnectorDelegate) {
        self.urlBuilder = urlBuilder
        self.requestBuilder = requestBuilder
        self.connector = connector
    }
    
    func findRoutesFor(from: Int, to: Int, date: String) {
        self.from = from
        self.to = to
        requestBuilder.GETRequest(withURL: urlBuilder.searchRouteURL(from: from, to: to, date: date), authToken: nil) { [weak self] (result) in
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
        requestBuilder.GETRequest(withURL: urlBuilder.userPublicInfoURL(id: route.galUserPublicResponse!.ownerId), authToken: nil) { [weak self] (result) in
            switch result {
            case .Error(error: let error):
                print(error)
            case .Success(result: let result):
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
                do {
                    let userInfo = try decoder.decode(GALUserInfo.self, from: result)
                    DispatchQueue.main.async {
                        self?.cellRouteData.append(CellRouteData(userInfo: userInfo, routeInfo: route))
                    }
                } catch {
                    print(error)
                    fatalError("Decoding  failed")
                }
            }
        }
    }
    
    func displayRoutesView() {
        connector?.showRoutesView(routes: cellRouteData, fromCityID: from, toCityID: to)
    }
}
