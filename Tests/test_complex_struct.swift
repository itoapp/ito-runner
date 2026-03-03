import Foundation

struct AnyCodingKey: CodingKey {
    var stringValue: String
    var intValue: Int?
    init?(stringValue: String) { self.stringValue = stringValue; self.intValue = nil }
    init?(intValue: Int) { self.stringValue = ""; self.intValue = intValue }
}

struct ComplexStruct: Codable {
    let values: [Int32]
    let optionalString: String?
}

struct DecoderDummy: Decoder {
    var codingPath: [CodingKey] = []
    var userInfo: [CodingUserInfoKey : Any] = [:]
    
    func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key : CodingKey {
        return KeyedDecodingContainer(KeyedDummy<Key>())
    }
    func unkeyedContainer() throws -> UnkeyedDecodingContainer { fatalError() }
    func singleValueContainer() throws -> SingleValueDecodingContainer { fatalError() }
}

struct KeyedDummy<Key: CodingKey>: KeyedDecodingContainerProtocol {
    var codingPath: [CodingKey] = []
    var allKeys: [Key] = []
    
    func contains(_ key: Key) -> Bool { return true }
    
    func decodeNil(forKey key: Key) throws -> Bool { 
        print("Keyed decodeNil called for \(key.stringValue)")
        return false 
    }
    
    func decode<T>(_ type: T.Type, forKey key: Key) throws -> T where T : Decodable {
        print("Keyed decode for \(type) on \(key.stringValue)")
        if type == [Int32].self { return [Int32(-1), Int32(0), Int32(1), Int32(100)] as! T }
        fatalError()
    }
    
    func decodeIfPresent(_ type: String.Type, forKey key: Key) throws -> String? {
        print("Keyed concrete String decodeIfPresent called for \(key.stringValue)")
        return "concrete"
    }
    
    func decodeIfPresent<T>(_ type: T.Type, forKey key: Key) throws -> T? where T : Decodable {
        print("Keyed generic decodeIfPresent called for \(type) on \(key.stringValue)")
        return "generic" as? T
    }
    
    func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type, forKey key: Key) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey { fatalError() }
    func nestedUnkeyedContainer(forKey key: Key) throws -> UnkeyedDecodingContainer { fatalError() }
    func superDecoder() throws -> Decoder { fatalError() }
    func superDecoder(forKey key: Key) throws -> Decoder { fatalError() }
}

let t = try ComplexStruct(from: DecoderDummy())
print(t.values)
print(t.optionalString)
