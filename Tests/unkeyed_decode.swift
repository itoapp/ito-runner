    mutating func decodeIfPresent(_ type: Bool.Type) throws -> Bool? {
        let isNil = try decodeNil()
        if isNil {
            return nil
        }
        return try Bool(from: decoder)
    }
    mutating func decodeIfPresent(_ type: String.Type) throws -> String? {
        let isNil = try decodeNil()
        if isNil {
            return nil
        }
        return try String(from: decoder)
    }
    mutating func decodeIfPresent(_ type: Double.Type) throws -> Double? {
        let isNil = try decodeNil()
        if isNil {
            return nil
        }
        return try Double(from: decoder)
    }
    mutating func decodeIfPresent(_ type: Float.Type) throws -> Float? {
        let isNil = try decodeNil()
        if isNil {
            return nil
        }
        return try Float(from: decoder)
    }
    mutating func decodeIfPresent(_ type: Int.Type) throws -> Int? {
        let isNil = try decodeNil()
        if isNil {
            return nil
        }
        return try Int(from: decoder)
    }
    mutating func decodeIfPresent(_ type: Int8.Type) throws -> Int8? {
        let isNil = try decodeNil()
        if isNil {
            return nil
        }
        return try Int8(from: decoder)
    }
    mutating func decodeIfPresent(_ type: Int16.Type) throws -> Int16? {
        let isNil = try decodeNil()
        if isNil {
            return nil
        }
        return try Int16(from: decoder)
    }
    mutating func decodeIfPresent(_ type: Int32.Type) throws -> Int32? {
        let isNil = try decodeNil()
        if isNil {
            return nil
        }
        return try Int32(from: decoder)
    }
    mutating func decodeIfPresent(_ type: Int64.Type) throws -> Int64? {
        let isNil = try decodeNil()
        if isNil {
            return nil
        }
        return try Int64(from: decoder)
    }
    mutating func decodeIfPresent(_ type: UInt.Type) throws -> UInt? {
        let isNil = try decodeNil()
        if isNil {
            return nil
        }
        return try UInt(from: decoder)
    }
    mutating func decodeIfPresent(_ type: UInt8.Type) throws -> UInt8? {
        let isNil = try decodeNil()
        if isNil {
            return nil
        }
        return try UInt8(from: decoder)
    }
    mutating func decodeIfPresent(_ type: UInt16.Type) throws -> UInt16? {
        let isNil = try decodeNil()
        if isNil {
            return nil
        }
        return try UInt16(from: decoder)
    }
    mutating func decodeIfPresent(_ type: UInt32.Type) throws -> UInt32? {
        let isNil = try decodeNil()
        if isNil {
            return nil
        }
        return try UInt32(from: decoder)
    }
    mutating func decodeIfPresent(_ type: UInt64.Type) throws -> UInt64? {
        let isNil = try decodeNil()
        if isNil {
            return nil
        }
        return try UInt64(from: decoder)
    }
