//
//  RouterSpy.swift
//  QuizEngineTests
//
//  Created by Abdoulaye Diallo on 2/2/21.
//

import Foundation

public class RouterSpy: Router {

    var routedQuestions: [String] = []
    var routedResult: Result<String, String>? = nil
    var answerCallback: (String) -> Void = { _ in }
    
    public func routeTo(question: String,
                        answerCallback: @escaping (String) -> Void ) {
        routedQuestions.append(question)
        self.answerCallback = answerCallback
    }
    
    public func routeTo(result:  Result<String, String>) {
        routedResult = result
    }
}
