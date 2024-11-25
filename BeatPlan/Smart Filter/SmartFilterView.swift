//
//  SmartFilterView.swift
//  BeatPlan
//
//  Created by Mayur Tyagi on 25/11/24.
//

import SwiftUI

struct SmartFilterView: View {
    @State private var searchedText = ""
    var filtersSelectedHandler: (Int) -> ()
    @State private var selectedIndex: Int = 0
    @State private var subselectedIndices: [Int] = []
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Apply Filters")
                .font(.system(size: 20, weight: .semibold))
                .padding()
            GeometryReader{ geometry in
                HStack(spacing: 0){
                    ScrollView(showsIndicators: false){
                        ForEach(0..<50){ itemIndex in
                            HStack{
                                if itemIndex == selectedIndex{
                                    Rectangle()
                                        .frame(width: 5)
                                        .foregroundStyle(.blue)
                                        .clipShape(.rect(bottomTrailingRadius: 8, topTrailingRadius: 8))
                                }
                                
                                Text("Field \(itemIndex)")
                                    .fontWeight(itemIndex == selectedIndex ? .medium : .regular)
                                    .padding()
                                
                                Spacer()
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation{
                                    selectedIndex = itemIndex
                                }
                            }
                        }
                    }
                    .frame(width: geometry.size.width * 0.4)
                    
                    Rectangle()
                        .frame(width: 2)
                        .foregroundStyle(.gray.opacity(0.5))
                    VStack(spacing: 0){
                        if true{
                            TextField(text: $searchedText, label: {
                                Text("Search here")
                            })
                            .padding(.horizontal)
                            .textFieldStyle(RoundedTextFieldStyle(text: searchedText, innerBackgroundColor: .gray.opacity(0.2), showBorder: false))
                            
                        }
                        
                        List(){
                            ForEach(0..<50){ itemIndex in
                                HStack{
                                    Image(subselectedIndices.contains(itemIndex) ? "checkedBox" : "unCheckedBox")
                                    Text("option \(itemIndex)")
                                    Spacer()
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    if subselectedIndices.contains(itemIndex){
                                        subselectedIndices.remove(at: subselectedIndices.firstIndex(where: {$0 == itemIndex})!)
                                    }else{
                                        subselectedIndices.append(itemIndex)
                                    }
                                }
                            }
                        }
                        .listRowSpacing(0)
                        .scrollIndicators(.hidden)
                        .listStyle(.plain)
                    }
                }
            }
            
            Button{
                filtersSelectedHandler(subselectedIndices.count)
            } label: {
                Text("Apply Filters")
                    .font(.headline)
                    .foregroundStyle(.blue)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.blue, lineWidth: 1.5)
                    }
            }
            .padding()
            .padding(.bottom, 8)
        }
        .ignoresSafeArea(.all)
        .padding(.top)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    SmartFilterView(filtersSelectedHandler: { _ in })
}


