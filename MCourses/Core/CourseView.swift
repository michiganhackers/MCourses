//
//  SwiftUIView.swift
//  MCourses
//
//  Created by Finn Moore on 11/16/23.
//

import SwiftUI

struct CourseView: View {
    @ObservedObject var courseViewModel: CourseViewModel
    
    // Colors
    let maize = Color(red: 1, green: 0.796, blue: 0.02)
    let blue = Color(red: 0, green: 0.153, blue: 0.298)
    
    init(course: Course) {
        self.courseViewModel = CourseViewModel(course: course)
    }
    

    
    var header: some View {
        ZStack {
            Rectangle()
                .frame(height: 200.0)
                .foregroundColor(blue)
            VStack{
                Text(courseViewModel.course.name)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                HStack(spacing: 20, content: {
                    Text("\(courseViewModel.course.department) \(courseViewModel.course.number)")
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                        .padding()
                        .background(maize, in: RoundedRectangle(cornerRadius: 10))
                    
                    Text("\(courseViewModel.course.credits) Credits")
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                        .padding()
                        .background(maize, in: RoundedRectangle(cornerRadius: 10))
                })
            }.offset(y:50)
        }
        
    }
    
    var score: some View {
        HStack(alignment: .center, spacing: 10) {
            Text("\(courseViewModel.course.avgRating, specifier: "%.1f")/10")
              .font(.title)
              .bold()
              .multilineTextAlignment(.center)
              .foregroundColor(Color(red: 1, green: 0.8, blue: 0.02))
        }
        .padding(.horizontal, 32)
        .padding(.vertical, 16)
        .background(Color(red: 0, green: 0.15, blue: 0.3))
        .cornerRadius(16)
    }
    
    var statistics: some View {
        VStack(alignment: .leading) {
            Text("Statistics").font(.title).bold()
            Text("Workload").font(.headline).bold()
            ZStack(alignment: .leading) {
                Rectangle()
                  .foregroundColor(.clear)
                  .frame(width: 337, height: 28)
                  .background(Color(red: 0.85, green: 0.85, blue: 0.85))
                  .cornerRadius(32)
                Rectangle()
                  .foregroundColor(.clear)
                  .frame(width: courseViewModel.course.avgWorkload*337/10, height: 28)
                  .background(Color(red: 0, green: 0.15, blue: 0.3))
                  .cornerRadius(22)
                Text("\(Int(courseViewModel.course.avgWorkload*10))%")
                    .font(.caption).bold()
                  .foregroundColor(.white)
                  .offset(x:10)
            }
            Text("Was it worth it?").font(.headline).bold()
            ZStack(alignment: .leading) {
                Rectangle()
                  .foregroundColor(.clear)
                  .frame(width: 337, height: 28)
                  .background(Color(red: 0.85, green: 0.85, blue: 0.85))
                  .cornerRadius(32)
                Rectangle()
                  .foregroundColor(.clear)
                  .frame(width: courseViewModel.course.avgWorth*337/10, height: 28)
                  .background(Color(red: 0, green: 0.15, blue: 0.3))
                  .cornerRadius(22)
                Text("\(Int(courseViewModel.course.avgWorth*10))%")
                    .font(.caption).bold()
                  .foregroundColor(.white)
                  .offset(x:10)
            }
            Text("Enjoyment").font(.headline).bold()
            ZStack(alignment: .leading) {
                Rectangle()
                  .foregroundColor(.clear)
                  .frame(width: 337, height: 28)
                  .background(Color(red: 0.85, green: 0.85, blue: 0.85))
                  .cornerRadius(32)
                Rectangle()
                  .foregroundColor(.clear)
                  .frame(width: courseViewModel.course.avgEnjoyment*337/10, height: 28)
                  .background(Color(red: 0, green: 0.15, blue: 0.3))
                  .cornerRadius(22)
                Text("\(Int(courseViewModel.course.avgEnjoyment*10))%")
                    .font(.caption).bold()
                  .foregroundColor(.white)
                  .offset(x:10)
            }
        }
    }
    // For expandable on tap description
    @State var isViewed = false
    var description: some View {
        Button {
                isViewed.toggle()
        } label: {
            Text("\(courseViewModel.course.description)")
                .font(.body).foregroundColor(.black)
                .multilineTextAlignment(.leading)
                .frame(width: 337, height: isViewed ? nil : 100)
        }.padding()
    }
    
    var writeReviewButton: some View {
        Button {
            // write review
        } label: {
            Text("Write Review")
                .fontWeight(.medium)
                .foregroundColor(.black)
                .padding()
                .background(maize, in: RoundedRectangle(cornerRadius: 10))
                .padding()

                
        }
    }
    
    var body: some View {
        ScrollView {
            header
            description
            score
            statistics
            writeReviewButton
        }
        .ignoresSafeArea()
    }
}

#Preview {
    CourseView(course: Course(name: "Data Structures and Algorithms",
   department: "EECS",
   number: 281,
   credits: 4,
   description: "Introduction to the algorithm analysis and O-notation; Fundamental data structures including lists, stacks, queues, priority queues, hash tables, binary trees, search trees, balanced, trees, and graphs; searching and sorting algorithms; recursive algorithms; basic graph algorithms; introduction to greedy algorithms and divide and conquer strategy. Several programming assignments.",
   avgRating: 4.5,
   avgWorkload: 6.8,
   avgWorth: 7.7,
  avgEnjoyment: 3.4,
  reviews: []))
}
