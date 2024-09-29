//
//  TranslateView.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/19/24.
//

import SwiftUI

struct TranslateView: View {
    
    @State private var previousText: String = ""
    @State private var afterText: String = ""
    
    @StateObject private var viewModel = TranslateViewModel()
    
    var body: some View {

        ZStack {
            
            VStack(spacing: 0) {
                
                Rectangle()
                    .fill(.orange.opacity(0.05))
                    .overlay {
                        CustomTextEditor(text: $previousText, placeholder: "Enter some text")
                            .padding([.top, .horizontal], 25)
                            .padding(.bottom, 80)
                    }
                
                Rectangle()
                    .fill(.gray.opacity(0.5))
                    .frame(height: 1)
                
                Rectangle()
                    .fill(.white)
                    .overlay(alignment: .topLeading) {
                        Text(viewModel.output.translatedText)
                            .padding(.top, 80)
                            .padding(.horizontal, 35)
                    }
            }
            
            middleItemView()
            
        }
        .navigationTitle("Translate")
            
    }
    
    func middleItemView() -> some View {
        
        HStack {
            VStack {
                Text("한국어")
                    .foregroundStyle(.black)
                Button(action: {
                    viewModel.input.inputText.send(previousText) //
                }, label: {
                    Circle()
                        .fill(.blue)
                        .frame(width: 40, height: 40)
                        .overlay {
                            Image(systemName: "star")
                        }
                })
                .padding(.vertical, 10)
                .padding(.horizontal, 16)
                
                Text("English")
                    .foregroundStyle(.black)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            Button(action: {
                
            }, label: {
                Image(systemName: "speaker.wave.2")
                    .foregroundStyle(.black)
            })
            .padding(.top, 100)

        
        }
        .padding(.horizontal, 20)
        
    }

}

#Preview {
    TranslateView()
}
