//
//  MsgTableCell.swift
//  AutoSizingCell
//
//  Created by huangkun on 2019/3/30.
//  Copyright © 2019 huangkun. All rights reserved.
//

import UIKit

class MsgTableCell: UITableViewCell {
    
    private var userView: UIStackView!
    private var avatarView: UIImageView!
    private var nameLabel: UILabel!
    private var messageLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        // avatar
        avatarView = UIImageView(image: UIImage(named: Message.Avatar.name))
        
        // name
        nameLabel = UILabel()
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
        nameLabel.backgroundColor = UIColor.yellow

        // user vertical stack
        userView = UIStackView(arrangedSubviews: [avatarView, nameLabel])
        userView.axis = .vertical
        userView.alignment = .center
        userView.distribution = .fill
        userView.spacing = 5
        contentView.addSubview(userView)
        
        // message
        messageLabel = UILabel()
        messageLabel.numberOfLines = 0
        messageLabel.backgroundColor = UIColor.green
        contentView.addSubview(messageLabel)
    }
    
    private func setupConstraints() {
        // avatar
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        let avatarWidth = avatarView.widthAnchor.constraint(equalToConstant: Message.Avatar.size)
        let avatarHeight = avatarView.heightAnchor.constraint(equalToConstant: Message.Avatar.size)
        let avatarConstraints = [avatarWidth, avatarHeight]
        
        // name
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        let nameWidth = nameLabel.widthAnchor.constraint(equalToConstant: 80)
        let nameConstraints = [nameWidth]

        // user stack
        userView.translatesAutoresizingMaskIntoConstraints = false
        let userTop = userView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10)
        let userLeft = userView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10)
        let userBottom = userView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -5)
        let userConstraints = [userTop, userLeft, userBottom]
        
        // message
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        let messageTop = messageLabel.topAnchor.constraint(equalTo: userView.topAnchor)
        let messageLeft = messageLabel.leftAnchor.constraint(equalTo: userView.rightAnchor, constant: 5)
        let messageRight = messageLabel.rightAnchor.constraint(lessThanOrEqualTo: contentView.rightAnchor, constant: -5)
        let messageBottom = messageLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -5)
        let messageConstraints = [messageTop, messageLeft, messageRight, messageBottom]
        
        NSLayoutConstraint.activate(avatarConstraints + nameConstraints + userConstraints + messageConstraints)
    }
    
    func setMessage(_ message: Message) {
        nameLabel.text = message.user
        messageLabel.text = message.text
    }
}
