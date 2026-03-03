    mutating func encodeIfPresent(_ value: Bool?, forKey key: Key) throws {
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
    }
    mutating func encodeIfPresent(_ value: String?, forKey key: Key) throws {
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
    }
    mutating func encodeIfPresent(_ value: Double?, forKey key: Key) throws {
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
    }
    mutating func encodeIfPresent(_ value: Float?, forKey key: Key) throws {
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
    }
    mutating func encodeIfPresent(_ value: Int?, forKey key: Key) throws {
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
    }
    mutating func encodeIfPresent(_ value: Int8?, forKey key: Key) throws {
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
    }
    mutating func encodeIfPresent(_ value: Int16?, forKey key: Key) throws {
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
    }
    mutating func encodeIfPresent(_ value: Int32?, forKey key: Key) throws {
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
    }
    mutating func encodeIfPresent(_ value: Int64?, forKey key: Key) throws {
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
    }
    mutating func encodeIfPresent(_ value: UInt?, forKey key: Key) throws {
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
    }
    mutating func encodeIfPresent(_ value: UInt8?, forKey key: Key) throws {
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
    }
    mutating func encodeIfPresent(_ value: UInt16?, forKey key: Key) throws {
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
    }
    mutating func encodeIfPresent(_ value: UInt32?, forKey key: Key) throws {
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
    }
    mutating func encodeIfPresent(_ value: UInt64?, forKey key: Key) throws {
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
    }
