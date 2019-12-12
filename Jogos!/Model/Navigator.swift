//
//  Navigator.swift
//  Jogos!
//
//  Created by Kevin Ribeiro on 05/12/19.
//  Copyright © 2019 Kelvin Javorski Soares. All rights reserved.
//

import Foundation

struct Position {
    var x : Int!
    var y : Int!
}

class Navigator {
    
    var map : Map = Map()
    
    var direction : directions!
    
    var groupPosition : Position = Position(x: 3, y: 3)
    
    init () {}
    
    func initialize (mapSize: Int, groupPosition: Position) {
        map.initialize(mapSize: mapSize)
        self.groupPosition = groupPosition
    }
    
    func directionBetween(from: Position, to: Position) -> directions {
        if (from.x == to.x) {
            if (from.y < to.y) {
                return .south
            }
            else {
                return .north
            }
        }
        if (from.y == to.y) {
            if (from.x < to.x) {
                return .west
            }
            else {
                return .east
            }
        }
        if (from.x < to.x) {
            if (from.y < to.y) {
                return .northwest
            }
            else if (from.y > to.y) {
                return .southwest
            }
        }
        else if (from.x > to.x) {
            if (from.y < to.y) {
                return .southeast
            }
            else if (from.y > to.y) {
                return .northeast
            }
        }
        return .on
    }
    
    func distanceBetween(from: Position, to: Position) -> Int {
        let distance = abs(from.x - to.x) + abs(from.y - to.y)
        
        return distance
    }
    
    func moveGroup(to: directions) {
        switch to {
        case .north:
            self.groupPosition.y -= 1
        case .south:
            self.groupPosition.y += 1
        case .east:
            self.groupPosition.x += 1
        case .west:
            self.groupPosition.x -= 1
        case .northeast:
            self.groupPosition.x += 1
            self.groupPosition.y -= 1
        case .northwest:
            self.groupPosition.x -= 1
            self.groupPosition.y -= 1
        case .southeast:
            self.groupPosition.x += 1
            self.groupPosition.y += 1
        case .southwest:
            self.groupPosition.x -= 1
            self.groupPosition.y += 1
        default:
            break
        }
    }
    
    func groupPlace() -> Place {
        return map.mapMatrix[groupPosition.x][groupPosition.y]!
    }
    
    func verifyNeighbor() -> [directions]{
        var availableDirections : [directions] = [.northwest, .north, .northeast, .west, .east,  .southwest, .south, .southeast]
        
        if (groupPosition.x <= 0){
            if(groupPosition.y <= 0){
                availableDirections.remove(at: 5)
                availableDirections.remove(at: 3)
                availableDirections.remove(at: 2)
                availableDirections.remove(at: 1)
                availableDirections.remove(at: 0)
            }
            else if(groupPosition.y >= map.mapSize - 1){
                availableDirections.remove(at: 7)
                availableDirections.remove(at: 6)
                availableDirections.remove(at: 5)
                availableDirections.remove(at: 3)
                availableDirections.remove(at: 0)
            }
            else{
                availableDirections.remove(at: 5)
                availableDirections.remove(at: 3)
                availableDirections.remove(at: 0)
            }
        }
        else if (groupPosition.x >= map.mapSize - 1){
            if(groupPosition.y <= 0){
                availableDirections.remove(at: 7)
                availableDirections.remove(at: 4)
                availableDirections.remove(at: 2)
                availableDirections.remove(at: 1)
                availableDirections.remove(at: 0)
            }
            else if(groupPosition.y >= map.mapSize - 1){
                availableDirections.remove(at: 7)
                availableDirections.remove(at: 6)
                availableDirections.remove(at: 5)
                availableDirections.remove(at: 4)
                availableDirections.remove(at: 2)
            }
            else{
                availableDirections.remove(at: 7)
                availableDirections.remove(at: 4)
                availableDirections.remove(at: 2)
            }
        }
        else{
            if(groupPosition.y <= 0){
                availableDirections.remove(at: 2)
                availableDirections.remove(at: 1)
                availableDirections.remove(at: 0)
            }
            else if(groupPosition.y >= map.mapSize - 1){
                availableDirections.remove(at: 7)
                availableDirections.remove(at: 6)
                availableDirections.remove(at: 5)
            }
        }
        return availableDirections
    }
}
