//
//  ChatMessageCell.swift
//  GroupedMessages
//
//  Created by danica on 10/6/18.
//  Copyright © 2018 danica. All rights reserved.
//

import UIKit

class ChatMessageCell: UITableViewCell {
    let messageLabel = UILabel()
    let bubbleBackgroundView = UIView()
    
    var leadingConstraint: NSLayoutConstraint!
    var trailingConstraint: NSLayoutConstraint!
    
    
    var chatMessage: ChatMessage! {
        didSet {
            bubbleBackgroundView.backgroundColor = chatMessage.isIncoming ? .white : .darkGray
            messageLabel.textColor = chatMessage.isIncoming ? .black : .white
            
            messageLabel.text = chatMessage.text
            if chatMessage.isIncoming {
                leadingConstraint.isActive = true
                trailingConstraint.isActive = false
            }else{
                leadingConstraint.isActive = false
                trailingConstraint.isActive = true
            }
        }
    }
    
//    var isIncoming: Bool! {
//        didSet {
//            bubbleBackgroundView.backgroundColor = isIncoming ? .white : .darkGray
//            messageLabel.textColor = isIncoming ? .black : .white
//        }
//    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        bubbleBackgroundView.backgroundColor = .yellow
        bubbleBackgroundView.layer.cornerRadius = 16
        bubbleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bubbleBackgroundView)
        
        
        
        addSubview(messageLabel)
//        messageLabel.backgroundColor = .green
        messageLabel.text = "Right now I'm in the state of mind I wanna be in like all the time ain't got no tears left to cry"
        messageLabel.numberOfLines = 0
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //constraints setup
        let constraints = [messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            
            bubbleBackgroundView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -16),
            bubbleBackgroundView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -16),
            bubbleBackgroundView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16),
            bubbleBackgroundView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 16)
        
        ]
        NSLayoutConstraint.activate(constraints)
        
        leadingConstraint  = messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 28)
//        leadingConstraint.isActive = false
        
        trailingConstraint = messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
//        trailingConstraint.isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
