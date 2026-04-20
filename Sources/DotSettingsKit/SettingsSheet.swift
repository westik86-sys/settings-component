import SwiftUI

public struct SettingsSheet<Content: View>: View {
    private let title: LocalizedStringKey
    private let detents: Set<PresentationDetent>
    private let content: () -> Content

    public init(
        _ title: LocalizedStringKey = "Settings",
        detents: Set<PresentationDetent> = [.medium, .large],
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.detents = detents
        self.content = content
    }

    public var body: some View {
        NavigationStack {
            Form {
                content()
            }
            .navigationTitle(title)
        }
        .presentationDetents(detents)
    }
}
