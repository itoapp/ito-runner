import Foundation

public struct Manga: Codable, Sendable {
    public let id: String
    public let coverUrl: String
    public let title: String
    public let author: String
    public let artist: String
    public let description: String
    public let url: String
    public let categories: [String]
    public let status: Int32
    public let nsfw: Int32
    public let viewer: Int32

    public init(
        id: String, coverUrl: String, title: String, author: String = "", artist: String = "",
        description: String = "", url: String = "", categories: [String] = [], status: Int32 = 0,
        nsfw: Int32 = 0, viewer: Int32 = 0
    ) {
        self.id = id
        self.coverUrl = coverUrl
        self.title = title
        self.author = author
        self.artist = artist
        self.description = description
        self.url = url
        self.categories = categories
        self.status = status
        self.nsfw = nsfw
        self.viewer = viewer
    }
}

public struct MangaPageResult: Codable, Sendable {
    public let manga: [Manga]
    public let hasNextPage: Bool

    public init(manga: [Manga], hasNextPage: Bool) {
        self.manga = manga
        self.hasNextPage = hasNextPage
    }
}

public struct Chapter: Codable, Sendable {
    public let id: String
    public let title: String
    public let volume: Float32
    public let chapter: Float32
    public let dateUpdated: Float64
    public let scanlator: String
    public let url: String
    public let lang: String

    public init(
        id: String, title: String, volume: Float32 = -1.0, chapter: Float32 = -1.0,
        dateUpdated: Float64, scanlator: String = "", url: String = "", lang: String = ""
    ) {
        self.id = id
        self.title = title
        self.volume = volume
        self.chapter = chapter
        self.dateUpdated = dateUpdated
        self.scanlator = scanlator
        self.url = url
        self.lang = lang
    }
}

public struct Page: Codable, Sendable {
    public let index: Int32
    public let url: String
    public let base64: String
    public let text: String
    @PostcardMapCoded public var headers: [String: String]

    public init(
        index: Int32, url: String = "", base64: String = "", text: String = "",
        headers: [String: String]? = nil
    ) {
        self.index = index
        self.url = url
        self.base64 = base64
        self.text = text
        self._headers = PostcardMapCoded(wrappedValue: headers ?? [:])
    }
}

public struct FilterStruct: Codable, Sendable {
    public let type: String
    public let name: String
    public let value: FilterValue
}

public enum FilterValue: Codable, Sendable {
    case boolean(Bool)
    case int(Int64)
    case float(Double)
    case string(String)

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let b = try? container.decode(Bool.self) {
            self = .boolean(b)
        } else if let s = try? container.decode(String.self) {
            self = .string(s)
        } else if let i = try? container.decode(Int64.self) {
            self = .int(i)
        } else if let f = try? container.decode(Double.self) {
            self = .float(f)
        } else {
            throw DecodingError.dataCorruptedError(
                in: container, debugDescription: "Unknown FilterValue")
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .boolean(let b): try container.encode(b)
        case .int(let i): try container.encode(i)
        case .float(let f): try container.encode(f)
        case .string(let s): try container.encode(s)
        }
    }
}
