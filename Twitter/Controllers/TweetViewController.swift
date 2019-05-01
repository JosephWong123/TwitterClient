//
//  TweetViewController.swift
//  Twitter
//
//  Created by Joseph Wong on 4/30/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var characterCount: UILabel!
    @IBOutlet weak var tweetTextView: UITextView!
    var tweetLength : Int = 0
    let tweetLimit : Int = 140 // constant
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextView.delegate = self
        characterCount.text = "\(tweetLength)/\(tweetLimit) characters"
        // Do any additional setup after loading the view.
    }
    
    func textViewDidChange(_ textView: UITextView) {
        tweetLength = tweetTextView.text.count
        characterCount.text = "\(tweetLength)/\(tweetLimit) characters"
        
        if tweetLength > tweetLimit {
            characterCount.textColor = UIColor.red
        }
        else {
            characterCount.textColor = UIColor.black
        }
    }
    

    @IBAction func cancelTweet(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func doTweet(_ sender: Any) {
        if (!tweetTextView.text.isEmpty) {
            if (tweetLength <= tweetLimit) {
                TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success: {
                    self.dismiss(animated: true, completion: nil)
                }, failure: { (error) in
                    print("Error posting tweet \(error)")
                    self.dismiss(animated: true, completion: nil)
                })
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
