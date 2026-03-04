import Foundation

/// The default implementation of `StdModule`, which writes to standard output.
public final class DefaultStdModule: StdModule, Sendable {

    public init() {}

    public func print(message: String) {
        Swift.print("[Plugin] \(message)")
    }
}
