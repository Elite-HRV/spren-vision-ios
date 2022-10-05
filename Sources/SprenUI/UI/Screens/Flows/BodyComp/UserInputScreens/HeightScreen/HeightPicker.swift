//
//  HeightPicker.swift
//  SprenInternal
//
//  Created by nick on 29.07.2022.
//

import SwiftUI

struct HeightPicker: UIViewRepresentable {
    let selection: Binding<HeightSize>
    let feet: [Int]
    let inches: [Int]
    let units: [HeightSize.Unit]

    let centimeters: [Int]

    func makeUIView(context: Context) -> UIPickerView {
        let pickerView = UIPickerView(frame: .zero)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.delegate = context.coordinator
        pickerView.dataSource = context.coordinator

        HeightPicker.updatePickerDefaults(pickerView: pickerView, selection: selection)
        return pickerView
    }

    func updateUIView(_ uiView: UIPickerView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        let coordinator = Coordinator(selection: selection, feet: feet, inches: inches, units: units, centimeters: centimeters)

        return coordinator
    }

    final class Coordinator: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
        let selection: Binding<HeightSize>
        let feet: [Int]
        let inches: [Int]
        let units: [HeightSize.Unit]
        let centimeters: [Int]

        init(selection: Binding<HeightSize>, feet: [Int], inches: [Int], units: [HeightSize.Unit], centimeters: [Int]) {
            self.selection = selection
            self.feet = feet
            self.inches = inches
            self.units = units
            self.centimeters = centimeters
        }

        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return selection.wrappedValue.unit == HeightSize.Unit.ft_in ? 3 : 2
        }

        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            switch component {
            case 0:
                return selection.wrappedValue.unit == HeightSize.Unit.ft_in ? feet.count : centimeters.count
            case 1:
                return selection.wrappedValue.unit == HeightSize.Unit.ft_in ? inches.count : units.count
            case 2:
                return units.count
            default:
                fatalError("not allowed switch case")
            }
        }

        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            switch component {
            case 0:
                return selection.wrappedValue.unit == HeightSize.Unit.ft_in ? "\(feet[row])’" : "\(centimeters[row]) cm"
            case 1:
                return selection.wrappedValue.unit == HeightSize.Unit.ft_in ? "\(inches[row])’’" : units[row].description
            case 2:
                return units[row].description
            default:
                fatalError("not allowed switch case")
            }
        }

        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            var currentFeet = selection.wrappedValue.feet
            var currentInches = selection.wrappedValue.inches

            var currentCentimeters = selection.wrappedValue.centimeters
            let component0Index = pickerView.selectedRow(inComponent: 0)
            let component1Index = pickerView.selectedRow(inComponent: 1)
            let unitId = selection.wrappedValue.unit == HeightSize.Unit.ft_in ? 2 : 1
            let unitIndex = pickerView.selectedRow(inComponent: unitId)

            // Do not switch values if unit is changing
            if (component != unitId) {
                if (units[unitIndex] == HeightSize.Unit.ft_in) {
                    currentFeet = feet[component0Index]
                    currentInches = inches[component1Index]
                } else if (units[unitIndex] == HeightSize.Unit.cm) {
                    currentCentimeters = centimeters[component0Index]
                } else {
                    fatalError("not allowed if case")
                }
            }

            selection.wrappedValue = HeightSize(feet: currentFeet, inches: currentInches, unit: units[unitIndex], centimeters: currentCentimeters)
            pickerView.reloadAllComponents()

            // Reselect defaults
            if (component == unitId) {
                HeightPicker.updatePickerDefaults(pickerView: pickerView, selection: selection)
            }
        }
    }

    private static func updatePickerDefaults(pickerView: UIPickerView, selection: Binding<HeightSize>) {
        if (selection.wrappedValue.unit == HeightSize.Unit.ft_in) {
            pickerView.selectRow(selection.wrappedValue.feet, inComponent:0, animated:false)
            pickerView.selectRow(selection.wrappedValue.inches, inComponent:1, animated:false)
            pickerView.selectRow(0, inComponent:2, animated:false)
        } else if (selection.wrappedValue.unit == HeightSize.Unit.cm) {
            pickerView.selectRow(selection.wrappedValue.centimeters, inComponent:0, animated:false)
            pickerView.selectRow(1, inComponent:1, animated:false)
        } else {
            fatalError("not allowed if case")
        }
    }
}

struct HeightPicker_Previews: PreviewProvider {
    static var selection = Binding(
        get: {
            HeightSize(feet: UserData.DEFAULT_HEIGHT_FEET, inches: UserData.DEFAULT_HEIGHT_INCHES, unit: .ft_in, centimeters: UserData.DEFAULT_HEIGHT_CENTIMETERS)
        },
        set: { value in
            print(value)
        })

    static var previews: some View {
        HeightPicker(selection: selection, feet: FEETS, inches: INCHES, units: HeightSize.Unit.allCases, centimeters: CENTIMETERS)
    }
}
