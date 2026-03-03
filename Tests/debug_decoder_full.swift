import Foundation

struct AnyCodingKey: CodingKey {
    var stringValue: String
    var intValue: Int?
    init?(stringValue: String) { self.stringValue = stringValue; self.intValue = nil }
    init?(intValue: Int) { self.stringValue = ""; self.intValue = intValue }
}

class _PostcardDecoder: Decoder {
    var codingPath: [CodingKey] = []
    var userInfo: [CodingUserInfoKey : Any] = [:]
    
    let data: [UInt8]
    var currentIndex: Int = 0
    
    init(data: [UInt8]) {
        self.data = data
    }
    
    var isAtEnd: Bool {
        return currentIndex >= data.count
    }
    
    func consume(_ count: Int) throws -> ArraySlice<UInt8> {
        let endIndex = currentIndex + count
        guard endIndex <= data.count else {
            throw NSError(domain: "ItoError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Unexpected end of data."])
        }
        let slice = data[currentIndex..<endIndex]
        currentIndex = endIndex
        return slice
    }
    
    func decodeVarint() throws -> UInt64 {
        var value: UInt64 = 0
        var shift: UInt64 = 0
        
        while true {
            guard currentIndex < data.count else {
                throw NSError(domain: "ItoError", code: 2, userInfo: [NSLocalizedDescriptionKey: "Corrupted varint."])
            }
            let byte = data[currentIndex]
            currentIndex += 1
            
            value |= UInt64(byte & 0x7F) << shift
            if byte & 0x80 == 0 {
                break
            }
            shift += 7
            if shift >= 64 {
                throw NSError(domain: "ItoError", code: 3, userInfo: [NSLocalizedDescriptionKey: "Varint too large."])
            }
        }
        return value
    }
    
    func decodeZigZag(_ value: UInt64) -> Int64 {
        return Int64((value >> 1) ^ (~(value & 1) &+ 1))
    }
    
    func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key : CodingKey {
        return KeyedDecodingContainer(_PostcardKeyedDecodingContainer<Key>(decoder: self))
    }
    
    func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        let lengthInt = try decodeVarint()
        let count = Int(lengthInt)
        print("Creating unkeyed container with \(count) elements")
        return _PostcardUnkeyedDecodingContainer(decoder: self, count: count)
    }
    
    func singleValueContainer() throws -> SingleValueDecodingContainer {
        return _PostcardSingleValueDecoder(decoder: self)
    }
}

struct _PostcardKeyedDecodingContainer<Key: CodingKey>: KeyedDecodingContainerProtocol {
    var codingPath: [CodingKey] { decoder.codingPath }
    let decoder: _PostcardDecoder
    var allKeys: [Key] = []
    
    func contains(_ key: Key) -> Bool { return true }
    
    func decodeNil(forKey key: Key) throws -> Bool {
        if !decoder.isAtEnd && decoder.data[decoder.currentIndex] == 0 {
            decoder.currentIndex += 1
            return true
        }
        if !decoder.isAtEnd && decoder.data[decoder.currentIndex] == 1 {
            decoder.currentIndex += 1
        }
        return false
    }
    
    func decode<T>(_ type: T.Type, forKey key: Key) throws -> T where T : Decodable {
        print("Keyed decoding: \(type) for key \(key.stringValue)")
        return try T(from: decoder)
    }
    
    func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type, forKey key: Key) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey { fatalError() }
    func nestedUnkeyedContainer(forKey key: Key) throws -> UnkeyedDecodingContainer { fatalError() }
    func superDecoder() throws -> Decoder { fatalError() }
    func superDecoder(forKey key: Key) throws -> Decoder { fatalError() }
}

struct _PostcardUnkeyedDecodingContainer: UnkeyedDecodingContainer {
    var codingPath: [CodingKey] { decoder.codingPath }
    let decoder: _PostcardDecoder
    var count: Int?
    var currentIndex: Int = 0
    var isAtEnd: Bool { currentIndex >= (count ?? 0) }
    
    mutating func decodeNil() throws -> Bool { return false }
    mutating func decode<T>(_ type: T.Type) throws -> T where T : Decodable {
        print("Unkeyed decoding element \(currentIndex) of type \(type)")
        let value = try T(from: decoder)
        currentIndex += 1
        return value
    }
    mutating func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey { fatalError() }
    mutating func nestedUnkeyedContainer() throws -> UnkeyedDecodingContainer { fatalError() }
    mutating func superDecoder() throws -> Decoder { fatalError() }
}

struct _PostcardSingleValueDecoder: SingleValueDecodingContainer {
    var codingPath: [CodingKey] { decoder.codingPath }
    let decoder: _PostcardDecoder
    func decodeNil() -> Bool { fatalError() }
    func decode<T>(_ type: T.Type) throws -> T where T : Decodable {
        if type == Int32.self {
            print("Single value decoding Int32 at byte \(decoder.currentIndex)")
            let zigZag = try decoder.decodeVarint()
            let value = decoder.decodeZigZag(zigZag)
            return Int32(value) as! T
        }
        if type == String.self {
            print("Single value decoding String at byte \(decoder.currentIndex)")
            let length = try decoder.decodeVarint()
            print("String length decoded: \(length)")
            let bytes = try decoder.consume(Int(length))
            return String(bytes: bytes, encoding: .utf8) as! T
        }
        fatalError()
    }
}

struct ComplexStruct: Codable {
    let values: [Int32]
    let optionalString: String?
}

let data: [UInt8] = [4, 1, 0, 2, 200, 1, 0]
let d = _PostcardDecoder(data: data)
let result = try ComplexStruct(from: d)
print("done")
