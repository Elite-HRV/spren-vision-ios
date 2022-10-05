//
//  CloseButton.swift
//  SprenInternal
//
//  Created by José Fernando Eckert on 27/07/22.
//

import SwiftUI

struct CloseButton: View {

    var sizeWidth: CGFloat?
    var sizeHeight: CGFloat?
    var action: () -> Void
    var image: String?
    var inline: Bool = false
    var padding: Bool = false

    var body: some View {
        if (inline == false) {
            HStack {
                Spacer()

                btn
            }
        }else{
            btn
        }
    }
    
    var btn: some View {
        Button {
            action()
        } label: {
            Image(image ?? "Close", bundle: .module)
                .frame(width: sizeWidth ?? Autoscale.convert(18), height: sizeHeight ?? Autoscale.convert(18), alignment: .center)
                .padding(Autoscale.convert(padding ? 10 : 0))
        }
    }
}
