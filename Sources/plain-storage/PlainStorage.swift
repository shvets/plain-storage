import Foundation

open class PlainStorage<T: Codable> {
  public let store: UserDefaults = .standard

  private let encoder = JSONEncoder()
  private let decoder = JSONDecoder()

  public init() {}

  public func save(_ key: String, value: T) throws {
    let data = try encoder.encode(value)

    store.set(data, forKey: key)
  }

  public func load(key: String) throws -> T? {
    let data = store.data(forKey: key)

    if let data = data {
      return try decoder.decode(T.self, from: data)
    }

    return nil
  }

  public func reset(key: String) {
    store.removeObject(forKey: key)
  }
}
