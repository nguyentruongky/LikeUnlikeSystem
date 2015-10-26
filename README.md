# LikeUnlikeSystem
Like system with like or unlike function: same to facebook 

I created a custom view with like and unlike button. You can easily use to like or unlike for a post. 

Now we walk step by step to create your own like control 

1. Create your custom view, name: LikeControl.xib

		New\User Interface\View
		
2. Design anything you want. I only drag and drop 2 buttons: Like and Dislike

3. Create a swift file to connect and control your UI, name: LikeControl.swift
		
		New\Source\Cocoa Touch Class\
		
	Make sure you select `Subclass of ` value is `UIView`
	
4. Select your LikeControl.xib, select File's Owner, select Identity Inspector in Utitlities pane. Fill the class value with `LikeControl`

5. Select LikeControl.xib, press Command Option Return to open Assistant. Drag and drop 2 buttons into LikeControl.swift to create 2 outlets and 2 actions. 

		@IBOutlet private weak var likeButton: UIButton!
	    
	    @IBOutlet private weak var dislikeButton: UIButton!
	    
	    @IBAction func likeAction(sender: AnyObject) {
	        
	    }
	    
	    @IBAction func dislikeAction(sender: AnyObject) {
	       
	    }
    
6. Write some new code. It will use for most of your custom view. Note it and copy paste when you want :D 

		var view: UIView!
		    
	    override init(frame: CGRect) {
	
	        super.init(frame: frame)
	        
	        xibSetup()
	    }
	    
	    required init?(coder aDecoder: NSCoder) {
	        
	        super.init(coder: aDecoder)
	        
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

7. Create your new enum name LikeStatus

		enum LikeState {
		    
		    case Like, Dislike, Unknown
		}

8. Some properties you need

		private var totalLike = 0
	    
	    private var totalDislike = 0
	    
	    // Every user will have 1 like or dislike turn. 
	    // So like value = 1 => dislike value = 1 - likeValue 
	    private var myLike = 0
	    
	    private var likeState = LikeState.Unknown

9. Some properties you will use in Storyboard. Total like and dislike of this post: get from your server and set here

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
10. Add `@IBDesignable` to `class LikeControl: UIView` to force storyboard auto update what you did on your view. 

11. Now add some codes for likeAction and dislikeAction

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
	    
12. Some more code to update UI

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

Now is the time enjoy your work. 

Open your storyboard and add some views. Open Identity Inspector and change `Class` value to LikeControl. Next to Attributes inspector, set different value for `Number of like` and `Number of dislike`.

Run your app, press like or dislike button on any views and enjoy. 

You can learn clearly about creating subclass from XIB file [here](http://iphonedev.tv/blog/2014/12/15/create-an-ibdesignable-uiview-subclass-with-code-from-an-xib-file-in-xcode-6)
