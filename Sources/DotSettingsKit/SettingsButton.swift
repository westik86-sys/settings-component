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
                .contentShape(Capsule())
        }
        .controlSize(.regular)
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
    @Environment(\.controlSize) private var controlSize

    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(metrics.font)
            .foregroundStyle(.primary)
            .frame(minHeight: metrics.height)
            .padding(.horizontal, metrics.horizontalPadding)
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

    private var metrics: LiquidGlassSettingsButtonMetrics {
        LiquidGlassSettingsButtonMetrics(controlSize: controlSize)
    }
}

private struct LiquidGlassSettingsButtonMetrics {
    let controlSize: ControlSize

    var font: Font {
        switch controlSize {
        case .mini:
            return .caption.weight(.semibold)
        case .small:
            return .callout.weight(.semibold)
        case .regular:
            return .body.weight(.semibold)
        case .large, .extraLarge:
            return .title3.weight(.semibold)
        @unknown default:
            return .callout.weight(.semibold)
        }
    }

    var height: CGFloat {
        switch controlSize {
        case .mini:
            return 26
        case .small:
            return 32
        case .regular:
            return 44
        case .large, .extraLarge:
            return 52
        @unknown default:
            return 32
        }
    }

    var horizontalPadding: CGFloat {
        switch controlSize {
        case .mini:
            return 12
        case .small:
            return 14
        case .regular:
            return 18
        case .large, .extraLarge:
            return 22
        @unknown default:
            return 14
        }
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
