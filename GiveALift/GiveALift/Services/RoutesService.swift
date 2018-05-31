//
//  RoutesService.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 31.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

protocol RouteServiceError: class {
    func serviceError(_ error: APIError)
}

protocol SearchRouteService: RouteServiceError {
    func foundRoutes(_ routes: [Route])
}

final class RoutesService {
    
    fileprivate let requestBuilder: RequestBuilderType
    fileprivate let urlBuilder: URLBuilderType
    weak var searchDelegate: SearchRouteService?
    
    // MARK: Initializers
    init(urlBuilder: URLBuilderType = URLBuilder(), requestBuilder: RequestBuilderType = RequestBuilder()) {
        self.urlBuilder = urlBuilder
        self.requestBuilder = requestBuilder
    }
    
    func findRoutes(from: Int, to: Int, date: String) {
        requestBuilder.GETRequest(withURL: urlBuilder.searchRouteURL(from: from, to: to, date: date), authToken: nil) { [weak self] (result) in
            switch result {
            case .Error(error: let error):
                DispatchQueue.main.async {
                    self?.searchDelegate?.serviceError(error)
                }
            case .Success(result: let result):
                self?.handleResponse(data: result)
            }
        }
    }
    
    private func handleResponse(data: Data) {
        let decoder = JSONDecoder()
        do {
            let routes = try decoder.decode([Route].self, from: data)
            DispatchQueue.main.async {
                self.searchDelegate?.foundRoutes(routes)
            }
        } catch {
            print(error)
            fatalError("failed to parse get routes")
        }
    }
}
