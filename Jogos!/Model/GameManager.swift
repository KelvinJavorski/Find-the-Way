//
//  GameManager.swift
//  Jogos!
//
//  Created by Kaz Born on 27/11/19.
//  Copyright © 2019 Kelvin Javorski Soares. All rights reserved.
//

import Foundation
import UIKit

enum directions {
    case north
    case south
    case east
    case west
    case northeast
    case southeast
    case northwest
    case southwest
    case on
}

class GameManager {
    
    static let shared = GameManager()
    
    var players         : [Player] = []
    var navigator		: Navigator = Navigator()
    var currentPlayer 	: Player!
    var numberOfPlayers : Int = 0
    var dayTurnsLeft 	: Int!
    var playersInfoLeft : Int!
    var numberOfPlaces  : Int = 8
    
    enum gameStates {
        case settingup
        case initialInfo
        case dayCycle
        case nightCycle
        case ended
    }
    
    var gameState : gameStates = .settingup
    
    // >>>---------> GAME START
    
    func setupGame (playerNames: [String]) {
        //Generate new map
        navigator.initialize(mapSize: 7, groupPosition: Position(x: 3, y: 3))
        
        // Create Players from names array
        players = setupPlayers(playerNames: playerNames)
        numberOfPlayers = playerNames.count
        
        // Reset Turns Left
        dayTurnsLeft = numberOfPlayers * 3
        playersInfoLeft = numberOfPlayers
        
        // Set game state
        gameState = .initialInfo
    }
    
    func setupPlayers(playerNames: [String]) -> [Player]{
        
        var listOfPlayers : [Player] = []
        
        let listOfAlignments = randomizeAlignment(numberOfPlayers: playerNames.count)
        let listOfPlaces = searchMiscAndSafePlaces()
        let eachPlayersPlace = defineEachPlayerPlaces(alignmentOrder: listOfAlignments, listOfPlaces: listOfPlaces)
        
        //Define both places for each player before initialize
        
        for (index, name) in playerNames.enumerated(){
            let place1 = eachPlayersPlace[index][0]
            let place2 = eachPlayersPlace[index][1]
            
            let player = Player(infos: [
                .name: name,
                .alignment: listOfAlignments[index],
                .firstPlace: place1,
                .secondPlace: place2,
                .distanceBetweenPlaces: navigator.distanceBetween(from: navigator.groupPosition, to: Position(x: place1.position.x, y: place1.position.y)),
                .directionToSecondPlace: navigator.directionBetween(from: Position(x: place1.position.x, y: place1.position.y), to: Position(x: place2.position.x, y: place2.position.y))
            ])
            
            listOfPlayers.append(player)
        }
        return listOfPlayers
    }
    
    func searchMiscAndSafePlaces() -> [[Place]]{
        var listOfObjects = [[Place]]()
        let matrix = navigator.map
        listOfObjects.append([Place]())
        listOfObjects.append([Place]())
        for i in (0...(matrix.mapSize - 1)) {
            
            for j in (0...(matrix.mapSize - 1)) {
                if (matrix.mapMatrix[i][j]!.type == .misc) {
                    listOfObjects[0].append(matrix.mapMatrix[i][j]!)
                }
                else if (matrix.mapMatrix[i][j]!.type == .safehouse) {
                    
                    listOfObjects[1].append(matrix.mapMatrix[i][j]!)
                }
            }
        }
        return listOfObjects
    }
    
    func defineEachPlayerPlaces(alignmentOrder : [Player.alignments], listOfPlaces : [[Place]]) -> [[Place]]{
        var randomList = listOfPlaces[0].shuffled()
        var playersPlaceList = [[Place]]()
        
        for (index, alignment) in alignmentOrder.enumerated(){
            //Define first place for murderer
            playersPlaceList.append([Place]())
            if (alignment == .murderer){
                playersPlaceList[index].append(listOfPlaces[1][0])
            }
                //Define first place for non murderers
            else{
                let nextPlace = randomList[0]
                randomList.remove(at: 0)
                playersPlaceList[index].append(nextPlace)
            }
            //Define second place for players
            let nextPlace = randomList[0]
            randomList.remove(at: 0)
            playersPlaceList[index].append(nextPlace)
        }
        
        return playersPlaceList
    }
    
    func hasShownPlayerInfo () {
        playersInfoLeft -= 1
        
        if playersInfoLeft <= 0 {
            gameState = .dayCycle
        }
    }
    
    // >>>---------> DURING THE GAME
    
    
    
    func nextTurn (direction: directions) {
        
        navigator.moveGroup(to: direction)
        let newPlace = navigator.groupPlace().type
        
        if newPlace == .safehouse {
            endGame(winner: .inocent)
            return
        }
        dayTurnsLeft -= 1
        if hasGameEnded() {
            endGame(winner: .murderer)
        }
        
        // check next position on map
        
        // if trap OR safehouse {
        //    device on the table -> end game
        // } else {
        //    pass the device -> new place info
        //	  reset timer
        //    turnsLeft -= 1
        // }
        
    }
    
