import XCTest
@testable import TomatoCrypto

class CbcModeTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExample() {
    }
    
    func testAesCbc128() {
        let key = SecretKey(bytes: hexToBytes(hex: "2b7e151628aed2a6abf7158809cf4f3c"))
        let iv = IvParameter(bytes: hexToBytes(hex: "000102030405060708090a0b0c0d0e0f"))
        let plaintext = hexToBytes(hex: "6bc1bee22e409f96e93d7e117393172a" + "ae2d8a571e03ac9c9eb76fac45af8e51" +
                                        "30c81c46a35ce411e5fbc1191a0a52ef" + "f69f2445df4f9b17ad2b417be66c3710")
        let ciphertext = hexToBytes(hex: "7649abac8119b246cee98e9b12e9197d" + "5086cb9b507219ee95db113a917678b2" +
                                         "73bed6b8e3c1743b7116e69e22229516" + "3ff1caa1681fac09120eca307586e1a7")
        
        do {
            let aes = AesEngine()
            let mode = CbcMode()
            
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