//
//  ClassesListView.swift
//  MCourses2
//
//  Created by Ishani Das on 4/4/24.
//

import Foundation
import SwiftUI

class Course {
    let rating : Double
    let workload : String
    let name : String
    
    let department : String
    let credits: Int
    
    init(rating : Double, workload : String, name : String, department : String, credits: Int){
        self.rating = rating
        self.workload = workload
        self.name = name
        
        self.department = department
        self.credits = credits
    }
}

// we can later replace this manualy-created courses when we pull data from the database
let eecs183 = Course(rating: 0.83, workload: "Low", name: "EECS 183: Elementary Programming Concepts", department: "EECS", credits: 4)
let eecs203 = Course(rating: 0.39, workload: "Moderate", name: "EECS 203: Discrete Math", department: "EECS", credits: 4)
let eecs280 = Course(rating: 0.85, workload: "Moderate", name: "EECS 280: Programming and Introductory Data Structures", department: "EECS", credits: 4)
let eecs281 = Course(rating: 0.84, workload: "High", name: "EECS 281: Data Structures and Algorithms", department: "EECS", credits: 4)

let courses_list = [eecs183, eecs203, eecs280, eecs281]

struct ClassesListView: View {
    
    var body: some View {
        
        VStack {
            /*
            Image(systemName: "globe")
            .imageScale(.large)
            .foregroundStyle(.tint)
            Text("Hello, world!")
             */
            
            /*
            ForEach(courses_list, id: \.name) {
                course in Text(course.name)
        
            */
            ForEach(courses_list, id: \.name) { course in
                VStack{
                    Text("Name: \(course.name)")
                    Text("Course Department: \(course.department)")
                    Text("Credits: \(course.credits)")
                    
                    Text("Workload: \(course.workload)")
                    Text("Rating: \(course.rating )")
                }.frame(maxWidth: .infinity).background(Color(UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)))// .frame(maxWidth: .infinity)//.background(Color.gray)
                //Spacer()
            }
            
        }
    }
}

/*
 #Preview {
 ClassesListView()
 }
 */
struct ClassesListView_Previews: PreviewProvider {
    static var previews: some View {
        ClassesListView()
    }
}
