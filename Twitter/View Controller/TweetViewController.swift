//
//  TweetViewController.swift
//  Twitter
//
//  Created by Trang Do on 10/2/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var remainingChar: UILabel!
    var remaining: Int = 280
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tweetTextView.becomeFirstResponder()
        tweetTextView.delegate = self
        tweetTextView.text = "What's happening?"
        remainingChar.text = "Remaining Characters: 280"
        tweetTextView.font = UIFont(name: "Chalkboard SE", size: 24)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tweet(_ sender: Any) {
        if (!tweetTextView.text.isEmpty) {
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (error) in
                print("Error posting tweet \(error)")
                self.dismiss(animated: true, completion: nil)
            })
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        tweetTextView.text = ""
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let characterLimit: Int = 280
        
        //Construct what the new text would be if we allowed the user's latest edit
        let newText = NSString(string: tweetTextView.text!).replacingCharacters(in: range, with: text)
        remaining = characterLimit - newText.count
        if (remaining == 0 || remaining == 1) {
            remainingChar.text = "Remaining Character: \(remaining)"
        } else {
            remainingChar.text = "Remaining Characters: \(remaining)"
        }
        return newText.count < characterLimit
        
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
