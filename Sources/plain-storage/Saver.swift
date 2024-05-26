public protocol Saver {
  associatedtype T

  func load() -> T?

  func save(newItem: T) -> Bool

  func reset()

  func isNewItem(newItem: T, oldItem: T?) -> Bool
}
