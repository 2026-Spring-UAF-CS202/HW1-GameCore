// No imports needed

/// A simple error type used to report specific grading failures to the Test Runner.
public struct GradingError: Error, CustomStringConvertible {
    /// The readable failure message (e.g., "Logic Fail: Paper beats Rock").
    public let description: String
    
    init(_ description: String) {
        self.description = description
    }
}

/// The centralized verification logic for HW1.
///
/// This struct contains static methods that test specific game implementations.
/// It is "locked" in the library so students cannot modify the pass criteria.
public struct Grader {
    
    // MARK: - RPS Verification
    
    /// Verifies that the logic of a `RockPaperScissorsGame` follows standard rules.
    ///
    /// This test checks:
    /// - Player 1 Wins (Paper covers Rock)
    /// - Player 2 Wins (Paper covers Rock, symmetric check)
    /// - Ties (Scissors vs Scissors)
    ///
    /// - Parameter game: The student's game implementation.
    /// - Throws: `GradingError` if any rule is violated.
    public static func verifyRPSLogic(_ game: any RockPaperScissorsGame) throws {
        print("🔍 Grader: Verifying RPS Logic...")
        
        // 1. Test Player 1 Win
        let p1Win = game.turn(player1: .paper, player2: .rock)
        guard p1Win.winner == .one else {
            throw GradingError("❌ Logic Fail: Paper (P1) vs Rock (P2) should be Player 1 Win.")
        }
        
        // 2. Test Player 2 Win
        let p2Win = game.turn(player1: .rock, player2: .paper)
        guard p2Win.winner == .two else {
            throw GradingError("❌ Logic Fail: Rock (P1) vs Paper (P2) should be Player 2 Win.")
        }
        
        // 3. Test Tie
        let tie = game.turn(player1: .scissors, player2: .scissors)
        guard tie.winner == nil else {
            throw GradingError("❌ Logic Fail: Scissors vs Scissors should be a Tie (nil).")
        }
        
        print("✅ RPS Logic Passed")
    }
    
    /// Verifies that the student has implemented `CustomStringConvertible` correctly.
    ///
    /// - Parameter output: The string result of `String(describing: turn)`.
    /// - Throws: `GradingError` if the string is missing key information.
    public static func verifyRPSString(_ output: String) throws {
        print("🔍 Grader: Verifying RPS String Format...")
        
        guard output.contains("Player 1 Wins") || output.contains("Player 1") else {
            throw GradingError("❌ String Fail: Output must identify 'Player 1 Wins'. Got: \(output)")
        }
        
        guard output.contains("vs") else {
             throw GradingError("❌ String Fail: Output must contain 'vs'. Got: \(output)")
        }
        
        print("✅ RPS Printing Passed")
    }
    
    // MARK: - Chutes Verification
    
    /// Verifies the board movement logic, including Ladders, Chutes, and Boundaries.
    ///
    /// - Parameter game: The student's game implementation.
    /// - Throws: `GradingError` if the math is wrong.
    public static func verifyChutesLogic(_ game: any ChutesAndLaddersGame) throws {
        print("🔍 Grader: Verifying Chutes Logic...")
        
        // Test Ladder
        let ladder = game.turn(currentSquare: 0, roll: 4)
        guard ladder.endSquare == 14 else {
             throw GradingError("❌ Logic Fail: 0 + 4 is a ladder to 14. Got: \(ladder.endSquare)")
        }
        
        // Test Chute
        let chute = game.turn(currentSquare: 10, roll: 7) // Lands on 17
        guard chute.endSquare == 7 else {
            throw GradingError("❌ Logic Fail: Landed on 17 (Chute). Should be 7. Got: \(chute.endSquare)")
        }
        
        print("✅ Chutes Logic Passed")
    }
}
