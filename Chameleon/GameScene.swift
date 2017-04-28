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
    //Probably would be good to create update method
    //Create flySpace variable
    //Add lives to bottom
    //Have timer be reducing bar at top
    
    var chameleon = SKSpriteNode(imageNamed: "chameleon")
    var chameleonStatic = SKSpriteNode(imageNamed: "chameleon-eye")
    
    
    var availableColors: Array<UIColor> = [.red, .blue, .yellow, .green, .purple]
    var currentColor = UIColor()
    var fliesRemaining = Array<Fly>()
    var level = levelManager()
    
    var flyCount = levelManager().flyCount
    
    func createFly(){
        let fly = Fly(speed: level.randomFlySpeed(), oscillation: level.randomFlyOscillation())
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
        
        if (fly.color == currentColor){
            //Animation
            if let flyIndex = fliesRemaining.index(of: fly){
                fliesRemaining.remove(at: flyIndex)
                fly.removeFromParent()
                updateColor()
                return true
            }
        }
        return false
    }
    
    func updateColor(){
        if fliesRemaining.count > 0{
            let ColorIndex = Int(arc4random_uniform(UInt32(fliesRemaining.count)))
            currentColor = (fliesRemaining[ColorIndex]).color
            chameleon.color = currentColor
        }else{
            level.nextLevel()
            flyCount = level.flyCount
            for _ in 1...flyCount{
                createFly()
                print("Created flies: \(flyCount)")
            }
            updateColor()
        }
    }
    override func didMove(to view: SKView) {
        
        for _ in 0...flyCount{
            createFly()
        }
        
        updateColor()
        chameleon.setScale(1.5)
        chameleonStatic.setScale(1.5)
        
        chameleon.position = CGPoint(x:scene!.size.width - chameleon.size.width/5, y:0)
        chameleonStatic.position = CGPoint(x:scene!.size.width - chameleon.size.width/5, y:0)
        
        chameleon.colorBlendFactor = 1
        chameleon.alpha = 1
        addChild(chameleon)
        addChild(chameleonStatic)
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
