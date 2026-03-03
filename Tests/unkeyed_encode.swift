    mutating func encodeIfPresent(_ value: Bool?) throws {
        let key = AnyCodingKey(intValue: count)!
        encoder.codingPath.append(key)
        defer { encoder.codingPath.removeLast() }
        if let value = value {
            var container = encoder.singleValueContainer()
            try container.encode(true)
            try value.encode(to: encoder)
        } else {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
        }
        count += 1
    }
    mutating func encodeIfPresent(_ value: String?) throws {
        let key = AnyCodingKey(intValue: count)!
        encoder.codingPath.append(key)
        defer { encoder.codingPath.removeLast() }
        if let value = value {
            var container = encoder.singleValueContainer()
            try container.encode(true)
            try value.encode(to: encoder)
        } else {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
        }
        count += 1
    }
    mutating func encodeIfPresent(_ value: Double?) throws {
        let key = AnyCodingKey(intValue: count)!
        encoder.codingPath.append(key)
        defer { encoder.codingPath.removeLast() }
        if let value = value {
            var container = encoder.singleValueContainer()
            try container.encode(true)
            try value.encode(to: encoder)
        } else {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
        }
        count += 1
    }
    mutating func encodeIfPresent(_ value: Float?) throws {
        let key = AnyCodingKey(intValue: count)!
        encoder.codingPath.append(key)
        defer { encoder.codingPath.removeLast() }
        if let value = value {
            var container = encoder.singleValueContainer()
            try container.encode(true)
            try value.encode(to: encoder)
        } else {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
        }
        count += 1
    }
    mutating func encodeIfPresent(_ value: Int?) throws {
        let key = AnyCodingKey(intValue: count)!
        encoder.codingPath.append(key)
        defer { encoder.codingPath.removeLast() }
        if let value = value {
            var container = encoder.singleValueContainer()
            try container.encode(true)
            try value.encode(to: encoder)
        } else {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
        }
        count += 1
    }
    mutating func encodeIfPresent(_ value: Int8?) throws {
        let key = AnyCodingKey(intValue: count)!
        encoder.codingPath.append(key)
        defer { encoder.codingPath.removeLast() }
        if let value = value {
            var container = encoder.singleValueContainer()
            try container.encode(true)
            try value.encode(to: encoder)
        } else {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
        }
        count += 1
    }
    mutating func encodeIfPresent(_ value: Int16?) throws {
        let key = AnyCodingKey(intValue: count)!
        encoder.codingPath.append(key)
        defer { encoder.codingPath.removeLast() }
        if let value = value {
            var container = encoder.singleValueContainer()
            try container.encode(true)
            try value.encode(to: encoder)
        } else {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
        }
        count += 1
    }
    mutating func encodeIfPresent(_ value: Int32?) throws {
        let key = AnyCodingKey(intValue: count)!
        encoder.codingPath.append(key)
        defer { encoder.codingPath.removeLast() }
        if let value = value {
            var container = encoder.singleValueContainer()
            try container.encode(true)
            try value.encode(to: encoder)
        } else {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
        }
        count += 1
    }
    mutating func encodeIfPresent(_ value: Int64?) throws {
        let key = AnyCodingKey(intValue: count)!
        encoder.codingPath.append(key)
        defer { encoder.codingPath.removeLast() }
        if let value = value {
            var container = encoder.singleValueContainer()
            try container.encode(true)
            try value.encode(to: encoder)
        } else {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
        }
        count += 1
    }
    mutating func encodeIfPresent(_ value: UInt?) throws {
        let key = AnyCodingKey(intValue: count)!
        encoder.codingPath.append(key)
        defer { encoder.codingPath.removeLast() }
        if let value = value {
            var container = encoder.singleValueContainer()
            try container.encode(true)
            try value.encode(to: encoder)
        } else {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
        }
        count += 1
    }
    mutating func encodeIfPresent(_ value: UInt8?) throws {
        let key = AnyCodingKey(intValue: count)!
        encoder.codingPath.append(key)
        defer { encoder.codingPath.removeLast() }
        if let value = value {
            var container = encoder.singleValueContainer()
            try container.encode(true)
            try value.encode(to: encoder)
        } else {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
        }
        count += 1
    }
    mutating func encodeIfPresent(_ value: UInt16?) throws {
        let key = AnyCodingKey(intValue: count)!
        encoder.codingPath.append(key)
        defer { encoder.codingPath.removeLast() }
        if let value = value {
            var container = encoder.singleValueContainer()
            try container.encode(true)
            try value.encode(to: encoder)
        } else {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
        }
        count += 1
    }
    mutating func encodeIfPresent(_ value: UInt32?) throws {
        let key = AnyCodingKey(intValue: count)!
        encoder.codingPath.append(key)
        defer { encoder.codingPath.removeLast() }
        if let value = value {
            var container = encoder.singleValueContainer()
            try container.encode(true)
            try value.encode(to: encoder)
        } else {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
        }
        count += 1
    }
    mutating func encodeIfPresent(_ value: UInt64?) throws {
        let key = AnyCodingKey(intValue: count)!
        encoder.codingPath.append(key)
        defer { encoder.codingPath.removeLast() }
        if let value = value {
            var container = encoder.singleValueContainer()
            try container.encode(true)
            try value.encode(to: encoder)
        } else {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
        }
        count += 1
    }
