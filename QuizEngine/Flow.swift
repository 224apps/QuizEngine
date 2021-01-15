//
//  Flow.swift
//  QuizEngine
//
//  Created by Abdoulaye Diallo on 1/13/21.
//

import Foundation

protocol Router {
    typealias AnswerCallBack = (String) -> Void
    func routeTo(question: String, answerCallback: @escaping AnswerCallBack)
    func routeTo(result: [String: String])
}



class Flow {
    private let router: Router
    private let questions: [String]
    private var result:[String:String] = [:]
    init(questions: [String], router: Router){
        self.router = router
        self.questions = questions
    }
    
    func start(){
        if  let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion, answerCallback: routeNext(from:firstQuestion))
        }else{
            router.routeTo(result: result)
        }
    }
    
    private func routeNext(from question: String) -> Router.AnswerCallBack {
        return { [weak self]  answer in
            guard let strongSelf = self else { return }
            let currentQuestionIndex = strongSelf.questions.firstIndex(of: question)!
            strongSelf.result[question] = answer
            if  currentQuestionIndex + 1 < strongSelf.questions.count{
                let nextQuestion = strongSelf.questions[currentQuestionIndex + 1]
                strongSelf.router.routeTo(question: nextQuestion, answerCallback: strongSelf.routeNext(from:nextQuestion))
            }else{
                strongSelf.router.routeTo(result: strongSelf.result)
            }
        }
    }
}

