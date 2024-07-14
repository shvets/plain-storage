public protocol Saver {
  associatedtype T

  func load(_ key: String) -> T?

  func save(_ key: String, value: T) -> Bool

  func reset(_ key: String)

  func isNewItem(newItem: T, oldItem: T?) -> Bool
}
