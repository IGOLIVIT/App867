//
//  AddPlan.swift
//  App867
//
//  Created by IGOR on 30/08/2024.
//

import SwiftUI

struct AddPlan: View {

    @StateObject var viewModel: PlanViewModel
    
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
                                .opacity(viewModel.plTitle.isEmpty ? 1 : 0)
                            
                            TextField("", text: $viewModel.plTitle)
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
                                
                                DatePicker("", selection: $viewModel.plDate, displayedComponents: .date)
                                    .labelsHidden()
                                    .padding(10)
                                    .frame(maxWidth: .infinity)
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.05)))
                            }

                        Text("Description")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .medium))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ZStack(alignment: .leading, content: {
                            
                            Text("Text")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.plDescr.isEmpty ? 1 : 0)
                            
                            TextField("", text: $viewModel.plDescr)
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
                    
                    VStack {
                        
                        Text("Ingredients")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .medium))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ZStack(alignment: .leading, content: {
                            
                            Text("Text")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.plIng.isEmpty ? 1 : 0)
                            
                            TextField("", text: $viewModel.plIng)
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
                    
                    viewModel.plType = viewModel.currentType
                    
                    viewModel.addPlan()
                    
                    viewModel.plTitle = ""
                    viewModel.plDescr = ""
                    viewModel.plIng = ""
                    
                    viewModel.fetchPlans()

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
                .opacity(viewModel.plTitle.isEmpty || viewModel.plDescr.isEmpty || viewModel.plIng.isEmpty ? 0.5 : 1)
                .disabled(viewModel.plTitle.isEmpty || viewModel.plDescr.isEmpty || viewModel.plIng.isEmpty ? true : false)
            }
            .padding()
        }
    }
}

#Preview {
    AddPlan(viewModel: PlanViewModel())
}
