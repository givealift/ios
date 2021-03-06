//
//  RequestBuilderType.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 13.04.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

protocol RequestBuilderType {
    func POSTRequest(withURL url: URL, withData body: [String: Any]?, authToken: String?, completion: @escaping APIResultBlock<Data>)
    func GETRequest(withURL url: URL, authToken: String?, completion: @escaping APIResultBlock<Data>)
    func POSTRequest<T: Encodable>(withURL url: URL, withData body: T, authToken: String?, completion: @escaping APIResultBlock<Data>)
    func PUTRequest<T: Encodable>(withURL url: URL, withData body: T, authToken: String?, completion: @escaping APIResultBlock<Data>)
    func DELETEReqeust(withURL url: URL, authToken: String?, completion: @escaping APIResultBlock<Data>)
    func PATCHREquest<T: Encodable>(withURL url: URL, withData body: T, authToken: String?, completion: @escaping APIResultBlock<Data>)
}
