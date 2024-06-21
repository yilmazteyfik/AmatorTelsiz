//
//  File.swift
//  AmatorTelsiz
//
//  Created by Teyfik Yılmaz on 28.04.2024.
//

import Foundation
import RealmSwift


class Question : Object{
    @objc dynamic var question = ""
    var options = List<String>()
    @objc dynamic var answer = ""
    
    convenience init(question: String, options: [String], answer: String) {
        self.init()
        self.question = question
        self.options.append(objectsIn: options)
        self.answer = answer
    }
               
}

func deleteQuestion(question: Question) {
    let realm = try! Realm()
    try! realm.write {
        realm.delete(question)
    }
}
func convertResultsToArray(results: Results<Question>?) -> [Question] {
    guard let results = results else { return [] }
    return Array(results)
}
