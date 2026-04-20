import DotSettingsKit
import SwiftUI

struct ContentView: View {
    @AppStorage("exampleTheme") private var theme = "system"
    @AppStorage("particleSpeed") private var particleSpeed = 0.5
    @AppStorage("haptics") private var haptics = true
    @AppStorage("sound") private var sound = true

    var body: some View {
        ZStack {
            background

            VStack(spacing: 18) {
                Text("DotSettingsKit")
                    .font(.largeTitle.weight(.bold))

                Text("Change package code, rebuild this example, and inspect the settings button and native sheet here.")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: 320)

                VStack(alignment: .leading, spacing: 10) {
                    Label("Theme: \(theme.capitalized)", systemImage: "circle.lefthalf.filled")
                    Label("Particle speed: \(particleSpeed, specifier: "%.2f")", systemImage: "slider.horizontal.3")
                    Label("Haptics: \(haptics ? "On" : "Off")", systemImage: "iphone.radiowaves.left.and.right")
                    Label("Sound: \(sound ? "On" : "Off")", systemImage: "speaker.wave.2")
                }
                .font(.callout)
                .padding(16)
                .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
            }
            .padding(.horizontal, 24)
        }
        .preferredColorScheme(preferredColorScheme)
        .settingsButton {
            SettingsSheet {
                SettingsSection("Appearance") {
                    SettingsPicker(
                        "Theme",
                        key: "exampleTheme",
                        defaultValue: "system",
                        options: [
                            .init("System", value: "system"),
                            .init("Light", value: "light"),
                            .init("Dark", value: "dark")
                        ]
                    )
                }

                SettingsSection("Controls") {
                    SettingsSlider(
                        "Particle Speed",
                        key: "particleSpeed",
                        defaultValue: 0.5,
                        in: 0...1,
                        step: 0.05
                    )

                    SettingsToggle(
                        "Haptics",
                        key: "haptics",
                        defaultValue: true
                    )

                    SettingsToggle(
                        "Sound",
                        key: "sound",
                        defaultValue: true
                    )
                }

                SettingsSection("Links") {
                    SettingsLink(
                        "Apple Human Interface Guidelines",
                        systemImage: "safari",
                        destination: URL(string: "https://developer.apple.com/design/human-interface-guidelines/")!
                    )
                }
            }
        }
    }

    private var preferredColorScheme: ColorScheme? {
        switch theme {
        case "light":
            return .light
        case "dark":
            return .dark
        default:
            return nil
        }
    }

    private var background: some View {
        LinearGradient(
            colors: [
                Color(red: 0.13, green: 0.46, blue: 0.85),
                Color(red: 0.12, green: 0.74, blue: 0.62),
                Color(red: 0.95, green: 0.42, blue: 0.35)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
        .overlay(.ultraThinMaterial)
    }
}

#Preview("Light") {
    ContentView()
        .preferredColorScheme(.light)
}

#Preview("Dark") {
    ContentView()
        .preferredColorScheme(.dark)
}
