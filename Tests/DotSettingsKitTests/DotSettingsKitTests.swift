import XCTest
@testable import DotSettingsKit

final class DotSettingsKitTests: XCTestCase {
    func testBoolBindingUsesDefaultUntilValueIsStored() {
        let store = makeStore()
        let binding = SettingsDefaults.boolBinding(
            key: "haptics",
            defaultValue: true,
            store: store
        )

        XCTAssertTrue(binding.wrappedValue)

        binding.wrappedValue = false

        XCTAssertFalse(binding.wrappedValue)
        XCTAssertFalse(store.bool(forKey: "haptics"))
    }

    func testStringBindingStoresSelectedValue() {
        let store = makeStore()
        let binding = SettingsDefaults.stringBinding(
            key: "theme",
            defaultValue: "system",
            store: store
        )

        XCTAssertEqual(binding.wrappedValue, "system")

        binding.wrappedValue = "dark"

        XCTAssertEqual(binding.wrappedValue, "dark")
        XCTAssertEqual(store.string(forKey: "theme"), "dark")
    }

    func testDoubleBindingUsesDefaultUntilValueIsStored() {
        let store = makeStore()
        let binding = SettingsDefaults.doubleBinding(
            key: "particleSpeed",
            defaultValue: 0.5,
            store: store
        )

        XCTAssertEqual(binding.wrappedValue, 0.5)

        binding.wrappedValue = 0.75

        XCTAssertEqual(binding.wrappedValue, 0.75)
        XCTAssertEqual(store.double(forKey: "particleSpeed"), 0.75)
    }

    private func makeStore() -> UserDefaults {
        let suiteName = "DotSettingsKitTests.\(UUID().uuidString)"
        guard let store = UserDefaults(suiteName: suiteName) else {
            XCTFail("Failed to create test defaults store")
            return .standard
        }

        store.removePersistentDomain(forName: suiteName)
        return store
    }
}
