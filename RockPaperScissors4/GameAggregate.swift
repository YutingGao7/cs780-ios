//
//  GameAggregate.swift
//  RockPaperScissors4
//
//  Created by Candy Gao on 5/11/22.
//

import Foundation

class GameAggregate {
    private static var winNum: Int = 0;
    private static var tieNum: Int = 0;
    private static var loseNum: Int = 0;
    
    static func recordWin(){
        winNum += 1
    }
    static func recordTie(){
        tieNum += 1
    }
    static func recordLose(){
        loseNum += 1
    }
    
    static func getUserScores() -> (Int, Int, Int){
        return (winNum, tieNum, loseNum)
    }
    
    static func reset(){
        GameAggregate.winNum = 0
        GameAggregate.tieNum = 0
        GameAggregate.loseNum = 0
    }
    
}
