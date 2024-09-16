//
//  ProgView.swift
//  App867
//
//  Created by IGOR on 16/09/2024.
//

import SwiftUI

struct ProgView: View {

    @StateObject var viewModel = ProgressViewModel()
    
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
                
                Text("Progress")
                    .foregroundColor(.white)
                    .font(.system(size: 30, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                                    
                Button(action: {
                    
                    withAnimation(.spring()) {
                        
                        viewModel.isControl = true
                    }
                    
                }, label: {
                    
                    HStack {
                        
                        VStack {
                            
                            Text("\(viewModel.sumGoals)")
                                .foregroundColor(Color("prim"))
                                .font(.system(size: 18, weight: .medium))
                            
                            Text("Goals")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .regular))
                            
                        }
                        .padding()
                        .frame(width: 80)
                        .frame(maxHeight: .infinity)
                        .background(RoundedRectangle(cornerRadius: 25.0).fill(Color.white.opacity(0.05)))
                        
                        VStack(alignment: .leading) {
                            
                            HStack {
                                
                                Image("weight")
                                
                                VStack(alignment: .leading) {
                                    
                                    Text("\(viewModel.weight)")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16, weight: .semibold))

                                    Text("Weight")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 13, weight: .medium))
                                }
                            }
                            
                            HStack {
                                
                                Image("age")
                                
                                VStack(alignment: .leading) {

                                    Text("\(viewModel.Age)")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16, weight: .semibold))

