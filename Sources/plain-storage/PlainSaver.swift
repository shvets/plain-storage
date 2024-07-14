open class PlainSaver<T: Codable>: Saver {
  var storage: PlainStorage<T>

  public init(storage: PlainStorage<T>) {
    self.storage = storage
  }

  public func load(_ key: String) -> T? {
    var item: T? = nil

    do {
      item = try storage.load(key: key)
    }
    catch(let e) {
      print(e.localizedDescription)
    }

    return item
  }

  public func save(_ key: String, value: T) -> Bool {
    let currentItem = load(key)

    if isNewItem(newItem: value, oldItem: currentItem) {
      do {
        try storage.save(key, value: value)

        return true
      }
      catch(let e) {
        print(e.localizedDescription)
      }
    }

    return false
  }

  public func reset(_ key: String) {
    storage.reset(key: key)
  }

  public func isNewItem(newItem: T, oldItem: T?) -> Bool {
    true
  }
}