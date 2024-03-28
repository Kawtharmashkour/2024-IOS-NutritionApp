//
//  HeaderView.swift
//  NutriScan
//
//  Created by KAWTHAR on 2024-03-20.
//

import SwiftUI

struct HeaderView: View {
    @State private var showHeadline: Bool = false
    @EnvironmentObject var viewModel: AuthViewModel
    
    var slideInAnimation: Animation {
      Animation.spring(response: 1.5, dampingFraction: 0.5, blendDuration: 0.5)
        .speed(1)
        .delay(0.25)
    }
    
    var body: some View {
      ZStack {
          
        Image("header-image")
          .resizable()
          .aspectRatio(contentMode: .fill)
          
          VStack (alignment: .leading)  {
              if let fullname = viewModel.currentUser?.fullname {
                  Text("Welcome, \(fullname)")
                      .font(.system(size: 11))
                      .background(Color("ColorAppearanceAdaptive"))
                      .foregroundColor(Color("ColorGreenAdaptive"))
                      .padding()
                      .frame(maxWidth: .infinity, alignment: .trailing)
                      .offset(x: -70, y: -90)
                  
              }
          }
        
        HStack(alignment: .top, spacing: 0) {
          Rectangle()
            .fill(Color("ColorGreenLight"))
            .frame(width: 4)
          
          VStack(alignment: .leading, spacing: 6) {
            Text("NutriScan")
              .font(.system(.title, design: .serif))
              .fontWeight(.bold)
              .foregroundColor(Color.white)
              .shadow(radius: 3)
            
            Text("NutriScan has veriety of healy meal planer")
              .font(.footnote)
              .lineLimit(2)
              .multilineTextAlignment(.leading)
              .foregroundColor(Color.white)
              .shadow(radius: 3)
          }
          .padding(.vertical, 0)
          .padding(.horizontal, 20)
          .frame(width: 281, height: 105)
          .background(Color("ColorBlackTransparentLight"))
        }
        .frame(width: 285, height: 105, alignment: .center)
        .offset(x: -66, y: showHeadline ? 75 : 220)
        .animation(slideInAnimation)
        .onAppear(perform: {
          showHeadline = true
        })
        .onDisappear(perform: {
          showHeadline = false
        })
      }
      .frame(width: 480, height: 320, alignment: .center)
    }
  }

  struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
      HeaderView()
        .previewLayout(.sizeThatFits)
        .environment(\.colorScheme, .dark)
    }
}

#Preview {
    HeaderView()
}
