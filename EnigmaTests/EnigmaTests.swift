//
//  EnigmaTests.swift
//  EnigmaTests
//
//

import XCTest
@testable import Enigma

class EnigmaTests: XCTestCase {

    var sut: Enigma!
//    var crypto = [String: String]()
    
    override func setUp() {
        sut = Enigma()
    }

    override func tearDown() {
        sut = nil
    }

    func test_getDay_notUnknown() {
        XCTAssertNotEqual(sut.getCurrentDay(), .Unknown, "Day identified incorrectly")
    }
    
    func test_loadEncryptionKeysForDay_monday() {
        sut.loadEncryptionKeys(for: .Monday)
        XCTAssertEqual(sut.crypto.count, 37, "Keys not loaded correctly")
        XCTAssertEqual(sut.crypto["a"], "de4", "Keys not loaded correctly")
    }
    
    func test_encryptMessage_devskiller() {
        sut.loadEncryptionKeys(for: .Monday)
        let encrypted = sut.encrypt(message: "Devskiller")
        XCTAssertEqual(encrypted, "uiopaswsxtr5mn2cvbbvcbvcpasuy4", "Encryption not working")
    }
    
    func test_decryptMessage_devskiller() {
        sut.loadEncryptionKeys(for: .Monday)
        let decrypted = sut.decrypt(message: "uiOpaswsxTr5mn2cvbbvcbvcpasuy4")
        XCTAssertEqual(decrypted, "devskiller", "Decryption not working")
    }


}
