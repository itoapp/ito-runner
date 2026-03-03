import Foundation

struct DummyEncoder: Encoder {
    var codingPath: [CodingKey] = []
    var userInfo: [CodingUserInfoKey : Any] = [:]

    func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key : CodingKey {
        fatalError()
    }

    func unkeyedContainer() -> UnkeyedEncodingContainer {
        print("Array requested unkeyedContainer")
        return DummyUnkeyedContainer()
    }

    func singleValueContainer() -> SingleValueEncodingContainer {
        fatalError()
    }
}

struct DummyUnkeyedContainer: UnkeyedEncodingContainer {
    var codingPath: [CodingKey] = []
    var count: Int = 0

    mutating func encodeNil() throws { print("Encoded nil as element \(count)"); count += 1 }
    mutating func encode<T>(_ value: T) throws where T : Encodable { print("Encoded \(value) as element \(count)"); count += 1 }
    mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey { fatalError() }
    mutating func nestedUnkeyedContainer() -> UnkeyedEncodingContainer { fatalError() }
    mutating func superEncoder() -> Encoder { fatalError() }
}

let array: [Int32] = [1, 2, 3]
try! array.encode(to: DummyEncoder())
print("Done")
