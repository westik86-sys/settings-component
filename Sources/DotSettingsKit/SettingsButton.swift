import SwiftUI

public struct SettingsButton<SheetContent: View>: View {
    @State private var isPresented = false

    private let title: LocalizedStringKey
    private let sheetContent: () -> SheetContent

    public init(
        _ title: LocalizedStringKey = "Settings",
        systemImage: String? = nil,
        @ViewBuilder content: @escaping () -> SheetContent
    ) {
        self.title = title
        self.sheetContent = content
    }

    public var body: some View {
        Button {
            isPresented = true
        } label: {
            Text(title)
                .font(.system(size: 17, weight: .semibold))
                .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44)
                .contentShape(Capsule())
        }
        .buttonStyle(.liquidGlassSettings)
        .accessibilityLabel(title)
        .sheet(isPresented: $isPresented, content: sheetContent)
    }
}

public extension View {
    func settingsButton<SheetContent: View>(
        _ title: LocalizedStringKey = "Settings",
        @ViewBuilder content: @escaping () -> SheetContent
    ) -> some View {
        modifier(SettingsButtonModifier(title: title, sheetContent: content))
    }
}

public struct LiquidGlassSettingsButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) private var colorScheme

    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(.primary)
            .padding(.horizontal, 18)
            .background {
                LiquidGlassButtonBackground()
            }
            .overlay {
                Capsule()
                    .strokeBorder(borderColor, lineWidth: 1)
            }
            .shadow(
                color: shadowColor.opacity(configuration.isPressed ? 0.08 : 0.18),
                radius: configuration.isPressed ? 6 : 16,
                y: configuration.isPressed ? 3 : 10
            )
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.snappy(duration: 0.18), value: configuration.isPressed)
    }

    private var borderColor: Color {
        colorScheme == .dark
            ? Color.white.opacity(0.22)
            : Color.white.opacity(0.62)
    }

    private var shadowColor: Color {
        colorScheme == .dark ? .black : .gray
    }
}

private struct LiquidGlassButtonBackground: View {
    var body: some View {
        #if compiler(>=6.2)
        if #available(iOS 26.0, macOS 26.0, tvOS 26.0, watchOS 26.0, *) {
            Capsule()
                .fill(.clear)
                .glassEffect(.regular, in: Capsule())
        } else {
            fallback
        }
        #else
        fallback
        #endif
    }

    private var fallback: some View {
        Capsule()
            .fill(.regularMaterial)
    }
}

public extension ButtonStyle where Self == LiquidGlassSettingsButtonStyle {
    static var liquidGlassSettings: LiquidGlassSettingsButtonStyle {
        LiquidGlassSettingsButtonStyle()
    }
}

private struct SettingsButtonModifier<SheetContent: View>: ViewModifier {
    private let title: LocalizedStringKey
    private let sheetContent: () -> SheetContent

    init(
        title: LocalizedStringKey,
        @ViewBuilder sheetContent: @escaping () -> SheetContent
    ) {
        self.title = title
        self.sheetContent = sheetContent
    }

    func body(content: Content) -> some View {
        content
            .safeAreaInset(edge: .bottom, spacing: 0) {
                SettingsButton(title, content: sheetContent)
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                    .padding(.bottom, 8)
            }
    }
}
