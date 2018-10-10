//
//  ViewController.swift
//  GroupedMessages
//
//  Created by danica on 10/6/18.
//  Copyright © 2018 danica. All rights reserved.
//

import UIKit

struct ChatMessage {
    let text: String
    let isIncoming: Bool
    let date: Date
}

extension Date {
    static func dateFromCustomString(customString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.date(from: customString) ?? Date()
    }
}

class ViewController: UITableViewController {
    
    fileprivate let cellId = "id12"
    
    //    let chatMessages = [
    //        [
    //            ChatMessage(text: "Here's my very first message!", isIncoming: true, date: Date.dateFromCustomString(customString: "10/03/2018")),
    //            ChatMessage(text: "Does he watch your favorite movies? Does he hold you when you cry?", isIncoming: true, date: Date.dateFromCustomString(customString: "10/03/2018")),
    //            ChatMessage(text: "Does he tell you all your favorite parts when you've seen them a million times? Does he sing to all your movies while you dance to purple rain? Does he do all these things like we used to?", isIncoming: false, date: Date.dateFromCustomString(customString: "10/03/2018"))
    //        ],
    //        [
    //            ChatMessage(text: "asas", isIncoming: false, date: Date.dateFromCustomString(customString: "10/04/2018"))
    //        ],
    //        [
    //            ChatMessage(text: "I am not really sure what I want to achieve here, but meh. It's alright, I guess.", isIncoming: true, date: Date.dateFromCustomString(customString: "10/05/2018")),
    //            ChatMessage(text: "You even want a longer message? How would I do that? I want to post this on my GitHub, and start learning iOS programming. So much stuff to learn though. I'm not sure how I'm going to fit a 9-6 work and then studying data structures and iOS programming. Time management who? Discipline who?", isIncoming: false, date: Date.dateFromCustomString(customString: "10/05/2018"))
    //        ]
    //    ]
    
    let messagesFromServer = [
        ChatMessage(text: "Here's my very first message!", isIncoming: true, date: Date.dateFromCustomString(customString: "10/03/2018")),
        ChatMessage(text: "Does he watch your favorite movies? Does he hold you when you cry?", isIncoming: true, date: Date.dateFromCustomString(customString: "10/03/2018")),
        ChatMessage(text: "Does he tell you all your favorite parts when you've seen them a million times? Does he sing to all your movies while you dance to purple rain? Does he do all these things like we used to?", isIncoming: false, date: Date.dateFromCustomString(customString: "10/03/2018")),
        ChatMessage(text: "asas", isIncoming: false, date: Date.dateFromCustomString(customString: "10/04/2018")),
        ChatMessage(text: "I am not really sure what I want to achieve here, but meh. It's alright, I guess.", isIncoming: true, date: Date.dateFromCustomString(customString: "10/05/2018")),
        ChatMessage(text: "You even want a longer message? How would I do that? I want to post this on my GitHub, and start learning iOS programming. So much stuff to learn though. I'm not sure how I'm going to fit a 9-6 work and then studying data structures and iOS programming. Time management who? Discipline who?", isIncoming: false, date: Date.dateFromCustomString(customString: "10/05/2018"))
    ]
    
    var chatMessages = [[ChatMessage]]()
    
    fileprivate func attemptToAssembleGroupMessages() {
        let groupedMessages = Dictionary(grouping: messagesFromServer) { (element) -> Date in
            return element.date
        }
        
        let sortedKeys = groupedMessages.keys.sorted()
        sortedKeys.forEach{ (key) in
            let values = groupedMessages[key]
            chatMessages.append(values ?? [])
        }
        
        //        groupedMessages.keys.forEach{ (key) in
        //            let values = groupedMessages[key]
        //            chatMessages.append(values ?? [])
        //        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attemptToAssembleGroupMessages()
        
        navigationItem.title = "Messages"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(ChatMessageCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return chatMessages.count
    }
    
    class DateHeaderLabel: UILabel {
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = .black
            textColor = .white
            textAlignment = .center
            translatesAutoresizingMaskIntoConstraints = false
            font = UIFont.boldSystemFont(ofSize: 14)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override var intrinsicContentSize: CGSize {
            let originalContentSize = super.intrinsicContentSize
            let height = originalContentSize.height + 12
            layer.cornerRadius = height / 2
            layer.masksToBounds = true
            return CGSize(width: originalContentSize.width + 16, height: height)
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let firstMessageInSection = chatMessages[section].first {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            let dateString = dateFormatter.string(from: firstMessageInSection.date)
            
            let label = DateHeaderLabel()
            label.text = dateString
            
            let containerView = UIView()
            containerView.addSubview(label)
            label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
            label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
            
            return containerView
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    //    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //        if let firstMessageInSection = chatMessages[section].first {
    //            let dateFormatter = DateFormatter()
    //            dateFormatter.dateFormat = "MM/dd/yyyy"
    //            let dateString = dateFormatter.string(from: firstMessageInSection.date)
    //            return dateString
    //        }
    //        return "Section: \(Date())"
    //    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ChatMessageCell
        //        let chatMessage = chatMessages[indexPath.row]/
        
        
        let chatMessage = chatMessages[indexPath.section][indexPath.row]
        cell.chatMessage = chatMessage
        
        //        cell.messageLabel.text = chatMessage.text
        //        cell.isIncoming = chatMessage.isIncoming
        
        //        cell.isIncoming = indexPath.row % 2 == 0
        return cell
    }
}


