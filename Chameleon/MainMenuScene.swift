//
//  MainMenu.swift
//  Chameleon
//
//  Created by Michael Radzwilla on 5/18/17.
//  Copyright © 2017 swifttutorial. All rights reserved.
//

import Foundation
import SpriteKit

class MainMenuScene: SKScene {
    
    override func didMove(to view: SKView) {
        let background = SKLabelNode()
        background.text = "Main Menu. Click anywhere to begin!"
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.zPosition = -1
        addChild(background)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let scene = GameScene(size:CGSize(width: 2048, height: 1536))
        scene.scaleMode = .aspectFill 
        let reveal = SKTransition.doorway(withDuration: 1.5)
        scene.scaleMode = .aspectFill
        scene.size = (view?.bounds.size)!
        
        view?.presentScene(scene, transition: reveal)

    }
}
