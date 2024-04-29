//
//  c_question.swift
//  AmatorTelsiz
//
//  Created by Teyfik Yılmaz on 29.04.2024.
//

import Foundation


class c_questions: NSObject {

    var questionManager = QuestionManager()

    override init() {
        super.init()
    }

    func getCIsletmeQuestions() -> [Question] {
        var questions = [Question]() // Diziyi saklamak için questions adında bir değişken tanımla

        guard let jsonData = QuestionManager.readJSONFromFile(filename: "c_isletme") else {
            fatalError("Failed to read JSON file.")
        }
        do {
            let jsonArray = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [[String: Any]]

            for jsonObject in jsonArray {
                guard let questionText = jsonObject["question"] as? String,
                      let options = jsonObject["options"] as? [String],
                      let answer = jsonObject["answer"] as? String
                else {
                    fatalError("Failed to parse JSON.")
                }

                let question = Question(question: questionText, options: options, answer: answer)
                questions.append(question)
            }

            // Optional: Questions dizisini yazdırabilirsiniz
            for (index, question) in questions.enumerated() {
                print("Question \(index + 1): \(question.question)")
                print("Options: \(question.options)")
                print("Answer  \(question.answer)")
            }
        } catch {
            fatalError("Error while parsing JSON: \(error.localizedDescription)")
        }

        return questions
    }
    func getCTecQuestions() -> [Question] {
        var questions = [Question]() // Diziyi saklamak için questions adında bir değişken tanımla

        guard let jsonData = QuestionManager.readJSONFromFile(filename: "c_tec") else {
            fatalError("Failed to read JSON file.")
        }
        do {
            let jsonArray = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [[String: Any]]

            for jsonObject in jsonArray {
                guard let questionText = jsonObject["question"] as? String,
                      let options = jsonObject["options"] as? [String],
                      let answer = jsonObject["answer"] as? String
                else {
                    fatalError("Failed to parse JSON.")
                }

                let question = Question(question: questionText, options: options, answer: answer)
                questions.append(question)
            }

            // Optional: Questions dizisini yazdırabilirsiniz
            for (index, question) in questions.enumerated() {
                print("Question \(index + 1): \(question.question)")
                print("Options: \(question.options)")
                print("Answer  \(question.answer)")
            }
        } catch {
            fatalError("Error while parsing JSON: \(error.localizedDescription)")
        }

        return questions
    }
    func getCIRQuestions() -> [Question] {
        var questions = [Question]() // Diziyi saklamak için questions adında bir değişken tanımla

        guard let jsonData = QuestionManager.readJSONFromFile(filename: "c_IR") else {
            fatalError("Failed to read JSON file.")
        }
        do {
            let jsonArray = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [[String: Any]]

            for jsonObject in jsonArray {
                guard let questionText = jsonObject["question"] as? String,
                      let options = jsonObject["options"] as? [String],
                      let answer = jsonObject["answer"] as? String
                else {
                    fatalError("Failed to parse JSON.")
                }

                let question = Question(question: questionText, options: options, answer: answer)
                questions.append(question)
            }

            // Optional: Questions dizisini yazdırabilirsiniz
            for (index, question) in questions.enumerated() {
                print("Question \(index + 1): \(question.question)")
                print("Options: \(question.options)")
                print("Answer  \(question.answer)")
            }
        } catch {
            fatalError("Error while parsing JSON: \(error.localizedDescription)")
        }

        return questions
    }
}

