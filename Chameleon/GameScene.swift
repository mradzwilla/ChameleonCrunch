//
//  GameScene.swift
//  Chameleon
//
//  Created by Michael Radzwilla on 4/24/17.
//  Copyright © 2017 swifttutorial. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var flyCount = 5
    var availableColors: Array<UIColor> = [.red, .blue, .yellow, .green, .purple]
    var currentEyeColor = UIColor()
    var fliesRemaining = Array<Fly>()
    
    func createFly(){
        let fly = Fly()
        fly.setScale(0.08)
        
        let flyPosition = CGPoint(x: CGFloat.random(min: 0 + fly.size.width, max: (scene?.size.width)! - fly.size.width), y: CGFloat.random(min: #imageLiteral(resourceName: "chameleon").size.height, max: (scene?.size.height)! - fly.size.height))
        let flyColorIndex = Int(arc4random_uniform(UInt32(availableColors.count)))
        let flyColor = availableColors[flyColorIndex]
        fly.position = flyPosition
        fly.color = flyColor
        fly.colorBlendFactor = 1
        fly.name = "fly"
        fliesRemaining.append(fly)
        //colorsRemaining.append(flyColor)
        addChild(fly)
        moveFly(fly)
    }
    
    func moveFly(_ fly: Fly){
        fly.moveFly()
    }
    func flyTapped(fly: Fly)-> Bool{
        
        if (fly.color == currentEyeColor){
            //Animation
            if let flyIndex = fliesRemaining.index(of: fly){
                fliesRemaining.remove(at: flyIndex)
                fly.removeFromParent()
                updateEyeColor()
                return true
            }
        }
            return false
    }
    
    func updateEyeColor(){
        if fliesRemaining.count > 0{
            let EyeColorIndex = Int(arc4random_uniform(UInt32(fliesRemaining.count)))
            print(EyeColorIndex)
            print(fliesRemaining.count)
            currentEyeColor = (fliesRemaining[EyeColorIndex]).color
            scene?.backgroundColor = currentEyeColor
        }else{
            flyCount += 3
            for _ in 1...flyCount{
                createFly()
            }
            updateEyeColor()
        }
    }
    override func didMove(to view: SKView) {
        
        for _ in 0...flyCount{
            createFly()
        }
        
        let chameleon = SKSpriteNode(imageNamed: "chameleon")
        updateEyeColor()
        chameleon.setScale(1.5)
        
        chameleon.position = CGPoint(x:scene!.size.width - chameleon.size.width/5, y:0)
        addChild(chameleon)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            let location = touch.location(in: self)
            let tappedNodes = nodes(at: location)
            
            for node in tappedNodes{
                if node.name == "fly"{
                    let wasFlyRemoved = flyTapped(fly: node as! Fly)
                    if wasFlyRemoved == true{
                        return
                    }
                }
            }
        }
    }
}
