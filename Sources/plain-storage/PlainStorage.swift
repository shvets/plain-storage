import Foundation

open class PlainStorage<T: Codable> {
  public let store: UserDefaults = .standard

  private let encoder = JSONEncoder()
  private let decoder = JSONDecoder()

  public var key: String

  public init(_ key: String) {
    self.key = key
  }

  public func save(_ value: T) throws {
    let data = try encoder.encode(value)

    store.set(data, forKey: key)
  }

  public func load() throws -> T? {
    let data = store.data(forKey: key)

    if let data = data { // data.isEmpty == false
      return try decoder.decode(T.self, from: data)
    }

    return nil
  }

  public func reset() {
    store.removeObject(forKey: key)
  }
}

