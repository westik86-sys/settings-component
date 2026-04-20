import Foundation
import SwiftUI

public struct SettingsSlider: View {
    private let title: LocalizedStringKey
    private let value: Binding<Double>
    private let bounds: ClosedRange<Double>
    private let step: Double.Stride?

    public init(
        _ title: LocalizedStringKey,
        value: Binding<Double>,
        in bounds: ClosedRange<Double>,
        step: Double.Stride? = nil
    ) {
        self.title = title
        self.value = value
        self.bounds = bounds
        self.step = step
    }

    public init(
        _ title: LocalizedStringKey,
        key: String,
        defaultValue: Double,
        in bounds: ClosedRange<Double>,
        step: Double.Stride? = nil,
        store: UserDefaults = .standard
    ) {
        self.init(
            title,
            value: SettingsDefaults.doubleBinding(
                key: key,
                defaultValue: defaultValue,
                store: store
            ),
            in: bounds,
            step: step
        )
    }

    public var body: some View {
        VStack(alignment: .leading) {
            Text(title)

            if let step {
                Slider(value: value, in: bounds, step: step)
            } else {
                Slider(value: value, in: bounds)
            }
        }
    }
}
