//
//  ViewController.swift
//  CoreNFC-Demo
//
//  Created by isaoeka on 2018/07/14.
//  Copyright © 2018年 isaoeka. All rights reserved.
//

import UIKit
import CoreNFC

class ViewController: UIViewController, NFCNDEFReaderSessionDelegate {
    var session: NFCNDEFReaderSession?
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - NFCNDEFReaderSessionDelegate
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print("error:\(error.localizedDescription)")
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        
        var result = ""
        for payload in messages[0].records {
            result += String.init(data: payload.payload.advanced(by: 3), encoding: .utf8)!
        }
        DispatchQueue.main.async {
            self.messageLabel.text = result
        }
    }
    
    // MARK: - UI Action
    @IBAction func nfcBtnAction(_ button: Any) {
        if NFCNDEFReaderSession.readingAvailable {
            session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: false)
            session?.alertMessage = "NFCタグをiPhoneに近づけてください"
            session?.begin()
        } else {
            print("NFCが使えません")
        }
    }
}
