# DotSettingsKit

Reusable SwiftUI settings button and native sheet components for small apps.

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
            .toolbar {
                SettingsButton {
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

## Release

Tag versions with semantic versioning:

```bash
git tag 0.1.0
git push origin 0.1.0
```
