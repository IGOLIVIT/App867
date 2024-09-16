//
//  LoadingView.swift
//  App867
//
//  Created by IGOR on 30/08/2024.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {

        ZStack {
            
            Color("prim")
                .ignoresSafeArea()
            
            VStack {
                
                Image("Llogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200)
            }
            
            VStack {
                
                Spacer()
                
                ProgressView()
                    .padding(.bottom, 130)
            }
        }
    }
}

#Preview {
    LoadingView()
}
