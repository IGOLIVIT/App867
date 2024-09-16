//
//  DiaryView.swift
//  App867
//
//  Created by IGOR on 30/08/2024.
//

import SwiftUI
import StoreKit

struct DiaryView: View {
    
    @StateObject var viewModel = DiaryViewModel()
    
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack(spacing: 8) {
                
                Button(action: {
                    
                    withAnimation(.spring()) {
                        
                        viewModel.isAdd = true
                    }
                    
                }, label: {
                    
                    Text("Add")
                        .foregroundColor(.white)
                        .font(.system(size: 13, weight: .regular))
                        .padding(6)
                        .padding(.horizontal, 6)
                        .background(RoundedRectangle(cornerRadius: 20).fill(Color("bg2")))
                })
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                Text("Diary")
                    .foregroundColor(.white)
                    .font(.system(size: 30, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    
                    HStack {
                        
                        VStack(alignment: .leading) {
                            
                            Text("Hi!")
                                .foregroundColor(.white)
                                .font(.system(size: 18, weight: .semibold))
                            
                            Text("To get better, keep a diary every day")
                                .foregroundColor(.gray)
                                .font(.system(size: 15, weight: .medium))
                            
                        }
                        .frame(width: 150)
                        
                        Spacer()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 110)
                    .background(Image("fbg").resizable().cornerRadius(15))
                    
                    VStack {
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isSettings = true
                            }
                            
                        }, label: {
                            
                            Image(systemName: "gearshape.fill")
                                .foregroundColor(Color("prim"))
                                .font(.system(size: 18, weight: .regular))
                            
                        })

                    }
                    .padding()
                    .frame(width: 80, height: 110)
                    .background(RoundedRectangle(cornerRadius: 15).fill(.gray.opacity(0.1)))
                }
                
                HStack {
                    
                    ForEach(viewModel.eats, id: \.self) { index in
                        
                        Button(action: {
                            
                            viewModel.currentEat = index
                            
                        }, label: {
                            
                            Text(index)
                                .foregroundColor(.white)
                                .font(.system(size: 13, weight: .regular))
                                .frame(maxWidth: .infinity)
                                .frame(height: 22)
                                .background(RoundedRectangle(cornerRadius: 7).fill(.gray.opacity(viewModel.currentEat == index ? 0.3 : 0)))
                        })
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 25)
                .background(RoundedRectangle(cornerRadius: 7).fill(Color("bg2")))
                
                if viewModel.diaries.isEmpty {
                    
                    VStack(spacing: 15) {
                        
                        Text("Empty")
                            .foregroundColor(.white)
                            .font(.system(size: 22, weight: .semibold))
                        
                        Image("empty")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100)
                        
                        Text("There are no records")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .regular))
                        
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 25.0).fill(Color("bg2")))
                    
                    Spacer()
                    
                } else {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        LazyVStack {
                            
                            ForEach(viewModel.diaries.filter{($0.diEat ?? "") == viewModel.currentEat}, id: \.self) { index in
                            
                                Button(action: {
                                    
                                    viewModel.selectedDiary = index
                                    
                                    withAnimation(.spring()) {
                                        
                                        viewModel.isDetail = true
                                    }
                                    
                                }, label: {
                                    
                                    HStack {
                                        
                                        VStack {
                                            
                                            Text("\((index.diDate ?? Date()).convertDate(format: "dd"))")
                                                .foregroundColor(Color("prim"))
                                                .font(.system(size: 18, weight: .medium))
                                            
                                            Text("\((index.diDate ?? Date()).convertDate(format: "MMMMM"))")
                                                .foregroundColor(.white)
                                                .font(.system(size: 15, weight: .regular))
                                        }
                                        .padding()
                                        .frame(width: 80)
                                        .frame(maxHeight: .infinity)
                                        .background(RoundedRectangle(cornerRadius: 25.0).fill(Color.white.opacity(0.05)))
                                        
                                        VStack(alignment: .leading, spacing: 8) {
                                            
                                            HStack {
                                                
                                                Text(index.diTitle ?? "")
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 16, weight: .medium))
                                                
                                                Spacer()
                                                
                                                Image(systemName: "clock")
                                                    .foregroundColor(Color("prim"))
                                                    .font(.system(size: 16, weight: .regular))
                                                
                                                Text(index.diTime ?? "")
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 15, weight: .regular))
                                            }
                                            
                                            Text(index.diDescr ?? "")
                                                .foregroundColor(.gray)
                                                .font(.system(size: 13, weight: .regular))
                                            
                                            Text(index.diIng ?? "")
                                                .foregroundColor(.white.opacity(0.5))
                                                .font(.system(size: 12, weight: .regular))
                                                .padding(6)
                                                .padding(.horizontal, 5)
                                                .background(RoundedRectangle(cornerRadius: 6).fill(Color.white.opacity(0.05)))
                                        }
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .frame(height: 140)
                                    .background(RoundedRectangle(cornerRadius: 25.0).fill(Color("bg2")))
                                })
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .onAppear {
            
            viewModel.fetchDiaries()
        }
        .sheet(isPresented: $viewModel.isAdd, content: {
            
            AddDiary(viewModel: viewModel)
        })
        .sheet(isPresented: $viewModel.isDetail, content: {
            
            DiaryDetail(viewModel: viewModel)
        })
        .overlay(
            
            ZStack {
                
                Color.black.opacity(viewModel.isSettings ? 0.5 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isSettings = false
                        }
                    }
                
                VStack {
                    
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.white.opacity(0.1))
                        .frame(width: 40, height: 3)
                    
                    Text("Settings")
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .semibold))
                        .padding()
                    
                    Button(action: {
                        
                        SKStoreReviewController.requestReview()
                        
                    }, label: {
                        
                        HStack {
                            
                            Image(systemName: "star.fill")
                                .foregroundColor(Color("prim"))
                                .font(.system(size: 15, weight: .regular))
                            
                            Spacer()
                            
                            Text("Rate our app")
                                .foregroundColor(Color.white)
                                .font(.system(size: 17, weight: .medium))
                            
                            Spacer()
                            
                            Image(systemName: "arrow.up.right")
                                .foregroundColor(.white)
                                .font(.system(size: 18, weight: .medium))
                            
                        }
                        .padding()
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(RoundedRectangle(cornerRadius: 30).fill(Color.white.opacity(0.05)))
                    })
                    
                    Button(action: {
                        
                        guard let url = URL(string: "https://www.termsfeed.com/live/f8e9a8ef-cb20-45e1-88ff-51ef454fbc03") else { return }
                        
                        UIApplication.shared.open(url)
                        
                    }, label: {
                        
                        HStack {
                            
                            Image(systemName: "leaf.fill")
                                .foregroundColor(Color("prim"))
                                .font(.system(size: 15, weight: .regular))
                            
                            Spacer()
                            
                            Text("Usage Policy")
                                .foregroundColor(Color.white)
                                .font(.system(size: 17, weight: .medium))
                            
                            Spacer()
                            
                            Image(systemName: "arrow.up.right")
                                .foregroundColor(.white)
                                .font(.system(size: 18, weight: .medium))
                            
                        }
                        .padding()
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(RoundedRectangle(cornerRadius: 30).fill(Color.white.opacity(0.05)))
                    })
                    .padding(.bottom, 60)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color("bg")))
                .offset(y: viewModel.isSettings ? 0 : UIScreen.main.bounds.height)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .ignoresSafeArea()

            }
        )
    }
}

#Preview {
    DiaryView()
}
