import Foundation

struct DummyDecoder: Decoder {
    var codingPath: [CodingKey] = []
    var userInfo: [CodingUserInfoKey : Any] = [:]

    func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key : CodingKey {
        return KeyedDecodingContainer(DummyKeyedContainer<Key>())
    }
    func unkeyedContainer() throws -> UnkeyedDecodingContainer { fatalError() }
    func singleValueContainer() throws -> SingleValueDecodingContainer { fatalError() }
}

struct DummyKeyedContainer<Key: CodingKey>: KeyedDecodingContainerProtocol {
    var codingPath: [CodingKey] = []
    var allKeys: [Key] = []
    
    func contains(_ key: Key) -> Bool { return true }
    
    func decodeNil(forKey key: Key) throws -> Bool {
        print("Keyed decodeNil called for \(key.stringValue)")
        return false // assume some
    }
    
    func decode<T>(_ type: T.Type, forKey key: Key) throws -> T where T : Decodable {
        print("Keyed decode \(T.self) called for \(key.stringValue)")
        if T.self == String.self { return "hi" as! T }
        fatalError()
    }
    
    // We want to see if decodeIfPresent is called natively. 
    func decodeIfPresent<T>(_ type: T.Type, forKey key: Key) throws -> T? where T : Decodable {
        print("Keyed decodeIfPresent \(T.self) called for \(key.stringValue)")
        let isNil = try decodeNil(forKey: key)
        if isNil { return nil }
        return try decode(type, forKey: key)
    }

    func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type, forKey key: Key) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey { fatalError() }
    func nestedUnkeyedContainer(forKey key: Key) throws -> UnkeyedDecodingContainer { fatalError() }
    func superDecoder() throws -> Decoder { fatalError() }
    func superDecoder(forKey key: Key) throws -> Decoder { fatalError() }
}

struct TestStruct: Decodable { let a: String? }
let decoded = try! TestStruct(from: DummyDecoder())
print("Done: \(decoded.a)")
