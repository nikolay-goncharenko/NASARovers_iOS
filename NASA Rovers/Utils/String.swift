//
//  String.swift
//  NASA Rovers
//
//  Created by Nikolay Goncharenko on 31.10.2023.
//

import Foundation

extension String {
    
    public var https: String {
        if self.contains("http:") {
            return self.replacingOccurrences(
                of: "http:", with: "https:"
            )
        } else {
            return self
        }
    }
}
