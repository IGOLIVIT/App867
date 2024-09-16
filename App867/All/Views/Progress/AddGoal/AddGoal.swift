//
//  AddGoal.swift
//  App867
//
//  Created by IGOR on 30/08/2024.
//

import SwiftUI

struct AddGoal: View {
    
    @StateObject var viewModel: ProgressViewModel
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Text("Add an entry")
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .medium))
                    .padding()
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing: 12) {
                        
                        Text("Title")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .medium))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ZStack(alignment: .leading, content: {
                            
                            Text("Text")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.gTitle.isEmpty ? 1 : 0)
                            
                            TextField("", text: $viewModel.gTitle)
                                .foregroundColor(Color.white)
                                .font(.system(size: 14, weight: .semibold))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.05)))
                        
                        VStack {
                            
                            Text("Date")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .medium))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            DatePicker("", selection: $viewModel.gDate, displayedComponents: .date)
                                .labelsHidden()
                                .padding(10)
                                .frame(maxWidth: .infinity)
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.05)))
                        }
                        
                        Text("The stage of execution")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .medium))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Menu(content: {
                            
                            ForEach(viewModel.stages, id: \.self) { index in
                                
                                Button(action: {
                                    
                                    viewModel.currentStageToAdd = index
                                    
                                }, label: {
                                    
                                    Text(index)
                                    
                                })
                            }
                            
                        }, label: {
                            
                            if viewModel.currentStageToAdd.isEmpty {
                                
                                HStack {
                                    
                                    Text("Text")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 14, weight: .medium))
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(Color("prim"))
                                        .font(.system(size: 18, weight: .medium))
                                }
                                
                            } else {
                                
                                HStack {
                                    
                                    Text(viewModel.currentStageToAdd)
                                        .foregroundColor(Color.white)
                                        .font(.system(size: 14, weight: .semibold))
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(Color("prim"))
                                        .font(.system(size: 18, weight: .medium))
                                }
                            }
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.05)))
                        
                        Text("Description")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .medium))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ZStack(alignment: .leading, content: {
                            
                            Text("Text")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.gDescr.isEmpty ? 1 : 0)
                            
                            TextField("", text: $viewModel.gDescr)
                                .foregroundColor(Color.white)
                                .font(.system(size: 14, weight: .semibold))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.05)))
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color("bg2")))
                    
                }
                
                Button(action: {
                    
                    viewModel.sumGoals += 1
                    
                    viewModel.gStage = viewModel.currentStageToAdd
                    
                    viewModel.addGoal()
                    
                    viewModel.gTitle = ""
                    viewModel.gDescr = ""
                    viewModel.currentStageToAdd = ""
                    
                    viewModel.fetchGoals()
                    
                    withAnimation(.spring()) {
                        
                        viewModel.isAdd = false
                    }
                    
                }, label: {
                    
                    Text("Save")
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .regular))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 15).fill(Color("prim")))
                    
                })
                .opacity(viewModel.gTitle.isEmpty || viewModel.gDescr.isEmpty || viewModel.currentStageToAdd.isEmpty ? 0.5 : 1)
                .disabled(viewModel.gTitle.isEmpty || viewModel.gDescr.isEmpty || viewModel.currentStageToAdd.isEmpty ? true : false)
            }
            .padding()
        }
    }
}


#Preview {
    AddGoal(viewModel: ProgressViewModel())
}
