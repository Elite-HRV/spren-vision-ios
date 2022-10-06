//
//  AnalyzingScreen+Tooltip.swift
//  SprenInternal
//
//  Created by nick on 03.08.2022.
//

import SwiftUI

extension AnalyzingScreen {
    
    func tooltip(type: ToolTip) -> some View {
        HStack(spacing: 10) {
            if (type == ToolTip.inProgress) {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                Text("Analyzing body composition...")
                    .foregroundColor(colorScheme == .light ? .white : .black)
                    .font(.sprenLabel)
            } else if (type == ToolTip.isCompleted) {
                Image(systemName: "checkmark")
                    .foregroundColor(colorScheme == .light ? .white : .black)
                Text("Analysis complete")
                    .foregroundColor(colorScheme == .light ? .white : .black)
                    .font(.sprenLabel)
            } else if (type == ToolTip.isError) {
                Image(systemName: "xmark")
                    .foregroundColor(colorScheme == .light ? .white : .black)
                Text("Analysis error")
                    .foregroundColor(colorScheme == .light ? .white : .black)
                    .font(.sprenLabel)
            }
        }
        .frame(width: UIScreen.screenWidth - Autoscale.convert(90))
        .padding(Autoscale.convert(15))
        .background(Color("AppBlack", bundle: .module).opacity(0.52))
        .cornerRadius(Autoscale.convert(15))
        .padding(EdgeInsets(top: 0, leading: 0, bottom: Autoscale.convert(60), trailing: 0))
    }
}

enum ToolTip {
    case inProgress
    case isCompleted
    case isError
}