    func hasGameEnded () -> Bool {
        if dayTurnsLeft <= 0 {
            gameState = .ended
            return true
        }
        return false
    }
    
    func randomizeAlignment (numberOfPlayers : Int) -> [Player.alignments]
    {
        let innocent = Player.alignments.innocent
        let murderer = Player.alignments.murderer
        let sequenceOfAlignments = [innocent, murderer, innocent, innocent]
        
        return sequenceOfAlignments.shuffled()
    }
    
    func getNextPlayer () -> Player {
        
        // Array cycles through the players so
        // the next player is always at index 0
        let nextPlayer = self.players[0]
        
        self.players.remove(at: 0)
        self.players.append(nextPlayer)
        currentPlayer = nextPlayer
        
        return nextPlayer
    }
    
    // >>>---------> GAME ENDING
    
    private init(){}
    
    enum winners {
        case murderer
        case inocent
    }
    
    var winner : winners!
    
    func endGame (winner : winners ) {
        
    }
    
    // >>>-----------> CONTENT
    
    let innocentObjective = "You were visiting the Island with a group of tourists when you got lost.\nFind the BOAT that took you here before nightfall to save yourself."
    
    let murdererObjective = ""
    
    let normalTextAtributes : [NSAttributedString.Key:Any] =
        [.backgroundColor: UIColor.init(white: 1.0, alpha: 0.0),
         NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20.0, weight: .thin)]//UIFont.init(name: ".SFProText-Thin", size: 20.0) as Any] UIFont.systemFont(ofSize: 20.0, weight: .regular)]
    
    let boldTextAttributes : [NSAttributedString.Key:Any] =
        [.backgroundColor: UIColor.init(white: 1.0, alpha: 0.0),
         NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20.0, weight: .semibold)]
    
    
    func getAttrStrObjective (objective: String) -> NSMutableAttributedString {
        
        let attributedStr = NSMutableAttributedString(string: objective, attributes: normalTextAtributes)
        
        let range : NSRange = NSString(string: objective).range(of: "BOAT")
        
        attributedStr.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 20.0, weight: .semibold), range: range)
        
        return attributedStr
    }
    
    func getAttrStrUpdatedObj(obj: Place) -> NSMutableAttributedString {
        
        let distance = navigator.distanceBetween(from: navigator.groupPosition, to: obj.position)
        let direction = navigator.directionBetween(from: navigator.groupPosition, to: obj.position)
        
        let attrStr = NSMutableAttributedString(string: "You see the \n", attributes: normalTextAtributes)
        attrStr.append(NSAttributedString(string: obj.name, attributes: boldTextAttributes))
        attrStr.append(NSAttributedString(string: String(format: " %d km to the ", distance), attributes: normalTextAtributes))
        attrStr.append(NSAttributedString(string: directionToStr(direction: direction), attributes: boldTextAttributes))
        attrStr.append(NSAttributedString(string: ".", attributes: normalTextAtributes))
        
        return attrStr
    }
    
    func getAttrStrSecondObject (firstObj: Place, secondObj: Place) -> NSMutableAttributedString {
        
        let direction = navigator.directionBetween(from: firstObj.position, to: secondObj.position)
        let distance  = navigator.distanceBetween(from: firstObj.position, to: secondObj.position)
        
        let attrStr  = NSMutableAttributedString(string: "You remember that\n", attributes: normalTextAtributes)
        attrStr.append(NSAttributedString(string: String(format: "%d km to the ", distance)))
        attrStr.append(NSAttributedString(string: directionToStr(direction: direction)))
        attrStr.append(NSAttributedString(string: " of the ", attributes: normalTextAtributes))
        attrStr.append(NSAttributedString(string: firstObj.name, attributes: boldTextAttributes))
        attrStr.append(NSAttributedString(string: " is the ", attributes: normalTextAtributes))
        attrStr.append(NSAttributedString(string: secondObj.name, attributes: boldTextAttributes))
        attrStr.append(NSAttributedString(string: ".", attributes: normalTextAtributes))
        
        return attrStr
    }
    
    func directionToStr (direction: directions) -> String {
        switch direction {
        case .north:
            return "NORTH"
        case .south:
            return "SOUTH"
        case .east:
            return "EAST"
        case .west:
            return "WEST"
        case .northeast:
            return "NORTHEAST"
        case .northwest:
            return "NORTHWEST"
        case .southeast:
            return "SOUTHEAST"
        case .southwest:
            return "SOUTHWEST"
        case .on:
            return "ON"
        }
    }
    
    
    
}
