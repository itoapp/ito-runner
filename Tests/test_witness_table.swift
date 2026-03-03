import Foundation

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
    
    func decodeNil(forKey key: Key) throws -> Bool { return false }
    
    func decode<T>(_ type: T.Type, forKey key: Key) throws -> T where T : Decodable {
        print("Fallback decode for \(type)")
        if type == String.self { return "test" as! T }
        fatalError()
    }
    
    func decodeIfPresent(_ type: String.Type, forKey key: Key) throws -> String? {
        print("Concrete String decodeIfPresent called")
        return "concrete"
    }
    
    func decodeIfPresent<T>(_ type: T.Type, forKey key: Key) throws -> T? where T : Decodable {
        print("Generic decodeIfPresent called for \(type)")
        return "generic" as? T
    }
    
    func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type, forKey key: Key) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey { fatalError() }
    func nestedUnkeyedContainer(forKey key: Key) throws -> UnkeyedDecodingContainer { fatalError() }
    func superDecoder() throws -> Decoder { fatalError() }
    func superDecoder(forKey key: Key) throws -> Decoder { fatalError() }
}

struct TestStruct: Decodable {
    let s: String?
}

let t = try TestStruct(from: DecoderDummy())
print(t.s)
