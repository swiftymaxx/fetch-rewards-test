//
//  Sequence+Ext.swift
//  Fetch Rewards Exercise
//
//  Created by Maximo Liriano on 10/20/20.
//

import Foundation

extension Sequence where Iterator.Element == String {
    
    // This custom sort extension allows me to sort the elements by numeric values
    // when other string characters are involved. It will sort based on the whole number
    // and not just the first digit.
    var customSortByNumber: [String] {
        return self.sorted {
            return $0.compare($1, options: .numeric) == .orderedAscending
        }
    }
}
