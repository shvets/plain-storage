open class PlainSaver<T: Codable>: Saver {
  var storage: PlainStorage<T>

  public init(storage: PlainStorage<T>) {
    self.storage = storage
  }

  public func load() -> T? {
    var item: T? = nil

    do {
      item = try storage.load()
    }
    catch(let e) {
      print(e.localizedDescription)
    }

    return item
  }

  public func save(newItem: T) -> Bool {
    let oldItem = load()

    if isNewItem(newItem: newItem, oldItem: oldItem) {
      do {
        try storage.save(newItem)

        return true
      }
      catch(let e) {
        print(e.localizedDescription)
      }
    }

    return false
  }

  public func reset() {
    storage.reset()
  }

  public func isNewItem(newItem: T, oldItem: T?) -> Bool {
    true
  }
}