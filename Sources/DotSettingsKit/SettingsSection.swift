import SwiftUI

public struct SettingsSection<Content: View>: View {
    private let title: LocalizedStringKey
    private let footer: LocalizedStringKey?
    private let content: () -> Content

    public init(
        _ title: LocalizedStringKey,
        footer: LocalizedStringKey? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.footer = footer
        self.content = content
    }

    public var body: some View {
        Section {
            content()
        } header: {
            Text(title)
        } footer: {
            if let footer {
                Text(footer)
            }
        }
    }
}
