//
//  GameState.swift
//  XO-game
//
//  Created by Артур Кондратьев on 19.06.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

protocol GameState {
    var isComplated: Bool { get }
    
    func begin ()

    func addMark(at position: GameboardPosition)
}
