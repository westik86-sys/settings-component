# DotSettingsKit

Reusable SwiftUI settings button and native sheet components for small apps.

`DotSettingsKit` provides a fixed visual contract for settings UI:

- bottom safe-area placement that follows native iOS spacing
- a text-only `Settings` button styled for iOS `ControlSize.regular` with a Liquid Glass material look
- automatic Light/Dark appearance from the host app environment
- a native settings sheet with customizable rows, sliders, toggles, pickers, links, and actions

## Installation

Add this repository as a Swift Package dependency in Xcode:

```text
File > Add Package Dependencies
```

For local development from this workspace, use:

```swift
.package(path: "../DotSettingsKit")
```

When using the GitHub repository, use:

```swift
.package(url: "https://github.com/westik86-sys/settings-component.git", from: "0.1.0")
```

## Usage

```swift
import SwiftUI
import DotSettingsKit

struct ContentView: View {
    var body: some View {
        Text("App")
            .settingsButton {
                SettingsSheet {
                    SettingsSection("Appearance") {
                        SettingsPicker(
                            "Theme",
                            key: "theme",
                            defaultValue: "system",
                            options: [
                                .init("System", value: "system"),
                                .init("Light", value: "light"),
                                .init("Dark", value: "dark")
                            ]
                        )
                    }

                    SettingsSection("Behavior") {
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
                    }
                }
            }
    }
}
```

Use bindings when the app already owns settings state:

```swift
SettingsToggle("Haptics", isOn: $settings.haptics)

SettingsPicker(
    "Theme",
    selection: $settings.theme,
    options: [
        .init("System", value: Theme.system),
        .init("Light", value: Theme.light),
        .init("Dark", value: Theme.dark)
    ]
)
```

## Components

- `View.settingsButton`
- `SettingsButton`
- `SettingsSheet`
- `SettingsSection`
- `SettingsToggle`
- `SettingsPicker`
- `SettingsSlider`
- `SettingsAction`
- `SettingsLink`

## Development

Run tests from the package directory:

```bash
swift test
```

## Example App

Use the included iOS example app to inspect and iterate on the UI:

```bash
open Example/DotSettingsKitExample.xcodeproj
```

Run the `DotSettingsKitExample` scheme on an iPhone simulator. The example project uses this package through a local path dependency, so changes in `Sources/DotSettingsKit` are picked up after rebuilding the example app.

## Release

Tag versions with semantic versioning:

```bash
git tag 0.1.0
git push origin 0.1.0
```
