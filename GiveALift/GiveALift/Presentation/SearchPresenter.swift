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
    
    func findRoutesFor(start: Int, finish: Int, date: Date) {
//        requestBuilder.GETRequest(withURL: <#T##URL#>, authToken: <#T##String?#>, completion: <#T##(APIResult<Data>) -> ()#>)
    }
}
