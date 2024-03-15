//
//  MakeReviewView.swift
//  MCourses
//
//  Created by Daniel Reiffer on 11/16/23.
//

import SwiftUI

struct MakeReviewView: View {
    @State private var term: String = ""
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                VStack {
                    Spacer()
                        .frame(height: 8)
                    HStack {
                        Image(systemName: "chevron.backward")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 11)
                            .foregroundColor(Color.white)
                            .padding(.leading, 20)
                            .padding(.bottom)
                        Spacer()
                    }
                }
            }
            .background(Color.umBlue)
            VStack { //scroll view content
                VStack() { //header content
                    HStack {
                        Text("Your review")
                            .font(.largeTitle.weight(.bold))
                            .foregroundColor(Color.white)
                            .padding(.leading)
                        Spacer()
                    }
                    ZStack {
                        VStack(spacing:0) {
                            Rectangle()
                                .frame(height:18)
                                .foregroundColor(Color.umBlue)
                            Rectangle()
                                .frame(height: 18)
                                .foregroundColor(Color.white)
                        }
                        HStack(spacing: 8) {
                            Text("EECS 388: Introduction to Security")
                                .padding(8)
                                .foregroundColor(Color.black)
                                .font(
                                    Font.custom("SF Pro Text", size: 13)
                                    .weight(.semibold)
                                )
                                .background(Color.umMaize)
                                .cornerRadius(8)
                            Spacer()
                        }
                        .padding(.leading, 32)
                    }
                }
                .background(Color.umBlue)
            }
            ScrollView {
                VStack {
                    HStack {
                        Text("Term taken")
                            .font(Font.custom("SF Pro Text", size: 11))
                            .kerning(0.066)
                            .foregroundColor(.black)
                        Spacer()
                    }
                    HStack {
                        TextField(
                            "ex. WN 2024",
                            text: $term
                        )
                        .font(Font.custom("SF Pro Text", size: 11))
                        .kerning(0.066)
                        .foregroundColor(Color(red: 0.6, green: 0.61, blue: 0.59))
                    }
                }
            }
            .padding(16)
            Spacer()
        }
    }
}

#Preview {
    MakeReviewView()
}
