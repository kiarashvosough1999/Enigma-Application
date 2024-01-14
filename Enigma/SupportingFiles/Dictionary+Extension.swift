//
//  Dictionary+Extension.swift
//  Enigma
//
//

import Foundation

extension Dictionary where Value: Equatable {
    func getKey(for value: Value) -> Key? {
        return first(where: { $1 == value })?.key
    }
}
