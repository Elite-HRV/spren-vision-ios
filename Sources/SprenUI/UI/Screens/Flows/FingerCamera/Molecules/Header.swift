//
//  Header.swift
//  SprenUI
//
//  Created by Keith Carolus on 1/27/22.
//

import SwiftUI

struct Header: View {
    
    var backButtonColor: Color
    var onBackButtonTap: (() -> Void)? = nil
        
    var body: some View {
        if onBackButtonTap == nil {
            Image("Logo", bundle: .module)
                .frame(height: Autoscale.headingHeight)
        } else {
            HStack {
                Spacer()
                BackButton(color: backButtonColor, action: onBackButtonTap)
                    .sprenUIPadding(.trailing)
            }
            .frame(height: Autoscale.headingHeight)
        }
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header(backButtonColor: .black)
        Header(backButtonColor: .black, onBackButtonTap: {})
    }
}
