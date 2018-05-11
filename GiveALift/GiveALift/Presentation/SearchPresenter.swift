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
    fileprivate let connector: SearchConnectorDelegate
    
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
                    let routes = try decoder.decode([Route].self, from: result)
                    print(routes)
                    DispatchQueue.main.async {
                        self?.displayRoutesView(routes: routes)
                    }
                } catch {
                    print(error)
                }
            }
        }
    }
    
    func displayRoutesView(routes: [Route]) {
        connector.showRoutesView(routes: routes)
    }
}
