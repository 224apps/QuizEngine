//
//  Rotuer.swift
//  QuizEngine
//
//  Created by Abdoulaye Diallo on 2/2/21.
//

import Foundation


public protocol Router {
    associatedtype Question: Hashable
    associatedtype Answer
    func routeTo(question: Question, answerCallback: @escaping (Answer) -> Void)
    func routeTo(result: Result<Question, Answer>)
}
