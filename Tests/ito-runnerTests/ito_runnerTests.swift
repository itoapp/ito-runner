import Testing
@testable import ito_runner
import Foundation

@Test func versionComparison() async throws {
    let installedVersion = "1.0.0"
    let repoVersion = "1.0.1"

    let isAscending = installedVersion.compare(repoVersion, options: .numeric) == .orderedAscending
    #expect(isAscending == true)
}

@Test func versionComparisonFloat() async throws {
    let installedVersion = "1.0"
    let repoVersion = "1.0.1"

    let isAscending = installedVersion.compare(repoVersion, options: .numeric) == .orderedAscending
    #expect(isAscending == true)
}
