import XCTest
@testable import TomatoCrypto

class EcbModeTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testAes128() {
        let key = SimpleSecretKeyParameter(key: hexToBytes(hex: "2b7e151628aed2a6abf7158809cf4f3c"))
        let plaintext = hexToBytes(hex: "6bc1bee22e409f96e93d7e117393172a" + "ae2d8a571e03ac9c9eb76fac45af8e51" +
                                        "30c81c46a35ce411e5fbc1191a0a52ef" + "f69f2445df4f9b17ad2b417be66c3710")
        let ciphertext = hexToBytes(hex: "3ad77bb40d7a3660a89ecaf32466ef97" + "f5d3d58503b9699de785895a96fdbaaf" +
                                         "43b1cd7f598ece23881b00e3ed030688" + "7b0c785e27e8ad3f8223207104725dd4")

        do {
            let cipher = BlockCipher(engine: EcbMode(engine: AesEngine()), padding: NoPadding())

            try cipher.initialize(isEncryption: true, parameters: [key])
            let encrypted = try cipher.finalize(input: plaintext)
            XCTAssertEqual(encrypted, ciphertext)

            try cipher.initialize(isEncryption: false, parameters: [key])
            let decrypted = try cipher.finalize(input: encrypted)
            XCTAssertEqual(decrypted, plaintext)
        } catch let error {
            XCTFail("\(error)")
        }
    }

    func testAes192() {
        let key = SimpleSecretKeyParameter(key: hexToBytes(hex: "8e73b0f7da0e6452c810f32b809079e562f8ead2522c6b7b"))
        let plaintext = hexToBytes(hex: "6bc1bee22e409f96e93d7e117393172a" + "ae2d8a571e03ac9c9eb76fac45af8e51" +
                                        "30c81c46a35ce411e5fbc1191a0a52ef" + "f69f2445df4f9b17ad2b417be66c3710")
        let ciphertext = hexToBytes(hex: "bd334f1d6e45f25ff712a214571fa5cc" + "974104846d0ad3ad7734ecb3ecee4eef" +
                                         "ef7afd2270e2e60adce0ba2face6444e" + "9a4b41ba738d6c72fb16691603c18e0e")

        do {
            let cipher = BlockCipher(engine: EcbMode(engine: AesEngine()), padding: NoPadding())

            try cipher.initialize(isEncryption: true, parameters: [key])
            let encrypted = try cipher.finalize(input: plaintext)
            XCTAssertEqual(encrypted, ciphertext)

            try cipher.initialize(isEncryption: false, parameters: [key])
            let decrypted = try cipher.finalize(input: encrypted)
            XCTAssertEqual(decrypted, plaintext)
        } catch let error {
            XCTFail("\(error)")
        }
    }

    func testAes256() {
        let key = SimpleSecretKeyParameter(key: hexToBytes(hex: "603deb1015ca71be2b73aef0857d7781" + "1f352c073b6108d72d9810a30914dff4"))
        let plaintext = hexToBytes(hex: "6bc1bee22e409f96e93d7e117393172a" + "ae2d8a571e03ac9c9eb76fac45af8e51" +
                                        "30c81c46a35ce411e5fbc1191a0a52ef" + "f69f2445df4f9b17ad2b417be66c3710")
        let ciphertext = hexToBytes(hex: "f3eed1bdb5d2a03c064b5a7e3db181f8" + "591ccb10d410ed26dc5ba74a31362870" +
                                         "b6ed21b99ca6f4f9f153e7b1beafed1d" + "23304b7a39f9f3ff067d8d8f9e24ecc7")

        do {
            let cipher = BlockCipher(engine: EcbMode(engine: AesEngine()), padding: NoPadding())

            try cipher.initialize(isEncryption: true, parameters: [key])
            let encrypted = try cipher.finalize(input: plaintext)
            XCTAssertEqual(encrypted, ciphertext)

            try cipher.initialize(isEncryption: false, parameters: [key])
            let decrypted = try cipher.finalize(input: encrypted)
            XCTAssertEqual(decrypted, plaintext)
        } catch let error {
            XCTFail("\(error)")
        }
    }

    func testDes() {
        let key = SimpleSecretKeyParameter(key: hexToBytes(hex: "123456789ABCDEF0"))
        let plaintext = hexToBytes(hex: "0000000000000000" + "0000000000000000" + "0000000000000000" + "0000000000000000")
        let ciphertext = hexToBytes(hex: "948A43F98A834F7E" + "948A43F98A834F7E" + "948A43F98A834F7E" + "948A43F98A834F7E")

        do {
            let cipher = BlockCipher(engine: EcbMode(engine: DesEngine()), padding: NoPadding())

            try cipher.initialize(isEncryption: true, parameters: [key])
            let encrypted = try cipher.finalize(input: plaintext)
            XCTAssertEqual(encrypted, ciphertext)

            try cipher.initialize(isEncryption: false, parameters: [key])
            let decrypted = try cipher.finalize(input: encrypted)
            XCTAssertEqual(decrypted, plaintext)
        } catch let error {
            XCTFail("\(error)")
        }
    }
}
