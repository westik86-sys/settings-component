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
            .scrollContentBackground(.hidden)
            .background(SettingsSheetBackground())
            .navigationTitle(title)
        }
        .presentationDetents(detents)
        #if os(iOS)
        .presentationDragIndicator(.visible)
        #endif
    }
}

private struct SettingsSheetBackground: View {
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        Rectangle()
            .fill(.regularMaterial)
            .overlay(adaptiveTint)
            .ignoresSafeArea()
    }

    private var adaptiveTint: Color {
        colorScheme == .dark
            ? Color.black.opacity(0.18)
            : Color.white.opacity(0.16)
    }
}
