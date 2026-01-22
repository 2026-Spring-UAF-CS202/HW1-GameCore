// MARK: - 1. Enums

/// Represents the three possible moves in a game of Rock-Paper-Scissors.
///
/// This enum is `String` backed (e.g., `.rock` is "🪨"), which is useful for printing.
public enum HandShape: String, CaseIterable, Sendable {
  case rock = "🪨"
  case paper = "📄"
  case scissors = "✂️"
}

/// Represents the players in a two-player game
///
public enum Player: Sendable {
  
  /// The first player
  case one
  /// The second player
  case two
  
}

// MARK: - 2. Data Models

/// Represents a single round of Rock-Paper-Scissors.
public struct RPSTurn: Sendable {
  
  /// The move played by Player 1.
  public let player1: HandShape
  
  /// The move played by Player 2.
  public let player2: HandShape
  
  /// The winner of the round, or `nil` if the game ended in a Tie.
  public let winner: Player?
  
  /// Creates a new record of an RPS turn.
  /// - Parameters:
  ///   - player1: The shape chosen by the first player.
  ///   - player2: The shape chosen by the second player.
  ///   - winner: The result of the comparison (`.one`, `.two`, or `nil` for tie).
  public init(player1: HandShape, player2: HandShape, winner: Player?) {
    self.player1 = player1
    self.player2 = player2
    self.winner = winner
  }
}

/// An immutable record of a single move in Chutes and Ladders.
///
/// This struct tracks the dice roll and the resulting square index after applying board rules.
public struct BoardTurn: Sendable {
  /// The number rolled on the die (typically 1-6).
  public let roll: Int
  
  /// The final square index the player landed on (0-100).
  /// This value should account for any chutes (slides down) or ladders (climbs up).
  public let endSquare: Int
  
  /// Creates a new record of a board move.
  /// - Parameters:
  ///   - roll: The raw dice roll value.
  ///   - endSquare: The calculated final position on the board.
  public init(roll: Int, endSquare: Int) {
    self.roll = roll
    self.endSquare = endSquare
  }
}

// MARK: - 3. The Container

/// A container enum that can represent a turn from *any* supported game.
///
/// This allows the `main.swift` loop to store a heterogeneous history of game events.
public enum GameTurn: Sendable {
  /// Wraps a Rock Paper Scissors result.
  case rps(RPSTurn)
  /// Wraps a Chutes and Ladders result.
  case board(BoardTurn)
}

// MARK: - 4. Game Protocols

/// The base requirement for any game in the system.
///
/// All games must have a name and a way to play a full simulation.
public protocol Game: Sendable {
  /// The display name of the game (e.g., "Rock Paper Scissors").
  var name: String { get }
  
  /// Runs a full simulation of the game (e.g., 5 rounds or until finish).
  /// - Returns: An array of `GameTurn` objects representing the history of the match.
  func play() -> [GameTurn]
}

/// Defines the specific rules for Rock Paper Scissors.
///
/// Students implementation must conform to this protocol.
public protocol RockPaperScissorsGame: Game {
  /// Required default initializer for the Game Factory.
  init()
  
  /// Calculates the result of a single round.
  ///
  /// - Parameters:
  ///   - player1: The move for the first player.
  ///   - player2: The move for the second player.
  /// - Returns: A concrete `RPSTurn` struct containing the winner.
  func turn(player1: HandShape, player2: HandShape) -> RPSTurn
}

/// Defines the specific rules for Chutes and Ladders.
///
/// Students implementation must conform to this protocol.
public protocol ChutesAndLaddersGame: Game {
  /// Required default initializer for the Game Factory.
  init()
  
  /// Calculates the result of a single move on the board.
  ///
  /// This function must handle:
  /// 1. Adding the roll to the current square.
  /// 2. Checking if the new square is the start of a Ladder or Chute.
  /// 3. Capping the movement at square 100.
  ///
  /// - Parameters:
  ///   - currentSquare: The player's starting position (0-100).
  ///   - roll: The dice roll value.
  /// - Returns: A concrete `BoardTurn` struct containing the final destination.
  func turn(currentSquare: Int, roll: Int) -> BoardTurn
}
