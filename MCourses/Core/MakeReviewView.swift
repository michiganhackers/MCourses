//
//  MakeReviewView.swift
//  MCourses
//
//  Created by Daniel Reiffer on 11/16/23.
//

import SwiftUI
import Firebase

struct MakeReviewView: View {
    @ObservedObject var courseViewModel: CourseViewModel
    @State private var term: String = ""
    @State private var professor: String = ""
    @State private var rating: String = ""
    @State private var workload: String = ""
    @State private var worth: String = ""
    @State private var enjoyment: String = ""
    @State private var review: String = ""
    @State private var semester: String = ""
    
    private let courseService = CourseService()
    var body: some View {
        VStack(spacing: 0) {
            VStack {
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
                            Text(courseViewModel.course.name)
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
//                    FormSelectItem(label: "Term taken", example: "WN 2024", text: $term, selectionArray: ["Cranberry", "Grape", "Banana", "Strawberry"])
                    FormTextItem(label: "Term", example: "WN24", text: $semester)
                    FormTextItem(label: "Professor taken with", example: "Jonathon Beaumont", text: $professor)
                    FormTextItem(label: "Rating", example: "Scale of 1-10", text: $rating)
                    FormTextItem(label: "Workload", example: "Scale of 0-100", text: $workload)
                    FormTextItem(label: "Worth it", example: "Scale of 0-100", text: $worth)
                    FormTextItem(label: "Enjoyment", example: "Scale of 0-100", text: $enjoyment)
                    FormTextItem(label: "Review", example: "Write your review here", text: $review)
                    Spacer()
                    Button(action: {
                        Task {
                            try await courseService.reviewCourse(course: courseViewModel.course, review: Review(id: UUID().uuidString, timestamp: Timestamp(date: Date()), semester: semester, professor: professor, review: review, rating: Double(rating)!, workload: Double(workload)! / 10.0, worth: Double(worth)! / 10.0, enjoyment: Double(enjoyment)! / 10.0, votes: 0))
                        }
                    }) {
                        Text("Submit")
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 44) // Give the button a fixed height and make it expand horizontally
                            .background(Color.umBlue)
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .bold, design: .default))
                            .cornerRadius(8) // Rounded corners
                    }
                    .padding()
                }
            }
            .padding(16)
        }
    }
}

struct FormSelectItem: View {
    var label: String
    var example: String
    @Binding var text: String
    var selectionArray: Array<String>
    @State private var toggled: Bool = false
    @State private var selected: String = ""
    
    var body: some View {
        HStack {
            Text(label)
                .font(Font.custom("SF Pro Text", size: 11))
                .kerning(0.066)
                .foregroundColor(.black)
            Spacer()
        }
        HStack {
            Button {
                // TODO: insert action here
                self.toggled = true
            } label: {
                if (!toggled) {
                    // TODO: if $text has some value, show that instead
                    Text(example)
                        .font(Font.custom("SF Pro Text", size: 11))
                        .kerning(0.066)
                        .foregroundColor(Color(red: 0.6, green: 0.61, blue: 0.59))
                    Spacer()
                    // TODO: show dropdown icon
                } else {
                    VStack {
                        // TODO: show picker
                        
                        HStack {
                            Spacer()
                            // TODO: show dropUP icon
                        }
                    }
                    .padding(1)
                }
            }
            .padding(1)
        }
        Rectangle()
            .fill(Color.black)
            .frame(height: 1)
            .padding(.bottom, 10)
    }
}

struct FormTextItem: View {
    var label: String
    var example: String
    @Binding var text: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(Font.custom("SF Pro Text", size: 11))
                .kerning(0.066)
                .foregroundColor(.black)
            Spacer()
        }
        HStack {
            TextField(
                example,
                text: $text
            )
            .font(Font.custom("SF Pro Text", size: 11))
            .kerning(0.066)
            .foregroundColor(Color(red: 0.6, green: 0.61, blue: 0.59))
        }
        Rectangle()
            .fill(Color.black)
            .frame(height: 1)
            .padding(.bottom, 10)
    }
}

#Preview {
    MakeReviewView(courseViewModel: CourseViewModel(course: sampleCourse))
}
