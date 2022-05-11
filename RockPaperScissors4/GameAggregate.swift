//
//  GameAggregate.swift
//  RockPaperScissors4
//
//  Created by Candy Gao on 5/11/22.
//

import Foundation

class GameAggregate {
    private var winNum: Int = 0;
    private var tieNum: Int = 0;
    private var loseNum: Int = 0;
    
    func recordWin(){
        self.winNum += 1
    }
    func recordTie(){
        self.tieNum += 1
    }
    func recordLose(){
        self.loseNum += 1
    }
    
    func getUserScores() -> (Int, Int, Int){
        return (self.winNum, self.tieNum, self.loseNum)
    }
    
}
