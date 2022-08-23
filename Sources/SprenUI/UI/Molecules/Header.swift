//
//  Header.swift
//  SprenInternal
//
//  Created by Keith Carolus on 1/27/22.
//

import SwiftUI

struct Header: View {
    
    var backButtonColor: Color = .black
    var onBackButtonTap: (() -> Void)? = nil
        
    var body: some View {
        if onBackButtonTap == nil {
            Image("Logo", bundle: .module)
                .frame(height: Autoscale.headingHeight)
        } else {
            HStack {
                Spacer()
                BackButton(color: backButtonColor, action: onBackButtonTap)
                    .padding(.trailing, Autoscale.padding)
            }
            .frame(height: Autoscale.headingHeight)
        }
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header()
        Header(onBackButtonTap: {})
    }
}
