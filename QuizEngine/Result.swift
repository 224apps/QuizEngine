//
//  Result.swift
//  QuizEngine
//
//  Created by Abdoulaye Diallo on 2/2/21.
//

import Foundation

public struct Result <Question: Hashable, Answer>{
    public let answers : [Question: Answer]
    public let  score: Int
}
