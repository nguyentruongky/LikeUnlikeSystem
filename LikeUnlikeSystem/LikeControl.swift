//
//  LikeControl.swift
//  LikeUnlikeSystem
//
//  Created by Ky Nguyen on 10/26/15.
//  Copyright © 2015 Ky Nguyen. All rights reserved.
//

import UIKit

@IBDesignable class LikeControl: UIView {

    @IBInspectable var numberOfLike : Int {
        
        get {
            
            return totalLike
        }
        set (likeTime) {
            
            totalLike = likeTime
            setButtonTitle(likeButton, title: "\(likeTime) like(s)")
            likeButton.sizeToFit()
        }
    }
    
    @IBInspectable var numberOfDislike : Int {
        
        get {
            
            return totalDislike
        }
        set (dislikeTime) {
            
            totalDislike = dislikeTime
            setButtonTitle(dislikeButton, title: "\(dislikeTime) dislike(s)")
            dislikeButton.sizeToFit()
        }
    }
    
    private var totalLike = 0
    
    private var totalDislike = 0
    
    private var myLike = 0
    
    private var likeState = LikeState.Unknown
    
    @IBOutlet private weak var likeButton: UIButton!
    
    @IBOutlet private weak var dislikeButton: UIButton!
    
    @IBAction func likeAction(sender: AnyObject) {
        
        switch likeState {
            
        case .Unknown, .Dislike:
            
            myLike++
            
            likeState = .Like
            likeButton.selected = true
            dislikeButton.selected = false
            
        case .Like:
            
            myLike = 0
            
            likeState = .Unknown
            likeButton.selected = false
        }
        
        updateUI()
    }
    
    @IBAction func dislikeAction(sender: AnyObject) {
        
        switch likeState {
            
        case .Unknown, .Like:
            
            myLike = 0
            
            likeState = .Dislike
            dislikeButton.selected = true
            likeButton.selected = false
            
        case .Dislike:
            
            likeState = .Unknown
            dislikeButton.selected = false
        }
        
        updateUI()
    }
    
    var view: UIView!
    
    override init(frame: CGRect) {
        // 1. setup any properties here
        
        // 2. call super.init(frame:)
        super.init(frame: frame)
        
        // 3. Setup view from .xib file
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        // 1. setup any properties here
        
        // 2. call super.init(coder:)
        super.init(coder: aDecoder)
        
        // 3. Setup view from .xib file
        xibSetup()
    }
    
    func xibSetup() {
        view = loadViewFromNib()
        
        view.frame = bounds
        
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]

        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "LikeControl", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        return view
    }
    
    
    private func updateUI() {
        
        if likeState == LikeState.Unknown {
            
            setButtonTitle(likeButton, title: "\(numberOfLike) like(s)")
            setButtonTitle(dislikeButton, title: "\(numberOfDislike) dislike(s)")
        }
        else {
            
            setButtonTitle(likeButton, title: "\(numberOfLike + myLike) like(s)")
            setButtonTitle(dislikeButton, title: "\(numberOfDislike + 1 - myLike) dislike(s)")
        }
        
        
    }
    
    private func setButtonTitle(button: UIButton, title: String) {
        
        button.setTitle(title, forState: UIControlState.Normal)
    }

}

enum LikeState {
    
    case Like, Dislike, Unknown
}
