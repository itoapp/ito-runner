import Foundation

struct MyStruct: Encodable { let v: String? }
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
    mutating func encodeNil(forKey key: Key) throws { print("encodeNil \(key.stringValue)") }
    mutating func encode<T>(_ value: T, forKey key: Key) throws where T : Encodable { print("encode \(key.stringValue): \(value)") }
    mutating func encodeIfPresent(_ value: String?, forKey key: Key) throws { print("encodeIfPresent String \(key.stringValue): \(String(describing: value))") }
    mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type, forKey key: Key) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey { fatalError() }
    mutating func nestedUnkeyedContainer(forKey key: Key) -> UnkeyedEncodingContainer { fatalError() }
    mutating func superEncoder() -> Encoder { fatalError() }
    mutating func superEncoder(forKey key: Key) -> Encoder { fatalError() }
}

try! MyStruct(v: nil).encode(to: DummyEncoder())
try! MyStruct(v: "hi").encode(to: DummyEncoder())
