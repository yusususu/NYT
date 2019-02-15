//
//  Formatter.swift
//  NYT
//
//  Created by Yusuf Yıldız on 15.02.2019.
//  Copyright © 2019 Yusuf Yıldız. All rights reserved.
//

import Foundation

struct Formatters {
    //TODO: Move objective c and swift formatters to one place
    static let dayMonthYearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    static let iso8601Formatter = ISO8601DateFormatter()
}

