    func decodeIfPresent(_ type: Bool.Type, forKey key: Key) throws -> Bool? {
        decoder.codingPath.append(key)
        defer { decoder.codingPath.removeLast() }
        
        let isNil = try decodeNil(forKey: key)
        if isNil {
            return nil
        }
        return try Bool(from: decoder)
    }
    func decodeIfPresent(_ type: String.Type, forKey key: Key) throws -> String? {
        decoder.codingPath.append(key)
        defer { decoder.codingPath.removeLast() }
        
        let isNil = try decodeNil(forKey: key)
        if isNil {
            return nil
        }
        return try String(from: decoder)
    }
    func decodeIfPresent(_ type: Double.Type, forKey key: Key) throws -> Double? {
        decoder.codingPath.append(key)
        defer { decoder.codingPath.removeLast() }
        
        let isNil = try decodeNil(forKey: key)
        if isNil {
            return nil
        }
        return try Double(from: decoder)
    }
    func decodeIfPresent(_ type: Float.Type, forKey key: Key) throws -> Float? {
        decoder.codingPath.append(key)
        defer { decoder.codingPath.removeLast() }
        
        let isNil = try decodeNil(forKey: key)
        if isNil {
            return nil
        }
        return try Float(from: decoder)
    }
    func decodeIfPresent(_ type: Int.Type, forKey key: Key) throws -> Int? {
        decoder.codingPath.append(key)
        defer { decoder.codingPath.removeLast() }
        
        let isNil = try decodeNil(forKey: key)
        if isNil {
            return nil
        }
        return try Int(from: decoder)
    }
    func decodeIfPresent(_ type: Int8.Type, forKey key: Key) throws -> Int8? {
        decoder.codingPath.append(key)
        defer { decoder.codingPath.removeLast() }
        
        let isNil = try decodeNil(forKey: key)
        if isNil {
            return nil
        }
        return try Int8(from: decoder)
    }
    func decodeIfPresent(_ type: Int16.Type, forKey key: Key) throws -> Int16? {
        decoder.codingPath.append(key)
        defer { decoder.codingPath.removeLast() }
        
        let isNil = try decodeNil(forKey: key)
        if isNil {
            return nil
        }
        return try Int16(from: decoder)
    }
    func decodeIfPresent(_ type: Int32.Type, forKey key: Key) throws -> Int32? {
        decoder.codingPath.append(key)
        defer { decoder.codingPath.removeLast() }
        
        let isNil = try decodeNil(forKey: key)
        if isNil {
            return nil
        }
        return try Int32(from: decoder)
    }
    func decodeIfPresent(_ type: Int64.Type, forKey key: Key) throws -> Int64? {
        decoder.codingPath.append(key)
        defer { decoder.codingPath.removeLast() }
        
        let isNil = try decodeNil(forKey: key)
        if isNil {
            return nil
        }
        return try Int64(from: decoder)
    }
    func decodeIfPresent(_ type: UInt.Type, forKey key: Key) throws -> UInt? {
        decoder.codingPath.append(key)
        defer { decoder.codingPath.removeLast() }
        
        let isNil = try decodeNil(forKey: key)
        if isNil {
            return nil
        }
        return try UInt(from: decoder)
    }
    func decodeIfPresent(_ type: UInt8.Type, forKey key: Key) throws -> UInt8? {
        decoder.codingPath.append(key)
        defer { decoder.codingPath.removeLast() }
        
        let isNil = try decodeNil(forKey: key)
        if isNil {
            return nil
        }
        return try UInt8(from: decoder)
    }
    func decodeIfPresent(_ type: UInt16.Type, forKey key: Key) throws -> UInt16? {
        decoder.codingPath.append(key)
        defer { decoder.codingPath.removeLast() }
        
        let isNil = try decodeNil(forKey: key)
        if isNil {
            return nil
        }
        return try UInt16(from: decoder)
    }
    func decodeIfPresent(_ type: UInt32.Type, forKey key: Key) throws -> UInt32? {
        decoder.codingPath.append(key)
        defer { decoder.codingPath.removeLast() }
        
        let isNil = try decodeNil(forKey: key)
        if isNil {
            return nil
        }
        return try UInt32(from: decoder)
    }
    func decodeIfPresent(_ type: UInt64.Type, forKey key: Key) throws -> UInt64? {
        decoder.codingPath.append(key)
        defer { decoder.codingPath.removeLast() }
        
        let isNil = try decodeNil(forKey: key)
        if isNil {
            return nil
        }
        return try UInt64(from: decoder)
    }
