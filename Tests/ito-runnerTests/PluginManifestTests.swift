import Foundation
import Testing

@testable import ito_runner

@Suite("Plugin Manifest Tests")
struct PluginManifestTests {

    @Test("Decode standard Atsumaru manifest")
    func testDecodeAtsumaru() throws {
        let json = """
            {
                "info": {
                    "id": "en.atsumaru",
                    "name": "Atsumaru",
                    "version": 1,
                    "url": "https://atsu.moe/",
                    "contentRating": 0,
                    "languages": [
                        "en"
                    ]
                }
            }
            """

        let decoder = JSONDecoder()
        let manifest = try decoder.decode(PluginManifest.self, from: json.data(using: .utf8)!)

        #expect(manifest.info.id == "en.atsumaru")
        #expect(manifest.info.name == "Atsumaru")
        #expect(manifest.info.version == "1")
        #expect(manifest.info.url == "https://atsu.moe/")
        #expect(manifest.info.contentRating == .Safe)
        #expect(manifest.info.languages == ["en"])
    }
}
