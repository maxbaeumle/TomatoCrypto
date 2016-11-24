import Foundation

public class CbcMode: BlockCipherMode {
    private var processMode: BlockCipher.ProcessMode!
    private var engine: BlockCipherEngine!
    private var iv: [Byte]!
    
    public func initialize(processMode: BlockCipher.ProcessMode,
                           engine: BlockCipherEngine,
                           key: SecretKey,
                           parameters: [BlockCipherParameter]) throws {
        self.processMode = processMode
        
        var iv: IvParameter!
        for param in parameters {
            if param is IvParameter {
                iv = param as! IvParameter
            }
        }
        guard iv != nil else {
            throw CryptoError.missingParameter("IV is missing")
        }
        self.iv = iv.bytes
        guard self.iv.count == engine.blockSize else {
            throw CryptoError.invalidParameter("IV must be \(engine.blockSize)-byte")
        }
        
        try engine.initialize(processMode: processMode, key: key)
        self.engine = engine
    }
    
    public func process(input: [Byte]) throws -> [Byte] {
        guard let engine = self.engine, let processMode = self.processMode else {
            throw CryptoError.cipherNotInitialize("\(#file) is not initialized")
        }
        guard input.count % engine.blockSize == 0 else {
            throw CryptoError.illegalBlockSize("Input length must be multiple of \(engine.blockSize) bytes")
        }
        
        switch processMode {
        case .encryption:
            return try self.encrypt(input: input, iv: self.iv)
        case .decryption:
            return try self.decrypt(input: input, iv: self.iv)
        }
    }
    
    private func encrypt(input: [Byte], iv: [Byte]) throws -> [Byte] {
        let blockSize = self.engine.blockSize
        var lastEncrypted = iv
        var output: [Byte] = []
        
        for i in 0..<(input.count / blockSize) {
            let from = blockSize * i
            let to = from + blockSize
            let block = [Byte](input[from..<to])
            lastEncrypted = try self.engine.processBlock(input: xorBytes(bytes1: block, bytes2: lastEncrypted))
            output += lastEncrypted
        }
        
        return output
    }
    
    private func decrypt(input: [Byte], iv: [Byte]) throws -> [Byte] {
        let blockSize = self.engine.blockSize
        var lastBlock = iv
        var output: [Byte] = []
        
        for i in 0..<(input.count / blockSize) {
            let from = blockSize * i
            let to = from + blockSize
            let block = [Byte](input[from..<to])
            output += xorBytes(bytes1: try self.engine.processBlock(input: block), bytes2: lastBlock)
            lastBlock = block
        }
        
        return output
    }
}