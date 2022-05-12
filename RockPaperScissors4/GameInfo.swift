
import Foundation

class GameInfo {
    
    enum GameChoices: Int, CaseIterable {
        case Rock, Paper, Scissors, Invalid

        func getString() -> String {
            switch self {
            case .Rock:
                return "Rock"
            case .Paper:
                return "Paper"
            case .Scissors:
                return "Scissors"
            case .Invalid:
                return "Invalid"
            }
        }
    }
    
    let TOTALROUND: Int = 3;
    private var playerInt:Int = -1
    private var historyResults: [Int] = [-1, -1, -1]
    private var historyText: String = "History"
    private var roundResultInt: Int = Int.min
    
    
    private var currentRound = 1
    
    func getCurrentRound() -> Int {
        return self.currentRound
    }
    
    private func updateCurrentRound(){
        self.currentRound += 1
    }
    
    func getPreviousRound() -> Int{
        return currentRound - 1
    }
    
    func setPlayerInt(_ playerChoice: String) {
        self.playerInt = choiceEncode(playerChoice)
    }
    
    
    private func generateAiResult() -> Int{
        return Int.random(in: 0..<3)
    }
    
    //Caution: must be called after playGame() to get valid AiInt
    private func getAiChoice(_ aiInt: Int) -> String {
        return decodeToChoice(aiInt)
    }

    private func playGame() -> (Int, String) {

        let playerInt: Int = self.playerInt
        let aiInt:Int = generateAiResult()
        let aiChoice: String = getAiChoice(aiInt)
        
        //decode table: 0 == Rock; 1 == Paper; 2 == Scissors;
        let playerWins: Bool = (playerInt == 0 && aiInt == 2)
                            || (playerInt == 1 && aiInt == 0)
                            || (playerInt == 2 && aiInt == 1)
        var roundResult: Int
        
        if (aiInt == playerInt) {
            roundResult = 0
        } else if (playerWins){
            roundResult = 1
        } else {
            roundResult = -1
        }
        self.roundResultInt = roundResult
        updateHistoryInfo(roundResult)
        updateCurrentRound()

        return (roundResult, aiChoice)
    }
    
    //returns gameResult and aiChoice, also updates historyText
    func getGameResult() -> (Int, String, String, Bool) {
        let roundResult: Int, aiChoice: String
        (roundResult,aiChoice) = playGame()
        let roundResultText: String = decodeToResultText(roundResult)
        let needTieBreaker: Bool = needTieBreaker(roundResult)
        return (roundResult, roundResultText, aiChoice, needTieBreaker)
    }
    
    private func updateHistoryInfo(_ resultInt: Int){
        updateHistoryResults(resultInt)
        updateHistoryText(resultInt)
    }
    
    
    private func updateHistoryResults(_ resultInt: Int){
        //index start from 0, curRound starts from 1
        let idx: Int = getPreviousRound()
        if (idx < TOTALROUND) {
            historyResults[getPreviousRound()] = resultInt
        } else {
            historyResults.append(resultInt)
        }
        print("Round \(getCurrentRound()): \(resultInt)")
    }
    
    private func updateHistoryText(_ resultInt: Int) {
        let roundResultText: String = decodeToResultText(resultInt)
        
        if (getCurrentRound() == 1) {
            self.historyText = "Round 1: " + roundResultText;
        } else
        {
            self.historyText += "\nRound \(getCurrentRound()): \(roundResultText)";
        }
        
        print("\(self.historyText)")
    }
    
    func getHistoryText() -> String {
        return self.historyText
    }
    
    
    func needTieBreaker(_ roundResult: Int) -> Bool {
        //this is called from VC after game is played
        let curRound: Int = getPreviousRound()
        if(curRound < TOTALROUND){
            return true
        }else if (curRound == TOTALROUND) {
            //test sum
            return (get3RoundsSum() == 0)
        } else {
            //test last result
            return (roundResult == 0)
        }
    }
    
    private func get3RoundsSum() -> Int {
        let round: Int = getPreviousRound()
        if (round == 3) {
            var sum: Int = 0
            for item in historyResults {
                sum += item
            }
            print("Round \(round): sum: \(sum)")
            return sum
        }
        print("Error: access 3-rounds-result at round: \(round)")
        return Int.min
    }
    
    func getFinalResultInt() -> Int {
        let round: Int = getPreviousRound()
        if (round == 3) {
            let score: Int = get3RoundsSum()
            var finalResultInt: Int = 0
            if (score == 0) {
                finalResultInt = 0
            } else if (score > 0) {
                finalResultInt = 1
            } else {
                finalResultInt = -1
            }
            return finalResultInt
        }else{
            return self.roundResultInt
        }
    }
    
    
    func choiceEncode(_ playerChoice: String) -> Int{
        for choice in GameChoices.allCases{
            if(choice.getString() == playerChoice){
                return choice.rawValue
            }
        }
        print("Error! Un-recognized player string: \(playerChoice)")
        return -1;
    }
    
    func decodeToChoice(_ playerInt: Int) -> String {
        return GameChoices(rawValue: playerInt)!.getString()
    }
    

    //TODO: consider using enum
    func decodeToResultText(_ resultInt: Int) -> String {
        var roundResultText = ""
        
        if (resultInt == 0){
                    roundResultText = "Tie";
        }else if (resultInt == 1){
                    roundResultText = "Win";
        }else if (resultInt == -1){
                    roundResultText = "Lose";
        }else{
            print("Error, non-recognized round result: \(resultInt)");
        }
        return roundResultText
    }
    
    
    

    
    
}
