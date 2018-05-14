//
//  StringE.swift
//  GiveALift
//
//  Created by Marcin Włoczko on 14.05.2018.
//  Copyright © 2018 Marcin Włoczko. All rights reserved.
//

import Foundation

extension String {
    func date() -> Date {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return timeFormatter.date(from: self)!
    }
    
    func extractHourString() -> String {
        let endOfSentence = self.index(of: " ")!
        let firstSentence = self[endOfSentence...]
        return String(firstSentence)
    }
}
