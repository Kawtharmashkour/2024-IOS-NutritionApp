//
//  BookMarkView.swift
//  NutriScan
//
//  Created by KAWTHAR on 2024-03-20.
//

import SwiftUI

struct BookMarkView: View {
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Image(systemName: "bookmark")
                    .font(Font.title.weight(.light))
                    .foregroundColor(.white)
                    .imageScale(.small)
                    .shadow(color: Color("ColorBlackTransparentLight"), radius: 2, x:0, y:0)
                    .padding(.trailing, 20)
                    .padding(.top, 22)
                Spacer()
            }
        }
    }
}

#Preview {
    BookMarkView()
}
