//
//  MoosnickHomeViewController.swift
//  Moosnick
//
//  Created by Ganesh Tulshibagwale on 4/4/18.
//  Copyright © 2018 Ganesh Tulshibagwale. All rights reserved.
//  References:
//  https://developer.apple.com/library/content/documentation/DeviceInformation/Reference/iOSDeviceCompatibility/Displays/Displays.html
//  http://swiftdeveloperblog.com/add-subview-and-remove-subview-example-in-swift/
//  https://www.appcoda.com/uiscrollview-introduction/
//  https://stackoverflow.com/questions/5843427/how-do-you-add-an-action-to-a-button-programmatically-in-xcode
//  https://stackoverflow.com/questions/4628800/android-how-to-check-if-a-view-inside-of-scrollview-is-visible
//  https://developer.apple.com/documentation/uikit/uiview/1622469-hittest
//  https://www.youtube.com/watch?v=BnGf01O4NUw
//  https://www.hackingwithswift.com/example-code/calayer/how-to-add-a-border-outline-color-to-a-uiview
//  https://stackoverflow.com/questions/17721934/circular-uiimageview-in-uitableview-without-performance-hit

import UIKit

class MoosnickHomeViewController: UIViewController {
    
    /*
     This screen serves as a sort of welcome screen to the app. There are two major features, named advertPicFlipper and topicScrollView.
     advertPicFlipper lets the user scroll horizontally through the set of pictures given in the UIImage array advertPics, or scrolls
     automatically through them absent manual input.
     The other major feature, topicScrollView, is much the same but with buttons instead of images and no autoscrolling. The buttons
     connect to different topics the user may be interested in and serve to navigate through the app.
     */
    
    var advertPicFlipper: UIScrollView!
    var advertPicPageControl: UIPageControl!
    var topicScrollView: UIScrollView!
    
    let advertPicFlipperFrame = CGRect(x: 0, y: 20, width: 768, height: 594) //this is where advertPicFlipper and topicScrollFrame go;
    let topicScrollFrame = CGRect(x: 0, y: 614, width: 768, height: 410) //the values get used to calculate a lot of other frames
    
