//
//  QuizEngineTests.swift
//  QuizEngineTests
//
//  Created by Abdoulaye Diallo on 1/13/21.
//

import XCTest


class FlowTest: XCTestCase {
    
    let router = RouterSpy()
    
    func test_start_withNoQuestions_doesNotRouteToQuestion(){
        makeSUT(questions: []).start()
        XCTAssertTrue(router.routedQuestions.isEmpty)
    }
    
    func test_start_WithOneQuestion_routesToCorrectQuestion(){
        makeSUT(questions: ["Q1"]).start()
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_start_WithOneQuestion_routesToCorrectQuestion2(){
        makeSUT(questions: ["Q2"]).start()
        XCTAssertEqual(router.routedQuestions, ["Q2"])
    }
    
    func test_start_WithTwoQuestions_routesToFirstQuestion(){
        makeSUT(questions: ["Q1", "Q2"]).start()
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_startTwice_WithTwoQuestions_routesToFirstQuestionTwice(){
        let sut = makeSUT(questions: ["Q1", "Q2"])
        sut.start()
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q1"])
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_WithThreeQuestions_routesToSecondAndThirdQuestion(){
        
        let sut = makeSUT(questions: ["Q1", "Q2", "Q3"])
        sut.start()
        
        router.answerCallback("A1")
        router.answerCallback("A2")
        XCTAssertEqual(router.routedQuestions, ["Q1","Q2", "Q3"])
    }
    
    func test_startAndAnswerFirstQuestion_WithOneQuestion_doesnotRouteToAnotherQuestion(){
        
        let sut = makeSUT(questions: ["Q1"])
        sut.start()
        
        router.answerCallback("A1")
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_start_withNoQuestions_routeToResult(){
        makeSUT(questions: []).start()
        XCTAssertEqual(router.routedResult!.answers, [:])
    }
    
    func test_start_withOneQuestion_doesNotRouteToResult(){
        makeSUT(questions: ["Q1"]).start()
 
        router.answerCallback("A1")
        XCTAssertNil(router.routedResult)
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_WithOneQuestion_routeToResult(){
        
        let sut = makeSUT(questions: ["Q1", "Q2"])
        sut.start()
        
        router.answerCallback("A1")
        router.answerCallback("A2")
        XCTAssertEqual(router.routedResult!.answers, ["Q1":"A1", "Q2" : "A2"])
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_WithTwoQuestion_routeToResult(){
        
        let sut = makeSUT(questions: ["Q1", "Q2"])
        sut.start()
        
        router.answerCallback("A1")
        XCTAssertNil(router.routedResult)
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_WithTwoQuestion_scores(){
        
        let sut = makeSUT(questions: ["Q1", "Q2"], scoring: { _ in 10 })
        sut.start()
        
        router.answerCallback("A1")
        router.answerCallback("A2")
        XCTAssertEqual(router.routedResult!.score, 10)
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_WithTwoQuestion_scoresWithRightAnswers(){
        var receivedAnswers = [String : String]()
        let sut = makeSUT(questions: ["Q1", "Q2"], scoring: { answers in
            receivedAnswers = answers
            return 20
        })
        sut.start()
        
        router.answerCallback("A1")
        router.answerCallback("A2")
        XCTAssertEqual(receivedAnswers, ["Q1": "A1", "Q2": "A2"])
    }

    //MARK: - Helpers
    
    func makeSUT(questions:[String],
                 scoring: @escaping ([String: String]) -> Int = { _ in 0 } ) -> Flow<String, String, RouterSpy>{
        return Flow(questions: questions, router: router, scoring: scoring)
    }
    
}
