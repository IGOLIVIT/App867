//
//  DiaryDetail.swift
//  App867
//
//  Created by IGOR on 30/08/2024.
//

import SwiftUI

struct DiaryDetail: View {
    
    @StateObject var viewModel: DiaryViewModel
    @Environment(\.presentationMode) var router
    
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    
                    Button(action: {
                        
                        router.wrappedValue.dismiss()
                        
                    }, label: {
                        
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color("prim"))
                            .font(.system(size: 18, weight: .medium))
                        
                        Text("Back")
                            .foregroundColor(Color("prim"))
                            .font(.system(size: 16, weight: .regular))
                    })
                    
                    Spacer()
                }
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Text(viewModel.selectedDiary?.diTitle ?? "")
                            .foregroundColor(.white)
                            .font(.system(size: 26, weight: .bold))
                        
                        HStack {
                            
                            HStack {
                                
                                Image(systemName: "calendar")
                                    .foregroundColor(Color("prim"))
                                    .font(.system(size: 16, weight: .regular))
                                
                                Text("\((viewModel.selectedDiary?.diDate ?? Date()).convertDate(format: "MMMM,dd"))")
                                    .foregroundColor(.white)
                                    .font(.system(size: 15, weight: .regular))
                                
                            }
                            .padding(6)
                            .padding(.horizontal, 5)
                            .background(RoundedRectangle(cornerRadius: 6).fill(Color.white.opacity(0.05)))
                            
                            Spacer()
                            
                            HStack {
                                
                                Image(systemName: "timer")
                                    .foregroundColor(Color("prim"))
                                    .font(.system(size: 16, weight: .regular))
                                
                                Text(viewModel.selectedDiary?.diTime ?? "")
                                    .foregroundColor(.white)
                                    .font(.system(size: 15, weight: .regular))
                            }
                            .padding(6)
                            .padding(.horizontal, 5)
                            .background(RoundedRectangle(cornerRadius: 6).fill(Color.white.opacity(0.05)))
                            
                        }
                       
                        HStack {
                            
                            Text(viewModel.selectedDiary?.diIng ?? "")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .regular))
                            
                            Spacer()
                        }
                        .padding(6)
                        .padding(.horizontal, 5)
                        .background(RoundedRectangle(cornerRadius: 6).fill(Color.white.opacity(0.05)))
                        
                        Text(viewModel.selectedDiary?.diDescr ?? "")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .regular))
                        

                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                HStack {
                    
                    Button(action: {
                                                
                        withAnimation(.spring()) {
                            
                            viewModel.isDelete = true
                        }
                        
                    }, label: {
                        
                        Text("Delete")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .regular))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(RoundedRectangle(cornerRadius: 15).fill(Color.white.opacity(0.05)))

                    })
                    
                    Button(action: {

                        withAnimation(.spring()) {
                            
                            viewModel.isDetail = false
                        }
                        
                    }, label: {
                        
                        Text("Back")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .regular))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(RoundedRectangle(cornerRadius: 15).fill(Color("prim")))

                    })
                }
            }
            .padding()
        }
        .overlay(
            
            ZStack {
                
                Color.black.opacity(viewModel.isDelete ? 0.5 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isDelete = false
                        }
                    }
                
                VStack {
                    
                    HStack {
                        
                        Spacer()
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isDelete = false
                            }
                            
                        }, label: {
                            
                            Image(systemName: "xmark")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .regular))
                        })
                    }
                    
                    Text("Delete")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .semibold))
                        .padding()
                    
                    Text("Are you sure you want to delete?")
                        .foregroundColor(.gray)
                        .font(.system(size: 14, weight: .regular))
                        .multilineTextAlignment(.center)
                    
                    Button(action: {
                        
                        CoreDataStack.shared.deleteDiary(withDiTitle: viewModel.selectedDiary?.diTitle ?? "", completion: {
                            
                            viewModel.fetchDiaries()
                        })
          
                        withAnimation(.spring()) {
                            
                            viewModel.isDelete = false
                            viewModel.isDetail = false

                        }
                                
                    }, label: {
                        
                        Text("Delete")
                            .foregroundColor(.red)
                            .font(.system(size: 18, weight: .semibold))
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                        
                    })
                    .padding(.top, 25)
                    
                    Button(action: {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isDelete = false
                        }
                        
                    }, label: {
                        
                        Text("Close")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .regular))
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                        
                    })
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color("bg")))
                .padding()
                .offset(y: viewModel.isDelete ? 0 : UIScreen.main.bounds.height)
            }
        )
    }
}

#Preview {
    DiaryDetail(viewModel: DiaryViewModel())
}
