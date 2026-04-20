import Foundation
import SwiftUI

public enum SettingsDefaults {
    public static func boolBinding(
        key: String,
        defaultValue: Bool,
        store: UserDefaults = .standard
    ) -> Binding<Bool> {
        let defaults = SendableUserDefaults(store)

        return Binding(
            get: {
                guard defaults.object(forKey: key) != nil else {
                    return defaultValue
                }

                return defaults.bool(forKey: key)
            },
            set: { newValue in
                defaults.set(newValue, forKey: key)
            }
        )
    }

    public static func stringBinding(
        key: String,
        defaultValue: String,
        store: UserDefaults = .standard
    ) -> Binding<String> {
        let defaults = SendableUserDefaults(store)

        return Binding(
            get: {
                defaults.string(forKey: key) ?? defaultValue
            },
            set: { newValue in
                defaults.set(newValue, forKey: key)
            }
        )
    }

    public static func doubleBinding(
        key: String,
        defaultValue: Double,
        store: UserDefaults = .standard
    ) -> Binding<Double> {
        let defaults = SendableUserDefaults(store)

        return Binding(
            get: {
                guard defaults.object(forKey: key) != nil else {
                    return defaultValue
                }

                return defaults.double(forKey: key)
            },
            set: { newValue in
                defaults.set(newValue, forKey: key)
            }
        )
    }
}

private struct SendableUserDefaults: @unchecked Sendable {
    private let store: UserDefaults

    init(_ store: UserDefaults) {
        self.store = store
    }

    func object(forKey key: String) -> Any? {
        store.object(forKey: key)
    }

    func bool(forKey key: String) -> Bool {
        store.bool(forKey: key)
    }

    func string(forKey key: String) -> String? {
        store.string(forKey: key)
    }

    func double(forKey key: String) -> Double {
        store.double(forKey: key)
    }

    func set(_ value: Any?, forKey key: String) {
        store.set(value, forKey: key)
    }
}
