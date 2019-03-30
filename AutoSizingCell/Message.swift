//
//  Message.swift
//  AutoSizingCell
//
//  Created by huangkun on 2019/3/30.
//  Copyright © 2019 huangkun. All rights reserved.
//

import UIKit

struct Message {
    
    let user: String
    let text: String
    
    struct Avatar {
        static let name: String = "avatar"
        static let size: CGFloat = 44
    }
    
    static func load() -> [Message] {
        let path = Bundle.main.path(forResource: "Messages", ofType: "json")!
        let url = URL(fileURLWithPath: path)
        let data = try! Data(contentsOf: url)
        let messageObjects = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [[String: String]]
        return messageObjects.map { Message(user: $0["user"]!, text: $0["text"]!) }
    }
}
