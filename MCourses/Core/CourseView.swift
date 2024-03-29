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
    
    var body: some View {
        VStack() {
            header
            reviewPage
        }
    }
    
    var header: some View {
        VStack {
            ZStack {
                Rectangle()
                    .frame(height: 200.0)
                    .foregroundColor(blue)
                Text(courseViewModel.course.name)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
            }
            .ignoresSafeArea()
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
            .offset(y:-50)
        }
    }
    
    var reviewPage: some View {
        VStack(alignment: .leading) {
            Text("Reviews")
                .font(.largeTitle)
                .bold()
            ScrollView (){
                ForEach(courseViewModel.course.reviews) { review in
                    VStack (spacing: 30){
                        HStack (){
                            Text("\(review.semester)")
                            Spacer()
                            Text("\(review.professor)")
                            Spacer()
                            Text("\(review.rating)")
                        }
                        .bold()
                        
                        Text("\(review.review)")
                        
                    }
                }
            }
            .background(Color.gray.brightness(0.40))
        }
//        .padding(0)
//        .frame(maxWidth: .infinity)
    }
}

// -------- Temporary Variables for Testing ---------

let sampleReview1 = Review(
    id: "1",
    course: "Data Structures and Algorithms",
    semester: "Winter 2023",
    professor: "Jonathan Beaumont",
    review: "Enrolling in this course was a transformative experience that exceeded my expectations. The curriculum was well-structured, offering a comprehensive overview of the subject matter while delving deep into key concepts. The instructors demonstrated exceptional expertise, providing clear explanations and real-world applications that enhanced my understanding.",
    rating: 9.8,
    workload: 58,
    worth: 40,
    enjoyment: 61,
    upvote: 6
)

let sampleReview2 = Review(
    id: "2",
    course: "Data Structures and Algorithms",
    semester: "Fall 2023",
    professor: "Emily Graetz",
    review: "Hello World",
    rating: 8,
    workload: 50,
    worth: 20,
    enjoyment: 100,
    upvote: 10
)

let sampleCourse = Course(
    name: "Data Structures and Algorithms",
    department: "EECS",
    number: 281,
    credits: 4,
    description: "Introduction to the algorithm analysis and O-notation; Fundamental data structures including lists, stacks, queues, priority queues, hash tables, binary trees, search trees, balanced, trees, and graphs; searching and sorting algorithms; recursive algorithms; basic graph algorithms; introduction to greedy algorithms and divide and conquer strategy. Several programming assignments.",
    avgRating: 4.5,
    avgWorkload: 6.8,
    avgWorth: 7.7,
   avgEnjoyment: 3.4,
   reviews: [sampleReview1, sampleReview2])


// --------------------- end -------------------------

#Preview {
    CourseView(course: sampleCourse)
}
