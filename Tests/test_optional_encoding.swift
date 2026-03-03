import Foundation

struct DummyEncoder: Encoder {
    var codingPath: [CodingKey] = []
    var userInfo: [CodingUserInfoKey : Any] = [:]

    func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key : CodingKey {
        return KeyedEncodingContainer(DummyKeyedContainer<Key>())
    }
    func unkeyedContainer() -> UnkeyedEncodingContainer { fatalError() }
    func singleValueContainer() -> SingleValueEncodingContainer { fatalError() }
}

struct DummyKeyedContainer<Key: CodingKey>: KeyedEncodingContainerProtocol {
    var codingPath: [CodingKey] = []
    mutating func encodeNil(forKey key: Key) throws { print("Keyed encodeNil for \(key.stringValue)") }
    mutating func encode<T>(_ value: T, forKey key: Key) throws where T : Encodable { print("Keyed encode for \(key.stringValue): \(value)") }
    
    mutating func encodeIfPresent<T>(_ value: T?, forKey key: Key) throws where T : Encodable {
        print("Keyed encodeIfPresent for \(key.stringValue): \(String(describing: value))")
    }

    mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type, forKey key: Key) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey { fatalError() }
    mutating func nestedUnkeyedContainer(forKey key: Key) -> UnkeyedEncodingContainer { fatalError() }
    mutating func superEncoder() -> Encoder { fatalError() }
    mutating func superEncoder(forKey key: Key) -> Encoder { fatalError() }
}

struct TestStruct: Encodable { let a: String? }
try! TestStruct(a: nil).encode(to: DummyEncoder())
try! TestStruct(a: "hi").encode(to: DummyEncoder())
print("Done")
