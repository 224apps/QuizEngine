//
//  GamTest.swift
//  QuizEngineTests
//
//  Created by Abdoulaye Diallo on 2/2/21.
//

import XCTest

class GameTest: XCTestCase {

    func test_startGame_answerOneOutTwoCorrectly_scores1(){
        let router = RouterSpy()
        startGame(questions: ["Q1", "Q2"], router: router, correctAnswers: ["Q1" : "A1", "Q2" : "A2"])
        
        router.answerCallback("A1")
        router.answerCallback("wrong")
        XCTAssertEqual(router.routedResult!.score, 1)
    }
}
