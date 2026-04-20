import Foundation
import SwiftUI

public struct SettingsOption<Value: Hashable>: Identifiable {
    public let id: Value
    public let title: LocalizedStringKey
    public let value: Value

    public init(_ title: LocalizedStringKey, value: Value) {
        self.id = value
        self.title = title
        self.value = value
    }
}

public struct SettingsPicker<Value: Hashable>: View {
    private let title: LocalizedStringKey
    private let selection: Binding<Value>
    private let options: [SettingsOption<Value>]

    public init(
        _ title: LocalizedStringKey,
        selection: Binding<Value>,
        options: [SettingsOption<Value>]
    ) {
        self.title = title
        self.selection = selection
        self.options = options
    }

    public var body: some View {
        Picker(title, selection: selection) {
            ForEach(options) { option in
                Text(option.title).tag(option.value)
            }
        }
    }
}

public extension SettingsPicker where Value == String {
    init(
        _ title: LocalizedStringKey,
        key: String,
        defaultValue: String,
        store: UserDefaults = .standard,
        options: [SettingsOption<String>]
    ) {
        self.init(
            title,
            selection: SettingsDefaults.stringBinding(
                key: key,
                defaultValue: defaultValue,
                store: store
            ),
            options: options
        )
    }
}
