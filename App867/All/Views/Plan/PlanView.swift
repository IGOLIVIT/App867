//
//  PlanView.swift
//  App867
//
//  Created by IGOR on 30/08/2024.
//

import SwiftUI

struct PlanView: View {

    @StateObject var viewModel = PlanViewModel()
    
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
                
                Text("Plan")
                    .foregroundColor(.white)
                    .font(.system(size: 30, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom)
                                
                HStack {
                    
                    ForEach(viewModel.types, id: \.self) { index in
                        
                        Button(action: {
                            
                            viewModel.currentType = index
                            
                        }, label: {
                            
                            Text(index)
                                .foregroundColor(.white)
                                .font(.system(size: 13, weight: .regular))
                                .frame(maxWidth: .infinity)
                                .frame(height: 22)
                                .background(RoundedRectangle(cornerRadius: 7).fill(.gray.opacity(viewModel.currentType == index ? 0.3 : 0)))
                        })
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 25)
                .background(RoundedRectangle(cornerRadius: 7).fill(Color("bg2")))
                
                if viewModel.plans.isEmpty {
                    
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
                            
                            ForEach(viewModel.plans.filter{($0.plType ?? "") == viewModel.currentType}, id: \.self) { index in
                            
                                Button(action: {
                                    
                                    viewModel.selectedPlan = index
                                    
                                    withAnimation(.spring()) {
                                        
                                        viewModel.isDetail = true
                                    }
                                    
                                }, label: {
                                    
                                    HStack {
                                        
                                        VStack {
                                            
                                            Text("\((index.plDate ?? Date()).convertDate(format: "dd"))")
                                                .foregroundColor(Color("prim"))
                                                .font(.system(size: 18, weight: .medium))
                                            
                                            Text("\((index.plDate ?? Date()).convertDate(format: "MMMMM"))")
                                                .foregroundColor(.white)
                                                .font(.system(size: 15, weight: .regular))
                                        }
                                        .padding()
                                        .frame(width: 80)
                                        .frame(maxHeight: .infinity)
                                        .background(RoundedRectangle(cornerRadius: 25.0).fill(Color.white.opacity(0.05)))
                                        
                                        VStack(alignment: .leading, spacing: 8) {
                                            
                                            HStack {
                                                
                                                Text(index.plTitle ?? "")
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 16, weight: .medium))
                                                
                                                Spacer()
                         
                                            }
                                            
                                            Text(index.plDescr ?? "")
                                                .foregroundColor(.gray)
                                                .font(.system(size: 13, weight: .regular))
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
            
            viewModel.fetchPlans()
        }
        .sheet(isPresented: $viewModel.isAdd, content: {
            
            AddPlan(viewModel: viewModel)
        })
        .sheet(isPresented: $viewModel.isDetail, content: {
            
            PlanDetail(viewModel: viewModel)
        })
    }
}

#Preview {
    PlanView()
}
