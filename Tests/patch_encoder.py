import sys

def insert_before(file_path, search_str, insert_file):
    with open(file_path, 'r') as f:
        content = f.read()
    with open(insert_file, 'r') as f:
        insert_content = f.read()
    
    parts = content.split(search_str)
    if len(parts) == 2:
        new_content = parts[0] + insert_content + search_str + parts[1]
        with open(file_path, 'w') as f:
            f.write(new_content)
        print(f"Patched {file_path}")
    else:
        print(f"Match count: {len(parts)-1} for {search_str} in {file_path}")

insert_before("Sources/ito-runner/PostcardEncoder.swift", "    mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type, forKey key: Key)", "keyed_encode.swift")
insert_before("Sources/ito-runner/PostcardEncoder.swift", "    mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type) -> KeyedEncodingContainer<NestedKey>", "unkeyed_encode.swift")

insert_before("Sources/ito-runner/PostcardDecoder.swift", "    func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type, forKey key: Key)", "keyed_decode.swift")
insert_before("Sources/ito-runner/PostcardDecoder.swift", "    mutating func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type) throws -> KeyedDecodingContainer<NestedKey>", "unkeyed_decode.swift")

