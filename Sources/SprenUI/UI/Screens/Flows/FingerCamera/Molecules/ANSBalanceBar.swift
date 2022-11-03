//
//  ANSBalanceBar.swift
//  
//
//  Created by Keith Carolus on 9/23/22.
//

import SwiftUI

struct ANSBalanceBar: View {
    
    let ansBalance: Int
    
    let lineHeight = Autoscale.scaleFactor * 12
    let triangleSize = Autoscale.scaleFactor * 15
    
    var body: some View {
        GeometryReader { geometry in
            
            let valuePercent = Double(ansBalance) / 6
            let width = geometry.size.width
            
            VStack(spacing: 0) {
                HStack {
                    Spacer(minLength: ((valuePercent*width)-10))
                    Image(systemName: "arrowtriangle.down.fill")
                        .resizable()
                        .frame(width: triangleSize, height: triangleSize)
                        .foregroundColor(getArrowColor())
                        .padding(.bottom, 3)
                    Spacer(minLength: ((1-valuePercent)*width)-10)
                }
                .frame(alignment: .center)
                
                Rectangle()
                    .fill(
                        LinearGradient(gradient: Gradient(stops: [
                                .init(color: .red, location: 0),
                                .init(color: .yellow, location: 2/6),
                                .init(color: .green, location: 11/24),
                                .init(color: .green, location: 13/24),
                                .init(color: .yellow, location: 4/6),
                                .init(color: .red, location: 1),
                            ]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(height: lineHeight)
                    .cornerRadius(lineHeight/2)
                    
                
                HStack {
                    Text("Sympathetic")
                        .font(.sprenParagraph)
                        .foregroundColor(Color.gray)
                    Spacer()
                    Text("Parasympathetic")
                        .font(.sprenParagraph)
                        .foregroundColor(Color.gray)
                }
                
            }
        }
        .frame(height: 60)
    }
}

extension ANSBalanceBar {
    
    func getArrowColor() -> Color {
        switch ansBalance {
        case 1:  return .red
        case 2:  return .yellow
        case 3:  return .green
        case 4:  return .yellow
        case 5:  return .red
        default: return .white
        }
    }
    
}

struct ANSBalanceBar_Previews: PreviewProvider {
    static var previews: some View {
        ANSBalanceBar(ansBalance: 5)
    }
}
