//
//  ParticleScene.swift
//  CardMatchingGame
//
//  Created by Vladimir Kratinov on 2022/8/5.
//

import UIKit
import SpriteKit

class ParticleScene: SKScene {
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        setupParticleEmitter()
    }
    
    private func setupParticleEmitter() {
        if let emitter = SKEmitterNode(fileNamed: "explode") {
            emitter.position = CGPoint(x: 50, y: 50)
            addChild(emitter)
        }
    }
}
