//
//  GameViewController.swift
//  XO-game
//
//  Created by Evgeny Kireev on 25/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet var gameboardView: GameboardView!
    @IBOutlet var firstPlayerTurnLabel: UILabel!
    @IBOutlet var secondPlayerTurnLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var restartButton: UIButton!
    
    private lazy var referee = Referee(gameboard: gameboard)
    private let gameboard = Gameboard()
    private var currentState: GameState! {
        didSet {
            currentState.begin()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goToFirstState()
        
        
        gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }
            self.currentState.addMark(at: position)
            
            if self.currentState.isComplated {
                self.goToNextState()
            }
        }
    }
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        
    }
    
    //MARK: - Private functions
    
    private func goToFirstState() {
        currentState = PlayerInputState(player: .first,
                                        gameViewController: self,
                                        gameboard: gameboard,
                                        gameboardView: gameboardView)
    }
    
    private func goToNextState() {
        if let winner = referee.determineWinner() {
            currentState = GameFinishState(winner: winner, gameViewController: self)
            return
        }
        
        
        if let playerInputState = currentState as? PlayerInputState {
            currentState = PlayerInputState(player: playerInputState.player.next,
                                            gameViewController: self,
                                            gameboard: gameboard,
                                            gameboardView: gameboardView)
        }
        
    }
    
}

