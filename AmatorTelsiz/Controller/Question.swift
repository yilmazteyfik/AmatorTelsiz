//
//  File.swift
//  AmatorTelsiz
//
//  Created by Teyfik Yılmaz on 28.04.2024.
//

import Foundation


struct Question {
    let question : String
    let options : [String]
    let answer : String
    func hash(into hasher: inout Hasher) {
        hasher.combine(question)
        hasher.combine(options)
        hasher.combine(answer)
    }
    
    static func == (lhs: Question, rhs: Question) -> Bool {
        return lhs.question == rhs.question && lhs.options == rhs.options &&
        lhs.answer == rhs.answer
    }
               
}
