import SwiftUI

public struct SettingsButton<SheetContent: View>: View {
    @State private var isPresented = false

    private let title: LocalizedStringKey
    private let systemImage: String
    private let sheetContent: () -> SheetContent

    public init(
        _ title: LocalizedStringKey = "Settings",
        systemImage: String = "gearshape",
        @ViewBuilder content: @escaping () -> SheetContent
    ) {
        self.title = title
        self.systemImage = systemImage
        self.sheetContent = content
    }

    public var body: some View {
        Button {
            isPresented = true
        } label: {
            Label(title, systemImage: systemImage)
        }
        .sheet(isPresented: $isPresented, content: sheetContent)
    }
}
