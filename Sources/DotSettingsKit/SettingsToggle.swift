import Foundation
import SwiftUI

public struct SettingsToggle: View {
    private let title: LocalizedStringKey
    private let isOn: Binding<Bool>

    public init(
        _ title: LocalizedStringKey,
        isOn: Binding<Bool>
    ) {
        self.title = title
        self.isOn = isOn
    }

    public init(
        _ title: LocalizedStringKey,
        key: String,
        defaultValue: Bool = false,
        store: UserDefaults = .standard
    ) {
        self.title = title
        self.isOn = SettingsDefaults.boolBinding(
            key: key,
            defaultValue: defaultValue,
            store: store
        )
    }

    public var body: some View {
        Toggle(title, isOn: isOn)
    }
}
