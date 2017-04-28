//
//  GameViewController.swift
//  Chameleon
//
//  Created by Michael Radzwilla on 4/24/17.
//  Copyright © 2017 swifttutorial. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = GameScene(size:CGSize(width: 2048, height: 1536))
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.size = skView.bounds.size
        scene.scaleMode = .aspectFill
        skView.presentScene(scene)
    }
}
