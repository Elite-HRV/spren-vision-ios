//
//  SwiftUIView.swift
//  
//
//  Created by Fernando on 9/27/22.
//

import SwiftUI



struct InfoImprovements: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @State private var showing = false
    
    let title: String
    let text: String
    let items: [InfoImprovementsItem]
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text(title).font(.sprenSubtitle)
                    Spacer()
                }.padding(.bottom, 1)
                
                HStack {
                    Text(text).font(.sprenLabel)
                    Spacer()
                }.sprenUIPadding([.bottom])
                
                ItemView(item: items[0])
                
                if(!showing) {
                    InfoImprovementsButton(showing: showing, action: {
                        withAnimation {
                            showing.toggle()
                        }
                    })
                }
                
                if(showing) {
                    ForEach(items.indices, id: \.self) { index in
                        if(index > 0){
                            ItemView(item: items[index])
                        }
                    }
                    
                    InfoImprovementsButton(showing: showing, action: {
                        withAnimation {
                            showing.toggle()
                        }
                    })
                }
            }
            .sprenUIPadding()
            .background(colorScheme == .light ? Color.white : Color.black)
            .cornerRadius(16)
            .shadow(color: .gray.opacity(0.2), radius: 8)
        }
        .sprenUIPadding()
    }
}

struct ItemView: View {
    var item:InfoImprovementsItem
    
    var body: some View {
        VStack {
            HStack {
                Image(item.icon, bundle: .module).frame(width: 24)
                Text(item.title).font(.sprenParagraphBold)
                Spacer()
            }
            HStack {
                VStack {}.frame(width: 24)
                Text(item.text)
                    .font(.sprenLabel)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
            }
        }.animation(.easeInOut)
    }
}

struct InfoImprovementsButton: View {
    var showing: Bool
    var action: () -> Void
    
    var body: some View {
        HStack {
            Button(action: action, label: {
                Text("Show "+(showing ? "less" : "more")).font(.sprenLabelBold).foregroundColor(.sprenPink)
                Image(systemName: "chevron."+(showing ? "up" : "down"))
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.sprenPink)
                    .frame(width: 15)
                    
            })
            Spacer()
        }
    }
}

struct InfoImprovements_Previews: PreviewProvider {
    static var previews: some View {
        InfoImprovements(title: "How do I improve my HRV?",
                         text: "Healthy behaviors can increase your HRV. Here are some proven ways to increase your HRV:",
                         items: [InfoImprovementsItem(icon: "Cardio", title: "Stay active", text: "Avoid being sedentary and exercise appropriately; athletes should avoid overtraining."), InfoImprovementsItem(icon: "Sleep", title: "Sleep well and consistently", text: "Consistent, quality sleep is key to recovering from daily stressors."), InfoImprovementsItem(icon: "Food", title: "Eat well", text: "Reduce inflammatory foods and alcohol and prioritize nutrient rich foods; avoid large meals close to bedtime."), InfoImprovementsItem(icon: "Bottle", title: "Hydrate", text: "Hydration is important for maintaining a healthy blood volume needed to deliver oxygen and nutrients to your body."), InfoImprovementsItem(icon: "Bottle", title: "Hydrate", text: "Hydration is important for maintaining a healthy blood volume needed to deliver oxygen and nutrients to your body."), InfoImprovementsItem(icon: "Stress", title: "Better manage stress", text: "Listen to your body and prioritize recovery activities when you have increased stress."), InfoImprovementsItem(icon: "Breathing", title: "Intentional breathing", text: "Doing regular intentional breathing practices with slow, controlled breathing techniques can reduce stress and improve HRV."), InfoImprovementsItem(icon: "Sun", title: "Natural light exposure", text: "Early morning and evening sunlight can help regulate your circadium rhythm and improve vitamin D production.")])
    }
}

public struct InfoImprovementsItem {
    let icon: String
    let title: String
    let text: String
}
