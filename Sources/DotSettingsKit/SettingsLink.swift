import SwiftUI

public struct SettingsLink: View {
    private let title: LocalizedStringKey
    private let systemImage: String?
    private let destination: URL

    public init(
        _ title: LocalizedStringKey,
        systemImage: String? = nil,
        destination: URL
    ) {
        self.title = title
        self.systemImage = systemImage
        self.destination = destination
    }

    public var body: some View {
        Link(destination: destination) {
            if let systemImage {
                Label(title, systemImage: systemImage)
            } else {
                Text(title)
            }
        }
    }
}
