//
//  Item.swift
//  Doughbuddy
//
//  Created by Joseph Miele on 1/31/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
