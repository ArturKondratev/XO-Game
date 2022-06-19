//
//  PlayerInputState.swift
//  XO-game
//
//  Created by Артур Кондратьев on 19.06.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

class PlayerInputState: GameState {

    private(set) var isComplated = false
    
    let player: Player
    private(set) var gameViewController: GameViewController?
    private(set) var gameboard: Gameboard?
    private(set) var gameboardView: GameboardView?
    
    init(player: Player,
         gameViewController: GameViewController,
         gameboard: Gameboard,
         gameboardView: GameboardView ) {
        self.player = player
        self.gameViewController = gameViewController
        self.gameboard = gameboard
        self.gameboardView = gameboardView
    }
    
    func begin() {
        switch player {
        case .first:
            gameViewController?.firstPlayerTurnLabel.isHidden = false
            gameViewController?.secondPlayerTurnLabel.isHidden = true
        case .second:
            gameViewController?.firstPlayerTurnLabel.isHidden = true
            gameViewController?.secondPlayerTurnLabel.isHidden = false
        }
        
        gameViewController?.winnerLabel.isHidden = true
    }
    
    func addMark(at position: GameboardPosition) {
        guard let gameboardView = self.gameboardView,
        gameboardView.canPlaceMarkView(at: position) else {
            return
        }
        
        let markView: MarkView
        switch player {
        case .first:
            markView = XView()
        case .second:
            markView = OView()
        }
        
        gameboard?.setPlayer(player, at: position)
        gameboardView.placeMarkView(markView, at: position)
        isComplated = true
    }
    
    
    
    
}
