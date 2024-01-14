//
//  Enigma.swift
//  Enigma
//
//

import Foundation

enum Day: String, CaseIterable {
    case Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday, Unknown
}

struct Enigma {
    
    var crypto = [String: String]()
    
    init() {} //DO NOT MODIFY THE INITIALIZER
    
    // MARK: - TASK 1
    // Get the current day name in the form of the enumeration above. Example: "Tuesday" would be Day.Tuesday
    func getCurrentDay() -> Day {
        let day = Calendar.current.component(.day, from: Date()) - 1
        return Day.allCases[day]
    }
    
    // MARK: - TASK 2
    // Load the corresponding encryption keys for the current day from the "DAY_NAME.TXT" file. For example:
    // for Wednesday you would need to load wednesday.txt.
    // Once loaded parse the keys and fill the 'crypto' dictionary with alphabet letters as the keys and their
    // encrypted representations as the values.
    
    mutating func loadEncryptionKeys(for day: Day) {
        guard let url = Bundle.main.path(forResource: day.rawValue, ofType: "txt") else { return }
        do {
            let data = try String(contentsOfFile: url, encoding: .utf8)
            let myStrings = data.components(separatedBy: .newlines)
            
            crypto = myStrings.map {
                let componnents = $0.split(separator: ";").map { String($0) }
                return (componnents[0], componnents[1])
            }
            .reduce(into: [String: String]()) { partialResult, next in
                partialResult[next.0] = next.1
            }
        } catch {}
    }
    
    // MARK: - TASK 3
    // Fill out the encryption function below which accepts a String and returns an encrypted version of that
    // String. Each letter of the String should be encrypted using the encryption keys. Exmaple letter 'a' could be
    // encrypted as 'de4' depending on todays Day and the keys loaded.
    // Example if the method gets the word 'Hello' passed in it should return the encrypted version which could be
    // 'lzxpasbvcbvcgf3' depending on todays Day and the keys loaded.
    // Remember that letters need to be lowercase before encrypting.
    // Remember that the space character needs to be encrypted using the '-' key from crypto keys.
    // Please note that the characters that are allowed to be encrypted are only:
    // 'abcdefghijklmnopqrstuvwxyz0123456789 ' you should ignore any other characters that are passed in.
    // Example Devsk..iller should only encrypt 'devskiller' and ignore the .. in the middle.
    
    mutating func encrypt(message: String) -> String {
        let newMessage = message
            .lowercased()
            .filter { crypto.keys.contains(String($0)) }
            .map { String($0) }
            .compactMap { char in
                if char == " " {
                    return crypto["-"]
                } else {
                    return crypto[char]
                }
            }
            .joined()
        return newMessage
    }
    
    // MARK: - TASK 4
    // Fill out the decryption function below which accepts a String which is already encrypted using todays keys.
    // Every three character of the String is one letter in the decrypted String. Example: 'de4' could be the
    // letter 'a' depending on todays Day and the keys loaded.
    // Remember that the space character needs to be changed from '-' to ' '
    // Remember that letters need to be lowercase before decrypting.
    
    func decrypt(message: String) -> String {
        let reversed = Dictionary(uniqueKeysWithValues: crypto.map { ($1, $0) })
        let splitedString = message
            .lowercased()
            .subSequences(of: 3)
            .map { String($0) }
            .compactMap { reversed[$0] }
            .joined()
        
        return splitedString
    }
    
}

extension Collection {

    func unfoldSubSequences(limitedTo maxLength: Int) -> UnfoldSequence<SubSequence,Index> {
        sequence(state: startIndex) { start in
            guard start < self.endIndex else { return nil }
            let end = self.index(start, offsetBy: maxLength, limitedBy: self.endIndex) ?? self.endIndex
            defer { start = end }
            return self[start..<end]
        }
    }

    func subSequences(of n: Int) -> [SubSequence] {
        .init(unfoldSubSequences(limitedTo: n))
    }
}
