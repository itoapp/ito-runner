import Foundation

protocol PostcardArrayMarker {
    var postcardCount: Int { get }
}
extension Array: PostcardArrayMarker {
    var postcardCount: Int { return count }
}

func testArray(_ value: Any) {
    if let array = value as? PostcardArrayMarker {
        print("Got array of size \(array.postcardCount)")
    } else {
        print("Not an array")
    }
}

testArray([1, 2, 3])
testArray("Hello")
