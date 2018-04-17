//
//  SearchPresenter.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 17.04.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

final class SearchPresenter: BasePresenter {
    
    fileprivate let requestBuilder: RequestBuilderType
    fileprivate let urlBuilder: URLBuilderType
    
    // MARK: Initializers
    
    init(urlBuilder: URLBuilderType = URLBuilder(), requestBuilder: RequestBuilderType = RequestBuilder()) {
        self.urlBuilder = urlBuilder
        self.requestBuilder = requestBuilder
    }
    
    func findRoutesFor(from: Int, to: Int, date: Date) {
        requestBuilder.GETRequest(withURL: urlBuilder.searchRouteURL(from: from, to: to, date: date), authToken: User.shared.token) { (result) in
            switch result {
            case .Error(error: let error):
                print(error)
            case .Success(result: let result):
                let decoder = JSONDecoder()
                do {
                    let routes = try decoder.decode([Route].self, from: result)
                    self.displayRoutesView(routes: routes)
                } catch {
                    print(error)
                }
            }
        }
    }
    
    func displayRoutesView(routes: [Route]) {
        let presenter = RoutesPresenter(routes: routes)
        let routesVC = RoutesViewController(presenter: presenter)
    }
}
