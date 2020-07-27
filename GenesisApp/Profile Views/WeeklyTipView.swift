//
//  WeeklyTipView.swift
//  GenesisApp
//
//  Created by Productivity on 7/15/20.
//  Copyright © 2020 Genesis. All rights reserved.
//

import SwiftUI

struct WeeklyTipView: View {
    
    
    var body: some View {
        
        VStack {
            
            HStack {
                
                Text("Weekly Tip")
                    .font(Font.custom("Lato-Black", size: screen.height > 850 ? 30 : 24))
                    .foregroundColor(.white)
                
                Spacer()
                
                HStack {
                    Button(action: {
                        //
                    }) {
                        Image("Backward arrow small")
                            .foregroundColor(Color(#colorLiteral(red: 0.9614372849, green: 0.9614372849, blue: 0.9614372849, alpha: 1)))
                    }
                    
                    Text("This Week")
                        .font(Font.custom("Lato-Black", size: 18))
                        .foregroundColor(Color(#colorLiteral(red: 0.9614372849, green: 0.9614372849, blue: 0.9614372849, alpha: 1)))
                    
//                    Button(action: {
//                        //
//                    }) {
//                        Image("Backward arrow small")
//                            .foregroundColor(.secondaryText)
//                            .rotationEffect(.degrees(180))
//                    }
                }
                
            }.padding(.horizontal,6)
            
            ScrollView (showsIndicators: false) {
                
                Text("Did you know it’s almost 5 times more expensive to order from a restaurant than it is to cook at home? We love eating out too, but staying in is sure to result in tastier savings.")
                    .font(Font.custom("Lato-Regular", size:
                        screen.height > 850 ? 20 :
                        screen.height < 800 ? 16 : 18))
                    .foregroundColor(.white)
                
            }.padding(.horizontal,4)
                .padding(.top,-6)
            
        }
        .frame(maxWidth: .infinity)
        .frame(height: screen.height / 5)
        .padding()
        .background(Color.primaryGreen)
        .cornerRadius(21)
        .padding(.horizontal)
        .shadow(radius: 2)
    
    }
}

struct WeeklyTipView_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyTipView()
    }
}
