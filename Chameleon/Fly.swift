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
    //Don't need this now, but will probably need it in the future to build off of
    let moveDuration:CGFloat = 3.0
    init() {
        let texture = SKTexture(imageNamed: "fly")
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
        print((scene?.size.width)!)
        let actionMoveLeft = SKAction.moveTo(x: 0, duration: TimeInterval(leftTravelDuration))
        let actionReturnFromLeft = SKAction.moveTo(x: initialPositionX, duration: TimeInterval(leftTravelDuration))
        let actionMoveRight = SKAction.moveTo(x: (self.scene?.size.width)!, duration: TimeInterval(rightTravelDuration))
        let actionReturnFromRight = SKAction.moveTo(x: initialPositionX, duration: TimeInterval(rightTravelDuration))
        self.run(SKAction.repeatForever(SKAction.sequence([actionMoveLeft, actionReturnFromLeft, actionMoveRight, actionReturnFromRight])))
    }
    func moveFly() {
        moveLinear()
    }
    
}
