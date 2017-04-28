//
//  File.swift
//  Chameleon
//
//  Created by Michael Radzwilla on 4/27/17.
//  Copyright © 2017 swifttutorial. All rights reserved.
//

import Foundation
import GameKit

class Fly: SKSpriteNode {
    //  Need to create variables to pass to movement functions
    let π = CGFloat(M_PI)
    var moveDuration:CGFloat
    var oscillationAmount:CGFloat
    
    init(speed: CGFloat, oscillation: CGFloat) {
        let texture = SKTexture(imageNamed: "fly")
        moveDuration = speed
        oscillationAmount = oscillation
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var velocity = CGPoint(x:0,y:0)

    func boundsCheck(){
        let bottomLeft = CGPoint(x: 0, y: 0)
        let topRight = CGPoint(x: (scene?.size.width)!, y: (scene?.size.height)!)
        
        if self.position.x <= bottomLeft.x {
            self.position.x = bottomLeft.x
            velocity.x = -velocity.x
        }
        if self.position.x >= topRight.x {
            self.position.x = topRight.x
            velocity.x = -velocity.x }
        if self.position.y <= bottomLeft.y {
            self.position.y = bottomLeft.y
            velocity.y = -velocity.y
        }
        if self.position.y >= topRight.y {
            self.position.y = topRight.y
            velocity.y = -velocity.y }
    }
    
    func moveLinear(){
        let sceneSize = (self.scene?.size.width)!
        let leftTravelDuration = ((self.position.x)/sceneSize) * moveDuration/2
        let rightTravelDuration = ((sceneSize - self.position.x)/sceneSize) * moveDuration/2
        let initialPositionX = self.position.x
        let actionMoveLeft = SKAction.moveTo(x: 0, duration: TimeInterval(leftTravelDuration))
        let actionReturnFromLeft = SKAction.moveTo(x: initialPositionX, duration: TimeInterval(leftTravelDuration))
        let actionMoveRight = SKAction.moveTo(x: (self.scene?.size.width)!, duration: TimeInterval(rightTravelDuration))
        let actionReturnFromRight = SKAction.moveTo(x: initialPositionX, duration: TimeInterval(rightTravelDuration))
        self.run(SKAction.repeatForever(SKAction.sequence([actionMoveLeft, actionReturnFromLeft, actionMoveRight, actionReturnFromRight])))
    }
    
    func oscillate(){
        let oscillate = SKAction.oscillation(amplitude: oscillationAmount, timePeriod: 1, midPoint: self.position)
        self.run(SKAction.repeatForever(oscillate))
        //self.run(SKAction.moveBy(x: size.width, y: 0, duration: 5))
    }
    func moveFly() {
        moveLinear()
        oscillate()
    }
    
}
