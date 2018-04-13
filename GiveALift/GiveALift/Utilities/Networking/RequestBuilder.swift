//
//  RequestBuilder.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 13.04.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

final class RequestBuilder: RequestBuilderType {
    func POSTRequest(withURL url: URL, withData body: [String : Any]?, authToken: String?, completion: @escaping APIResultBlock<Data>) {
        let (request, session) = configuration(forURL: url, parameters: body, httpMethod: "POST", authToken: authToken)
        startDataTask(for: session, with: request) { (result) in
            completion(result)
        }
    }
    
    private func startDataTask(for session: URLSession, with request: URLRequest, completion: @escaping APIResultBlock<Data>) {
        session.dataTask(with: request) { (data, response, error) in
            if let _ = error {
                completion(APIResult.Error(error: APIError.unexpectedError))
                return
            }
            guard let data = data, let httpResponse = response as? HTTPURLResponse else {
                completion(APIResult.Error(error: APIError.noData))
                return
            }
            guard httpResponse.statusCode == 200 || httpResponse.statusCode == 201 else {
                completion(APIResult.Error(error: APIError.wrongHTTPCode(code: httpResponse.statusCode)))
                return
            }
            completion(APIResult.Success(result: data))
            }.resume()
    }
    
    private func configuration(forURL url: URL, parameters: Dictionary<String, Any>? = nil, httpMethod: String, authToken: String?) -> (request: URLRequest, session: URLSession) {
        
        let sessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfiguration)
        
        var request = URLRequest(url: url)
        
        
        if let authToken = authToken {
            let header = "Authorization"
            request.addValue(authToken, forHTTPHeaderField: header)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = httpMethod
        if let parameters = parameters {
            let paramData = try! JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            request.httpBody = paramData
        }
        
        return (request, session)
    }
}