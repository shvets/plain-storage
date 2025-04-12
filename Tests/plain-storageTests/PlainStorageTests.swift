import Foundation
import Testing

@testable import plain_storage

@Suite("PlainStorage Tests")
struct PlainStorageTests {
  struct TestData: Codable, Equatable {
    let id: Int
    let name: String
  }

  @Test("Saving and loading a value round-trips correctly")
  func testSaveAndLoad() throws {
    let key = "test_save_load"
    let storage = PlainStorage<TestData>(key)
    let value = TestData(id: 42, name: "Test")

    storage.reset()
    try storage.save(value)
    let loaded = try storage.load()

    #expect(loaded == value)
  }

  @Test("Loading from empty key returns nil")
  func testLoadNil() throws {
    let key = "test_empty"
    let storage = PlainStorage<TestData>(key)

    storage.reset()
    let loaded = try storage.load()

    #expect(loaded == nil)
  }

  @Test("Reset removes stored data")
  func testReset() throws {
    let key = "test_reset"
    let storage = PlainStorage<TestData>(key)
    let value = TestData(id: 1, name: "DeleteMe")

    try storage.save(value)
    storage.reset()
    let loaded = try storage.load()

    #expect(loaded == nil)
  }

  @Test("Saving corrupted data manually causes decoding to fail")
  func testCorruptData() throws {
    let key = "test_corrupt"
    let storage = PlainStorage<TestData>(key)

    // Inject corrupt data into UserDefaults
    let invalidData = "💣".data(using: .utf8)!
    storage.store.set(invalidData, forKey: key)

    var didThrow = false
    do {
      _ = try storage.load()
    } catch {
      didThrow = true
    }

    #expect(didThrow)
  }

    @Test("load() returns nil when no value is saved")
      func testLoadWhenEmpty() throws {
        let key = "load_empty"
        let storage = PlainStorage<TestData>(key)

        storage.reset()
        let result = try storage.load()

        #expect(result == nil)
      }

      @Test("load() returns the exact saved value")
      func testLoadAfterSave() throws {
        let key = "load_after_save"
        let storage = PlainStorage<TestData>(key)
        let original = TestData(id: 100, name: "Loaded")

        storage.reset()
        try storage.save(original)
        let loaded = try storage.load()

        #expect(loaded == original)
      }

      @Test("load() throws if stored data is corrupted")
      func testLoadWithCorruptData() throws {
        let key = "load_corrupt"
        let storage = PlainStorage<TestData>(key)

        // Injecting invalid JSON data
        let invalid = "invalid_json".data(using: .utf8)!
        storage.store.set(invalid, forKey: key)

        var didThrow = false
        do {
          _ = try storage.load()
        } catch {
          didThrow = true
        }

        #expect(didThrow)
      }

      @Test("load() returns nil after reset")
      func testLoadAfterReset() throws {
        let key = "load_after_reset"
        let storage = PlainStorage<TestData>(key)
        let data = TestData(id: 7, name: "ToBeCleared")

        try storage.save(data)
        storage.reset()
        let loaded = try storage.load()

        #expect(loaded == nil)
      }
}
