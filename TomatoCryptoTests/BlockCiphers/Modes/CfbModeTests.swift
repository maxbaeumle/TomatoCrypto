import XCTest
@testable import TomatoCrypto

class CfbModeTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAes128() {
        let key = SimpleSecretKey(bytes: hexToBytes(hex: "2b7e151628aed2a6abf7158809cf4f3c"))
        let iv = IvParameter(bytes: hexToBytes(hex: "000102030405060708090a0b0c0d0e0f"))
        let plaintext = hexToBytes(hex: "6bc1bee22e409f96e93d7e117393172a" + "ae2d8a571e03ac9c9eb76fac45af8e51" +
                                        "30c81c46a35ce411e5fbc1191a0a52ef" + "f69f2445df4f9b17ad2b417be66c3710")
        let ciphertext = hexToBytes(hex: "3b3fd92eb72dad20333449f8e83cfb4a" + "c8a64537a0b3a93fcde3cdad9f1ce58b" +
                                         "26751f67a3cbb140b1808cf187a4f4df" + "c04b05357c5d1c0eeac4c66f9ff7f2e6")
        
        do {
            let aes = AesEngine()
            let mode = CfbMode()
            
            try mode.initialize(processMode: .encryption, engine: aes, key: key, parameters: [iv])
            let encrypted = try mode.process(input: plaintext)
            XCTAssertEqual(encrypted, ciphertext)
            
            try mode.initialize(processMode: .decryption, engine: aes, key: key, parameters: [iv])
            let decrypted = try mode.process(input: encrypted)
            XCTAssertEqual(decrypted, plaintext)
        } catch let error {
            XCTFail("\(error)")
        }
    }
}
