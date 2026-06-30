import OSLog
import Foundation

/// The default implementation of `StdModule`, which writes to standard output.
public final class DefaultStdModule: StdModule, Sendable {

    public init() {}
    public func print(message: String) {
        RunnerLogger.wasm.debug("[Plugin] \(message)")
    }
}
