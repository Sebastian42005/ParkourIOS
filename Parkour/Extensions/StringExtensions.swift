//
//  StringExtensions.swift
//  Parkour
//
//  Created by Sebastian Ederer on 06.11.22.
//

import Foundation

extension String {
    var capitalizedString: String {
        // 1
        let firstLetter = self.prefix(1).capitalized
        // 2
        let remainingLetters = self.dropFirst().lowercased()
        // 3
        return firstLetter + remainingLetters
    }
}