                                    Text("Age")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 13, weight: .medium))
                                }
                            }
                            
                        }
                        .frame(maxWidth: .infinity)
                        
                        VStack(alignment: .leading) {
                            
                            HStack {
                                
                                Image("wu")
                                
                                VStack(alignment: .leading) {
                                    
                                    Text("\(viewModel.WU)")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16, weight: .semibold))
                                    
                                    Text("Wake up")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 13, weight: .medium))
                                }
                            }
                            
                            HStack {
                                
                                Image("fat")
                                
                                VStack(alignment: .leading) {

                                    Text("\(viewModel.fat)")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16, weight: .semibold))

                                    Text("% of fat")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 13, weight: .medium))
                                }
                            }
                            
                        }
                        .frame(maxWidth: .infinity)

                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 130)
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color("bg2")))
                })

                HStack {
                    
                    HStack {
                        
                        VStack(alignment: .leading) {
                            
                            Text("\(viewModel.WS)")
                                .foregroundColor(Color("prim"))
                                .font(.system(size: 26, weight: .semibold))
                            
                            Text("days without sugar")
                                .foregroundColor(.gray)
                                .font(.system(size: 15, weight: .medium))
                                .frame(width: 120)
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 110)
                    .background(Image("tbg").resizable().cornerRadius(15))
                    
                    HStack {
                        
                        VStack(alignment: .leading) {
                            
                            Text("\(viewModel.PN)")
                                .foregroundColor(Color("prim"))
                                .font(.system(size: 26, weight: .semibold))
                            
                            Text("days of proper nutrition")
                                .foregroundColor(.gray)
                                .font(.system(size: 15, weight: .medium))
                                .frame(width: 120)
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 110)
                    .background(Image("thbg").resizable().cornerRadius(15))
                    
                }
                
                Text("Goals")
                    .foregroundColor(.white)
                    .font(.system(size: 30, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    
                    ForEach(viewModel.stages, id: \.self) { index in
                        
                        Button(action: {
                            
                            viewModel.currentStage = index
                            
                        }, label: {
                            
                            Text(index)
                                .foregroundColor(.white)
                                .font(.system(size: 13, weight: .regular))
                                .frame(maxWidth: .infinity)
                                .frame(height: 22)
                                .background(RoundedRectangle(cornerRadius: 7).fill(.gray.opacity(viewModel.currentStage == index ? 0.3 : 0)))
                        })
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 25)
                .background(RoundedRectangle(cornerRadius: 7).fill(Color("bg2")))
                
                if viewModel.goals.isEmpty {
                    
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
                            
                            ForEach(viewModel.goals.filter{($0.gStage ?? "") == viewModel.currentStage}, id: \.self) { index in
                            
                                Button(action: {
                                    
                                    viewModel.selectedGoal = index
                                    
                                    withAnimation(.spring()) {
                                        
                                        viewModel.isDetail = true
                                    }
                                    
                                }, label: {
                                    
                                    VStack(alignment: .leading, spacing: 8) {
                                        
                                        HStack {
                                            
                                            VStack {
                                                
                                                Text("\((index.gDate ?? Date()).convertDate(format: "dd"))")
                                                    .foregroundColor(Color("prim"))
                                                    .font(.system(size: 18, weight: .medium))
                                                
                                                Text("\((index.gDate ?? Date()).convertDate(format: "MMM"))")
                                                    .foregroundColor(Color("prim"))
                                                    .font(.system(size: 18, weight: .medium))
                                            }
                                            .frame(maxHeight: .infinity)
                                            .frame(width: 70)
                                            .background(RoundedRectangle(cornerRadius: 15).fill(Color.white.opacity(0.1)))
                                            
                                            VStack(spacing: 5) {
                                                
                                                Text(index.gTitle ?? "")
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 16, weight: .medium))
                                                
                                                Text(index.gDescr ?? "")
                                                    .foregroundColor(.gray)
                                                    .font(.system(size: 14, weight: .regular))
                                                
                                                Spacer()
                                            }
                                            .padding(.vertical)
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
        .overlay(
            
            ZStack {
                
                Color.black.opacity(viewModel.isControl ? 0.5 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isControl = false
                        }
                    }
                
                VStack {
                    
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.white.opacity(0.1))
                        .frame(width: 40, height: 3)
                    
                    Text("Progress")
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .semibold))
                        .padding()

                    VStack(spacing: 12) {
                        
                        HStack {
                            
                            VStack(alignment: .leading) {
                                
                                Text("Weight")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14, weight: .medium))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                ZStack(alignment: .leading, content: {
                                    
                                    Text("0 Kg")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 14, weight: .regular))
                                        .opacity(viewModel.addWeight.isEmpty ? 1 : 0)
                                    
                                    TextField("", text: $viewModel.addWeight)
                                        .foregroundColor(Color.white)
                                        .font(.system(size: 14, weight: .semibold))
                                    
                                })
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.05)))
                                
                            }
                            
                            VStack(alignment: .leading) {
                                
                                Text("% of fat")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14, weight: .medium))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                ZStack(alignment: .leading, content: {
                                    
                                    Text("%")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 14, weight: .regular))
                                        .opacity(viewModel.addFat.isEmpty ? 1 : 0)
                                    
                                    TextField("", text: $viewModel.addFat)
                                        .foregroundColor(Color.white)
                                        .font(.system(size: 14, weight: .semibold))
                                    
                                })
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.05)))
                            }
                        }
                        
                        HStack {
                            
                            VStack(alignment: .leading) {
                                
                                Text("Wake up")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14, weight: .medium))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                ZStack(alignment: .leading, content: {
                                    
                                    Text("Enter")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 14, weight: .regular))
                                        .opacity(viewModel.addWU.isEmpty ? 1 : 0)
                                    
                                    TextField("", text: $viewModel.addWU)
                                        .foregroundColor(Color.white)
                                        .font(.system(size: 14, weight: .semibold))
                                    
                                })
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.05)))
                                
                            }
                            
                            VStack(alignment: .leading) {
                                
                                Text("Age")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14, weight: .medium))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                ZStack(alignment: .leading, content: {
                                    
                                    Text("Age")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 14, weight: .regular))
                                        .opacity(viewModel.addAge.isEmpty ? 1 : 0)
                                    
                                    TextField("", text: $viewModel.addAge)
                                        .foregroundColor(Color.white)
                                        .font(.system(size: 14, weight: .semibold))
                                    
                                })
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.05)))
                            }
                        }
                        
                        HStack {
                            
                            VStack(alignment: .leading) {
                                
                                Text("Days without sugar")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14, weight: .medium))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                ZStack(alignment: .leading, content: {
                                    
                                    Text("Enter")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 14, weight: .regular))
                                        .opacity(viewModel.addWS.isEmpty ? 1 : 0)
                                    
                                    TextField("", text: $viewModel.addWS)
                                        .foregroundColor(Color.white)
                                        .font(.system(size: 14, weight: .semibold))
                                    
                                })
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.05)))
                                
                            }
                            
                            VStack(alignment: .leading) {
                                
                                Text("Days of proper nutrition")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14, weight: .medium))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                ZStack(alignment: .leading, content: {
                                    
                                    Text("Age")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 14, weight: .regular))
                                        .opacity(viewModel.addPN.isEmpty ? 1 : 0)
                                    
                                    TextField("", text: $viewModel.addPN)
                                        .foregroundColor(Color.white)
                                        .font(.system(size: 14, weight: .semibold))
                                    
                                })
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.05)))
                            }
                        }

                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 25.0).fill(Color("bg2")))
                    
                    Button(action: {
                        
                        viewModel.Age = viewModel.addAge
                        viewModel.fat = viewModel.addFat
                        viewModel.WU = viewModel.addWU
                        viewModel.weight = viewModel.addWeight
                        viewModel.WS = viewModel.addWS
                        viewModel.PN = viewModel.addPN
                        
                        viewModel.addAge = ""
                        viewModel.addWeight = ""
                        viewModel.addWU = ""
                        viewModel.addWeight = ""
                        viewModel.addWS = ""
                        viewModel.addPN = ""
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isControl = false
                        }
                        
                    }, label: {
                        
                        Text("Save")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .regular))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(RoundedRectangle(cornerRadius: 15).fill(Color("prim")))
                        
                    })
                    .padding(.bottom, 60)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color("bg3")))
                .offset(y: viewModel.isControl ? 0 : UIScreen.main.bounds.height)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .ignoresSafeArea()

            }
        )
        .onAppear  {
            
            viewModel.fetchGoals()
        }
        .sheet(isPresented: $viewModel.isAdd, content: {
            
            AddGoal(viewModel: viewModel)
        })
        .sheet(isPresented: $viewModel.isDetail, content: {
            
            GoalDetail(viewModel: viewModel)
        })
    }
}

#Preview {
    ProgView()
}
