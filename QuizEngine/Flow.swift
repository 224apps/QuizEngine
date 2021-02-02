//
//  Flow.swift
//  QuizEngine
//
//  Created by Abdoulaye Diallo on 1/13/21.
//

import Foundation

protocol Router {
    associatedtype Question: Hashable
    associatedtype Answer
    func routeTo(question: Question, answerCallback: @escaping (Answer) -> Void)
    func routeTo(result: [Question: Answer])
}

class Flow <Question: Hashable, Answer, R: Router> where R.Question == Question , R.Answer  == Answer {
    private let router: R
    private let questions: [Question]
    private var result:[Question : Answer] = [:]
    init(questions: [Question], router: R){
        self.router = router
        self.questions = questions
    }
    
    func start(){
        if  let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion, answerCallback: nextCallBack(from: firstQuestion))
        }else{
            router.routeTo(result: result)
        }
    }
    
    private func nextCallBack(from question: Question) ->  (Answer) -> Void {
        return { [weak self]   in self?.routeNext(question: question, $0)
            
        }
    }
    
    private func routeNext(question: Question, _ answer: Answer){
        if let currentQuestionIndex = questions.firstIndex(of: question){
            result[question] = answer
            
            let nextQuestionIndex = currentQuestionIndex + 1
            if  nextQuestionIndex < questions.count {
                let nextQuestion = questions[nextQuestionIndex]
                router.routeTo(question: nextQuestion, answerCallback: nextCallBack(from: nextQuestion))
            }else{
                router.routeTo(result: result)
            }
        }
    }
}

