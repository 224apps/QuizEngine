//
//  GamTest.swift
//  QuizEngineTests
//
//  Created by Abdoulaye Diallo on 2/2/21.
//

import XCTest

class GameTest: XCTestCase {
    
    let router = RouterSpy()
    var game: Game<String, String, RouterSpy>!
    
    override  func setUp() {
        super.setUp()
        game  = startGame(questions: ["Q1", "Q2"], router: router, correctAnswers: ["Q1" : "A1", "Q2" : "A2"])
    }
    
    func test_startGame_answerZeroOutTwoCorrectly_scores1(){
        router.answerCallback("wrong")
        router.answerCallback("wrong")
        
        XCTAssertEqual(router.routedResult!.score, 0)
    }
    
    func test_startGame_answerOneOutTwoCorrectly_scores1(){
        router.answerCallback("A1")
        router.answerCallback("wrong")
        
        XCTAssertEqual(router.routedResult!.score, 1)
    }
    
    func test_startGame_answerTwoOutTwoCorrectly_scores1(){
        
        router.answerCallback("A1")
        router.answerCallback("A2")
        
        XCTAssertEqual(router.routedResult!.score, 2)
    }
    
}
