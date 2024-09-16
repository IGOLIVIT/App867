//
//  AddDiary.swift
//  App867
//
//  Created by IGOR on 30/08/2024.
//

import SwiftUI

struct AddDiary: View {

    @StateObject var viewModel: DiaryViewModel
    
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
                                .opacity(viewModel.diTitle.isEmpty ? 1 : 0)
                            
                            TextField("", text: $viewModel.diTitle)
                                .foregroundColor(Color.white)
                                .font(.system(size: 14, weight: .semibold))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.05)))
                        
                        HStack {
                            
                            VStack {
                                
                                Text("Date")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14, weight: .medium))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                DatePicker("", selection: $viewModel.diDate, displayedComponents: .date)
                                    .labelsHidden()
                                    .padding(10)
                                    .frame(maxWidth: .infinity)
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.05)))
                            }
                            
                            VStack {
                                
                                Text("Time")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14, weight: .medium))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                ZStack(alignment: .leading, content: {
                                    
                                    Text("Time")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 14, weight: .regular))
                                        .opacity(viewModel.diTime.isEmpty ? 1 : 0)
                                    
                                    TextField("", text: $viewModel.diTime)
                                        .foregroundColor(Color.white)
                                        .font(.system(size: 14, weight: .semibold))
                                       
                                       })
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.05)))
                            }
                        }
                        
                        Text("Eating")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .medium))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Menu(content: {
                            
                            ForEach(viewModel.eats, id: \.self) { index in
                            
                                Button(action: {
                                    
                                    viewModel.currentEattoAdd = index
                                    
                                }, label: {
 
                                            Text(index)

                            })
                                       }
                            
                        }, label: {
                            
                            if viewModel.currentEattoAdd.isEmpty {
                                
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
                                    
                                    Text(viewModel.currentEattoAdd)
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
                                .opacity(viewModel.diDescr.isEmpty ? 1 : 0)
                            
                            TextField("", text: $viewModel.diDescr)
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
                                .opacity(viewModel.diIng.isEmpty ? 1 : 0)
                            
                            TextField("", text: $viewModel.diIng)
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
                    
                    viewModel.diEat = viewModel.currentEattoAdd
                    
                    viewModel.addDiary()
                    
                    viewModel.diTitle = ""
                    viewModel.diTime = ""
                    viewModel.diDescr = ""
                    viewModel.diIng = ""
                    
                    viewModel.fetchDiaries()

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
                .opacity(viewModel.diTitle.isEmpty || viewModel.diDescr.isEmpty || viewModel.currentEattoAdd.isEmpty ? 0.5 : 1)
                .disabled(viewModel.diTitle.isEmpty || viewModel.diDescr.isEmpty || viewModel.currentEattoAdd.isEmpty ? true : false)
            }
            .padding()
        }
    }
}

#Preview {
    AddDiary(viewModel: DiaryViewModel())
}
