//
//  APIManagerType.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 15.04.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

protocol APIManagerType: class {
    func login(email: String, password: String, completion: @escaping APIResultBlock<Data>)
}