    let advertPics: [UIImage] = [#imageLiteral(resourceName: "day"), #imageLiteral(resourceName: "skull"), #imageLiteral(resourceName: "buttsmoke"), #imageLiteral(resourceName: "deadbabies")]
    let topicPics: [UIImage] = [#imageLiteral(resourceName: "jamie_day"), #imageLiteral(resourceName: "WaxVenusFullBody_sm"), #imageLiteral(resourceName: "moose3"), #imageLiteral(resourceName: "moose4"), #imageLiteral(resourceName: "moose5"), #imageLiteral(resourceName: "moose6"), #imageLiteral(resourceName: "moose7")]
    let topicTitles: [String] = ["Intro", "Anatomy", "Moos", "One Moos", "Two Moos", "Red Moos", "Blue Moos"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //sets up advertPicFlipper, its frame and background color and so on
        advertPicFlipper = UIScrollView(frame: advertPicFlipperFrame)
        advertPicFlipper.backgroundColor = UIColor.white
        advertPicFlipper.isPagingEnabled = true
        advertPicFlipper.contentSize = CGSize (width: (advertPicFlipper.frame.width * CGFloat(advertPics.count)), height: advertPicFlipper.frame.height)
        advertPicFlipper.showsHorizontalScrollIndicator = false
        
        //populates advertPicFlipper with images from advertPics
        let newPicSize = CGSize(width: advertPicFlipper.frame.width, height: advertPicFlipper.frame.height)
        for index in 0...(advertPics.count - 1) {
            let newPicOrigin = CGPoint(x: (advertPicFlipper.frame.width * CGFloat(index)), y: 0)
            let newAdvertPic = UIImageView(frame: CGRect(origin: newPicOrigin, size: newPicSize))
            newAdvertPic.image = advertPics[index]
            advertPicFlipper.addSubview(newAdvertPic)
        }
        
        //older and fuglier way of populating advertPicFlipper preserved in case I forgot something
        /*
         let advertPic1: UIImageView = UIImageView(frame: CGRect(x: (advertPicFlipperFrame.width*0), y: 0, width: advertPicFlipperFrame.width, height: advertPicFlipperFrame.height))
         advertPic1.image = advertPics[0]
         advertPicFlipper.addSubview(advertPic1)
         let advertPic2: UIImageView = UIImageView(frame: CGRect(x: (advertPicFlipperFrame.width*1), y: 0, width: advertPicFlipperFrame.width, height: advertPicFlipperFrame.height))
         advertPic2.image = advertPics[1]
         advertPicFlipper.addSubview(advertPic2)
         let advertPic3: UIImageView = UIImageView(frame: CGRect(x: (advertPicFlipperFrame.width*2), y: 0, width: advertPicFlipperFrame.width, height: advertPicFlipperFrame.height))
         advertPic3.image = advertPics[2]
         advertPicFlipper.addSubview(advertPic3)
         let advertPic4: UIImageView = UIImageView(frame: CGRect(x: (advertPicFlipperFrame.width*3), y: 0, width: advertPicFlipperFrame.width, height: advertPicFlipperFrame.height))
         advertPic4.image = advertPics[3]
         advertPicFlipper.addSubview(advertPic4)
         */
        
        //this is those little dots at the bottom that tell you which page you're on
        advertPicPageControl = UIPageControl(frame: CGRect(x: 0, y: advertPicFlipper.frame.height, width: advertPicFlipper.frame.width, height: 20))
        advertPicPageControl.numberOfPages = advertPics.count
        
        //sets the advertPicFlipper to flip to a new page every few seconds
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(advertPicFlipperScrollNext), userInfo: nil, repeats: true)
        
        //sets up the title card that says Moosnick Museum and gets placed on top of advertPicFlipper
        let moosnickTitleCard: UILabel = UILabel(frame: CGRect(x: 0, y: 250, width: advertPicFlipper.frame.width, height: 50))
        moosnickTitleCard.text = "Moosnick Museum"
        moosnickTitleCard.textAlignment = NSTextAlignment.center
        moosnickTitleCard.textColor = UIColor.white
        moosnickTitleCard.font = moosnickTitleCard.font.withSize(70)
        moosnickTitleCard.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        //sets up some basic stuff about topicScrollView
        topicScrollView = UIScrollView(frame: topicScrollFrame)
        topicScrollView.backgroundColor = UIColor.white
        topicScrollView.layer.borderWidth = 1
        topicScrollView.layer.borderColor = UIColor.red.cgColor
        topicScrollView.indicatorStyle = UIScrollViewIndicatorStyle.black
        
        //populates the topicScrollView with buttons
        //each button is in fact a UIButton, a UIImageView, and a UILabel that
        //just happen to be in the same area
        
        //these three values are used to calculate all the frames that follow
        let widthPerTopicButton = 390 //each button gets this much horizontal space
        let topicOffset = 100 //this is how much of that space is uninhabited
        let topicImageHeight = 310 //this is how much of the height is devoted to the picture, the remainder is the title
        
        topicScrollView.contentSize = CGSize(width: CGFloat(widthPerTopicButton * topicPics.count), height: topicScrollFrame.height)
        let topicButtonSize = CGSize(width: CGFloat(widthPerTopicButton - topicOffset), height: topicScrollView.frame.height)
        let topicImageSize = CGSize(width: topicButtonSize.width, height: CGFloat(topicImageHeight))
        let topicTitleSize = CGSize(width: topicButtonSize.width, height: topicButtonSize.height-topicImageSize.height)
        
        for index in 0...(topicPics.count - 1) {
            let newTopicElementsOrigin = CGPoint(x: ((widthPerTopicButton * index) + (topicOffset / 2)), y: 30)
            let newTopicTitleOrigin = CGPoint(x: newTopicElementsOrigin.x, y: topicImageSize.height)
            
            let newButtonFrame: CGRect = CGRect(origin: newTopicElementsOrigin, size: topicButtonSize)
            let newButton: UIButton = UIButton(frame: newButtonFrame)
            newButton.setTitle("\(index)", for: UIControlState.normal) //this is used for segue recognition
            newButton.addTarget(self, action: #selector(goToView(sender:)), for: UIControlEvents.touchUpInside) //this triggers the segue
            topicScrollView.addSubview(newButton)
            
            let newImageFrame: CGRect = CGRect(origin: newTopicElementsOrigin, size: topicImageSize)
            let newImage: UIImageView = UIImageView(frame: newImageFrame)
            newImage.image = topicPics[index]
            newImage.layer.cornerRadius = newImage.frame.width
            newImage.layer.masksToBounds = true
            topicScrollView.addSubview(newImage)
            
            let newTopicTitleFrame: CGRect = CGRect(origin: newTopicTitleOrigin, size: topicTitleSize)
            let newTopicTitle: UILabel = UILabel(frame: newTopicTitleFrame)
            newTopicTitle.text = topicTitles[index]
            newTopicTitle.textAlignment = NSTextAlignment.center
            newTopicTitle.font = newTopicTitle.font.withSize(30)
            topicScrollView.addSubview(newTopicTitle)
        }
        
        //The older and fuglier way of populating topicScrollView remains here in case I forgot something
        /*
         let topicButton1: UIButton = UIButton(frame: CGRect(x: 390*0, y: 0, width: 300, height: 390))
         topicButton1.setImage(#imageLiteral(resourceName: "moose1"), for: UIControlState.normal)
         topicButton1.addTarget(self, action: #selector (goToView), for: UIControlEvents.touchUpInside)
         topicScrollView.addSubview(topicButton1)
         topicButton1.setTitle("1", for: .normal)
         let topicLabel1: UILabel = UILabel(frame: CGRect(x: 390*0, y: 300, width: 300, height: 30))
         topicLabel1.text = "Animal"
         topicLabel1.textColor = UIColor.white
         topicLabel1.textAlignment = NSTextAlignment.center
         topicLabel1.font = topicLabel1.font.withSize(30)
         topicScrollView.addSubview(topicLabel1)
         let topicButton2: UIButton = UIButton(frame: CGRect(x: 390*1, y: 0, width: 300, height: 390))
         topicButton2.setImage(#imageLiteral(resourceName: "moose2"), for: UIControlState.normal)
         topicButton2.addTarget(self, action: #selector (goToView), for: UIControlEvents.touchUpInside)
         topicScrollView.addSubview(topicButton2)
         topicButton2.setTitle("2", for: .normal)
         let topicLabel2: UILabel = UILabel(frame: CGRect(x: 390*1, y: 300, width: 300, height: 30))
         topicLabel2.text = "Vegetable"
         topicLabel2.textColor = UIColor.white
         topicLabel2.textAlignment = NSTextAlignment.center
         topicLabel2.font = topicLabel2.font.withSize(30)
         topicScrollView.addSubview(topicLabel2)
         let topicButton3: UIButton = UIButton(frame: CGRect(x: 390*2, y: 0, width: 300, height: 390))
         topicButton3.setImage(#imageLiteral(resourceName: "moose3"), for: UIControlState.normal)
         topicButton3.addTarget(self, action: #selector (goToView), for: UIControlEvents.touchUpInside)
         topicScrollView.addSubview(topicButton3)
         topicButton3.setTitle("3", for: .normal)
         let topicLabel3: UILabel = UILabel(frame: CGRect(x: 390*2, y: 300, width: 300, height: 30))
         topicLabel3.text = "Mineral"
         topicLabel3.textColor = UIColor.white
         topicLabel3.textAlignment = NSTextAlignment.center
         topicLabel3.font = topicLabel3.font.withSize(30)
         topicScrollView.addSubview(topicLabel3)
         let topicButton4: UIButton = UIButton(frame: CGRect(x: 390*3, y: 0, width: 300, height: 390))
         topicButton4.setImage(#imageLiteral(resourceName: "moose4"), for: UIControlState.normal)
         topicButton4.addTarget(self, action: #selector (goToView), for: UIControlEvents.touchUpInside)
         topicScrollView.addSubview(topicButton4)
         topicButton4.setTitle("4", for: .normal)
         let topicLabel4: UILabel = UILabel(frame: CGRect(x: 390*3, y: 300, width: 300, height: 30))
         topicLabel4.text = "One Moose"
         topicLabel4.textColor = UIColor.white
         topicLabel4.textAlignment = NSTextAlignment.center
         topicLabel4.font = topicLabel4.font.withSize(30)
         topicScrollView.addSubview(topicLabel4)
         let topicButton5: UIButton = UIButton(frame: CGRect(x: 390*4, y: 0, width: 300, height: 390))
         topicButton5.setImage(#imageLiteral(resourceName: "moose5"), for: UIControlState.normal)
         topicButton5.addTarget(self, action: #selector (goToView), for: UIControlEvents.touchUpInside)
         topicScrollView.addSubview(topicButton5)
         topicButton5.setTitle("5", for: .normal)
         let topicLabel5: UILabel = UILabel(frame: CGRect(x: 390*4, y: 300, width: 300, height: 30))
         topicLabel5.text = "Two Moose"
         topicLabel5.textColor = UIColor.white
         topicLabel5.textAlignment = NSTextAlignment.center
         topicLabel5.font = topicLabel5.font.withSize(30)
         topicScrollView.addSubview(topicLabel5)
         let topicButton6: UIButton = UIButton(frame: CGRect(x: 390*5, y: 0, width: 300, height: 390))
         topicButton6.setImage(#imageLiteral(resourceName: "moose6"), for: UIControlState.normal)
         topicButton6.addTarget(self, action: #selector (goToView), for: UIControlEvents.touchUpInside)
         topicScrollView.addSubview(topicButton6)
         topicButton6.setTitle("6", for: .normal)
         let topicLabel6: UILabel = UILabel(frame: CGRect(x: 390*5, y: 300, width: 300, height: 30))
         topicLabel6.text = "Red Moose"
         topicLabel6.textColor = UIColor.white
         topicLabel6.textAlignment = NSTextAlignment.center
         topicLabel6.font = topicLabel6.font.withSize(30)
         topicScrollView.addSubview(topicLabel6)
         let topicButton7: UIButton = UIButton(frame: CGRect(x: 390*6, y: 0, width: 300, height: 390))
         topicButton7.setImage(#imageLiteral(resourceName: "moose7"), for: UIControlState.normal)
         topicButton7.addTarget(self, action: #selector (goToView), for: UIControlEvents.touchUpInside)
         topicScrollView.addSubview(topicButton7)
         topicButton7.setTitle("7", for: .normal)
         let topicLabel7: UILabel = UILabel(frame: CGRect(x: 390*6, y: 300, width: 300, height: 30))
         topicLabel7.text = "Blue Moose"
         topicLabel7.textColor = UIColor.white
         topicLabel7.textAlignment = NSTextAlignment.center
         topicLabel7.font = topicLabel7.font.withSize(30)
         topicScrollView.addSubview(topicLabel7)
         */
        
        //adds left and right arrows onto the topicScrollView
        //otherwise it's not obvious the thing is scrollable
        let scrollLeftLabelFrame: CGRect = CGRect(x: topicScrollView.frame.origin.x, y: topicScrollView.frame.origin.y, width: CGFloat(topicOffset/2), height: topicScrollView.frame.height)
        let scrollRightLabelFrame: CGRect = CGRect(x: (topicScrollView.frame.origin.x + topicScrollView.frame.width - CGFloat(topicOffset/2)), y: topicScrollView.frame.origin.y, width: CGFloat(topicOffset/2), height: topicScrollView.frame.height)
        let scrollLeftLabel: UILabel = UILabel(frame: scrollLeftLabelFrame)
        let scrollRightLabel: UILabel = UILabel(frame: scrollRightLabelFrame)
        scrollLeftLabel.text = "<"
        scrollRightLabel.text = ">"
        scrollLeftLabel.textAlignment = NSTextAlignment.center
        scrollRightLabel.textAlignment = NSTextAlignment.center
        scrollLeftLabel.backgroundColor = UIColor.white
        scrollRightLabel.backgroundColor = UIColor.white
        scrollLeftLabel.layer.borderWidth = 1
        scrollRightLabel.layer.borderWidth = 1
        scrollLeftLabel.layer.borderColor = UIColor.red.cgColor
        scrollRightLabel.layer.borderColor = UIColor.red.cgColor
        
        //adds all the different elements as subviews to the viewcontroller
        self.view.addSubview(advertPicFlipper)
        self.view.addSubview(moosnickTitleCard)
        self.view.addSubview(advertPicPageControl)
        self.view.addSubview(topicScrollView)
        self.view.addSubview(scrollLeftLabel)
        self.view.addSubview(scrollRightLabel)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //when the timer from the viewDidLoad function triggers, scroll to the next page in advertPicFlipper
    //if at the end, scroll back to the beginning
    //calculates current and next page from the position of advertPicPageControl
    //updates advertPicPageControl when done
    @objc func advertPicFlipperScrollNext() {
        let nextPageNumber = advertPicPageControl.currentPage + 1
        var nextPage: CGRect
        let nextPageSize = CGSize(width: advertPicFlipper.frame.width, height: advertPicFlipper.frame.height)
        if nextPageNumber >= advertPicPageControl.numberOfPages {
            let nextPageOrigin = CGPoint(x: 0, y: 0)
            nextPage = CGRect(origin: nextPageOrigin, size: nextPageSize)
            advertPicPageControl.currentPage = 0
        }
        else{
            let nextPageOrigin = CGPoint(x: (advertPicFlipper.frame.width * CGFloat(nextPageNumber)), y: 0)
            nextPage = CGRect(origin: nextPageOrigin, size: nextPageSize)
            advertPicPageControl.currentPage = nextPageNumber
        }
        advertPicFlipper.scrollRectToVisible(nextPage, animated: true)
    }
    
    //when a button in topicScrollView is pressed, segue to relevant screen
    @objc func goToView(sender:UIButton!) {
        let tempB = sender
        switch tempB?.currentTitle {
        case "0"?:
            print("button 0 pressed")
            performSegue(withIdentifier: "introseg", sender: self)
        case "1"?:
            print("button 1 pressed")
            performSegue(withIdentifier: "galseg", sender: self)
        case "2"?:
            print("button 2 pressed")
        case "3"?:
            print("button 3 pressed")
        case "4"?:
            print("button 4 pressed")
        case "5"?:
            print("button 5 pressed")
        case "6"?:
            print("button 6 pressed")
        default:
            print("other button pressed")
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

