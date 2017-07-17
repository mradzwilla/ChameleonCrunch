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
    
    let chameleon = SKSpriteNode(imageNamed: "chameleon")
    let chameleonStatic = SKSpriteNode(imageNamed: "chameleon-eye")
    let background = SKSpriteNode(imageNamed: "rainforest")
    
    var currentColor = UIColor()
    var fliesRemaining = Array<Fly>()
    var level = levelManager()
    
    var livesImages = [SKSpriteNode]()
    var lives = 3
    
    var flyCount = levelManager().flyCount
    var flyZIndex:CGFloat = 1
    
    func createFly(){
        let fly = Fly(speed: level.randomFlySpeed(), oscillation: level.randomFlyOscillation())
        fly.setScale(0.08)
        
        let flyPosition = CGPoint(x: CGFloat.random(min: 0 + fly.size.width, max: (scene?.size.width)! - fly.size.width), y: CGFloat.random(min: #imageLiteral(resourceName: "chameleon").size.height, max: (scene?.size.height)! - fly.size.height))
        fly.position = flyPosition
        let flyColorIndex = Int(arc4random_uniform(UInt32(level.availableColors.count)))
        let flyColor = level.availableColors[flyColorIndex]
        fliesRemaining.append(fly)
        //colorsRemaining.append(flyColor)
        fly.color = flyColor
        fly.colorBlendFactor = 1
        fly.alpha = 1
        
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
        rotateEye()
        if fliesRemaining.count > 0{
            let ColorIndex = Int(arc4random_uniform(UInt32(fliesRemaining.count)))
            currentColor = (fliesRemaining[ColorIndex]).color
            chameleon.color = currentColor
        }else{
            level.nextLevel()
            flyCount = level.flyCount
            for _ in 1...flyCount{
                createFly()
            }
            Fly.zIndexTracker = 1
            updateColor()
        }
    }
    
    func rotateEye(){
        let rotateAction = SKAction.rotate(byAngle: 2 * CGFloat(Double.pi), duration: 0.5)
        chameleonStatic.run(rotateAction)
    }
    
    func loseLife(){
        lives -= 1
        
        //run(SKAction.playSoundFileNamed("wrong.caf", waitForCompletion: false))
        
        var life: SKSpriteNode
        
        if lives == 2 {
            life = livesImages[2]
        } else if lives == 1 {
            life = livesImages[1]
        } else {
            life = livesImages[0]
            //            endGame(triggeredByBomb: false)
        }
        
        //        life.texture = SKTexture(imageNamed: "sliceLifeGone")
        
        life.xScale = 0.15
        life.yScale = 0.15
        life.run(SKAction.scale(to: 0.05, duration:0.1))
        life.removeFromParent()
    }
    override func didMove(to view: SKView) {
        
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        background.zPosition = -1
        addChild(background)
        
        updateColor()
        chameleon.setScale(1.5)
        chameleonStatic.setScale(1)
        
        chameleon.position = CGPoint(x:scene!.size.width - chameleon.size.width/5, y:0)
        //chameleonStatic.position = CGPoint(x:scene!.size.width - chameleon.size.width/5, y:0)
        chameleonStatic.position = CGPoint(x:-46,y:45)
        
        var positionAdd:CGFloat = 20.0
        
        for _ in 1...lives{
            let lifeSprite = SKSpriteNode(imageNamed: "heart")
            lifeSprite.setScale(0.12)
            let xOffset = lifeSprite.frame.size.width * CGFloat(1.1)
            let yOffset = lifeSprite.frame.size.height/2
            
            lifeSprite.position = CGPoint(x:positionAdd,y:yOffset)
            addChild(lifeSprite)
            livesImages.append(lifeSprite)
            
            positionAdd += xOffset
        }
        
        chameleon.colorBlendFactor = 1
        chameleon.alpha = 1
        addChild(chameleon)
        chameleon.addChild(chameleonStatic)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            let location = touch.location(in: self)
            let tappedNodes = nodes(at: location)
            flyLoop: for (index,node) in tappedNodes.enumerated(){
                if node.name == "fly"{
                    let wasFlyRemoved = flyTapped(fly: node as! Fly)
                    if wasFlyRemoved == true{
                        break flyLoop
                    }
                }
                //On last iteration of loop
                if (index == tappedNodes.count - 1){
                    loseLife()
                }
            }
        }
    }
}
