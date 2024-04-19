//
//  SwiftUIView.swift
//  MCourses
//
//  Created by Finn Moore on 11/16/23.
//

import SwiftUI
import Firebase

struct CourseView: View {
    @ObservedObject var courseViewModel: CourseViewModel
    
    // Colors
    let maize = Color(red: 1, green: 0.796, blue: 0.02)
    let blue = Color(red: 0, green: 0.153, blue: 0.298)
    
    init(course: Course) {
        self.courseViewModel = CourseViewModel(course: course)
    }
    
    var body: some View {
       ScrollView {
            header
            description
            score
            statistics
            writeReviewButton
            reviewView
        }
       .refreshable {
           Task { @MainActor in
               try await self.courseViewModel.fetchReviews()
           }
       }
       .ignoresSafeArea()
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
            if courseViewModel.course.avgRating != -1.0 {
                Text("\(courseViewModel.course.avgRating, specifier: "%.1f")/10")
                    .font(.title)
                    .bold()
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 1, green: 0.8, blue: 0.02))
            } else {
                Text("No course ratings")
                    .font(.title)
                    .bold()
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 1, green: 0.8, blue: 0.02))
            }
        }
        .padding(.horizontal, 32)
        .padding(.vertical, 16)
        .background(Color(red: 0, green: 0.15, blue: 0.3))
        .cornerRadius(16)
    }
    
    var statistics: some View {
        
        VStack(alignment: .leading) {
            if courseViewModel.course.avgRating != -1.0 {
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
            } else {
                Text("No available statistics").font(.title).bold()
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
                NavigationLink(destination: MakeReviewView(courseViewModel: courseViewModel)) {
                    Text("Write Review")
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                        .padding()
                        .background(maize, in: RoundedRectangle(cornerRadius: 10))
                        .padding()
                }
            }
    }
    
    var reviewView: some View {
        VStack(alignment: .leading) {
            Text("Reviews")
                .font(.largeTitle)
                .bold()
            ScrollView {
                ForEach(courseViewModel.reviews) { review in
                    ReviewRow(review: review)
                }
            }
        }
        .padding(10)
    }
}

struct ReviewRow: View {
    let review: Review
    
    var body: some View{
        VStack (spacing: 30){
            HStack() {
                Text("\(review.semester)")
                Spacer()
                Text("\(review.professor)")
                Spacer()
                Text("Rating: \(review.rating, specifier: "%.1f")")
            }
            .bold()
            
            Text("\(review.review)")
            
            HStack(alignment: .lastTextBaseline) {
                VStack() {
                    Text("Workload: \(Int(review.workload * 10))%")
                    Text("Worth it: \(Int(review.worth * 10))%")
                    Text("Enjoyment: \(Int(review.enjoyment * 10))%")
                }
                .bold()
                Spacer()
                UpVotes(count: 1)
            }
        }
        .padding(.vertical, 10)
        .background(Color.gray.brightness(0.4))
        .padding(.bottom, 5) // margin
    }
}


// TODO: retrieve count from database
struct UpVotes: View {
    @State var count:Int
    
    var body: some View {
        ZStack {
            ZStack() {
                Rectangle()
                .foregroundColor(.clear)
                .frame(width: 70, height: 30)
                .background(Color(red: 0, green: 0.15, blue: 0.3))
                .cornerRadius(20)
                
                HStack(){
                    Image(systemName: "arrow.up")
                        .onTapGesture{
                            count += 1 // TODO: make sure user can only vote once
                        }
                    
                    Text("\(count)")
                    
                    Image(systemName: "arrow.down")
                        .onTapGesture{
                            count -= 1
                        }
                        .foregroundColor(.yellow)
                        .disabled(count <= 0)
                }
                .foregroundColor(.white)
            }
        }
        .ignoresSafeArea()
    }
}



// -------- Temporary Variables for Testing ---------

let sampleReview1 = Review(
    id: "1",
    timestamp: Timestamp(date: Date()),
    semester: "Winter 2023",
    professor: "Jonathan Beaumont",
    review: "Enrolling in this course was a transformative experience that exceeded my expectations. The curriculum was well-structured, offering a comprehensive overview of the subject matter while delving deep into key concepts. The instructors demonstrated exceptional expertise, providing clear explanations and real-world applications that enhanced my understanding.",
    rating: 9.8,
    workload: 58,
    worth: 40,
    enjoyment: 61,
    votes: 6
)

let sampleReview2 = Review(
    id: "2",
    timestamp: Timestamp(date: Date()),
    semester: "Fall 2023",
    professor: "Emily Graetz",
    review: "Enrolling in this course was a transformative experience that exceeded my expectations. The curriculum was well-structured, offering a comprehensive overview of the subject matter while delving deep into key concepts. The instructors demonstrated exceptional expertise, providing clear explanations and real-world applications that enhanced my understanding.",
    rating: 8,
    workload: 50,
    worth: 20,
    enjoyment: 100,
    votes: 10
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
