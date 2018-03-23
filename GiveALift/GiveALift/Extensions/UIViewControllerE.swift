//
//  UIViewControllerE.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 23.03.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import UIKit

extension UIViewController {
    public static var identifier: String {
        return String(describing: self)
    }
}