//
//  SocketIOManager.swift
//  aimalaif
//
//  Created by Oriol Marí Marqués on 04/03/2017.
//  Copyright © 2017 Oriol Marí Marqués. All rights reserved.
//

import UIKit

class SocketIOManager: NSObject {
    static let sharedInstance = SocketIOManager()

    var socket: SocketIOClient = SocketIOClient(socketURL: NSURL(string: "http://10.192.243.26:4200")! as URL)
    
    func establishConnection(room: String, uuid: String, dni: String) {
        socket.connect()
        socket.on("connect") {data, ack in
            self.socket.emit("room", room, uuid, dni)
        }
    }
    
    func sendMessage(message: String, withNickname nickname: String) {
        socket.emit("chatMessage", nickname, message)
    }
    
    func getChatMessage(completionHandler: @escaping (_ messageInfo: [String: AnyObject]) -> Void) {
        socket.on("newChatMessage") { (dataArray, socketAck) -> Void in
            var messageDictionary = [String: AnyObject]()
            messageDictionary["nickname"] = dataArray[0] as! String as AnyObject?
            messageDictionary["message"] = dataArray[1] as! String as AnyObject?
            messageDictionary["date"] = dataArray[2] as! String as AnyObject?
            
            completionHandler(messageDictionary)
        }
    }

    
    func submitInformation(dni: String, name: String, health: String, contactInfo: String, obs: String ) {
        socket.emit("survivor", dni, name, health, contactInfo, obs)
    }
    
    
    func searchPerson(dni: String, name: String) {
        socket.emit("searchperson", dni, name)
    }
    
    
    func searchResult(completionHandler: @escaping (_ result: [Any]) -> Void) {
        socket.on("searchresult") { (dataArray, ack) -> Void in
        completionHandler(dataArray)
        }
    }
    
    
    func closeConnection() {
        socket.disconnect()
    }
    
    
    func updateLocation(uuid: String, dni: String, status: String, lat: String, long: String) {
        socket.emit("updatelocation", uuid, dni, status, lat, long)
    }
                      
}
