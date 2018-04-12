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
//  https://stackoverflow.com/questions/5843427/how-do-you-add-an-action-to-a-button-programmatically-in-xcode //haven't used this yet, looks useful though
//  https://stackoverflow.com/questions/4628800/android-how-to-check-if-a-view-inside-of-scrollview-is-visible
//  https://developer.apple.com/documentation/uikit/uiview/1622469-hittest
//  https://www.youtube.com/watch?v=BnGf01O4NUw

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
    
    let advertPicFlipperFrame = CGRect(x: 10, y: 20, width: 748, height: 594)
    let topicScrollFrame = CGRect(x: 10, y: 624, width: 748, height: 390)
    let advertPics: [UIImage] = [#imageLiteral(resourceName: "day"), #imageLiteral(resourceName: "skull"), #imageLiteral(resourceName: "buttsmoke"), #imageLiteral(resourceName: "deadbabies")]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //sets up advertPicFlipper, its frame and background color and so on
        advertPicFlipper = UIScrollView(frame: advertPicFlipperFrame)
        advertPicFlipper.backgroundColor = UIColor.white
        advertPicFlipper.isPagingEnabled = true
        advertPicFlipper.contentSize = CGSize (width: 748*advertPics.count, height: 594)
        advertPicFlipper.showsHorizontalScrollIndicator = false
        
        //populates advertPicFlipper with images from advertPics, ideally would be a loop with an
        //adjustable number of iterations instead of hardcoding 4 pictures
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
        
        //this is those little dots at the bottom that tell you which page you're on
        advertPicPageControl = UIPageControl(frame: CGRect(x: 10, y: 594, width: 748, height: 20))
        advertPicPageControl.numberOfPages = advertPics.count
        //Note to Self: see about UIScrollView.hittest for checking what pic is currently shown
        
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(advertPicFlipperScrollNext), userInfo: nil, repeats: true)
        
        //sets up the title card that says Moosnick Museum and gets placed on top of advertPicFlipper
        let moosnickTitleCard: UILabel = UILabel(frame: CGRect(x: 10, y: 250, width: 748, height: 50))
        moosnickTitleCard.text = "Moosnick Museum"
        moosnickTitleCard.textAlignment = NSTextAlignment.center
        moosnickTitleCard.textColor = UIColor.white
        moosnickTitleCard.font = moosnickTitleCard.font.withSize(70)
        moosnickTitleCard.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        //sets up some basic stuff about topicScrollView
        topicScrollView = UIScrollView(frame: topicScrollFrame)
        topicScrollView.backgroundColor = UIColor.white
        topicScrollView.contentSize = CGSize(width: 390*7, height: topicScrollFrame.height)
        
        //populates the topicScrollView with buttons and labels
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
        
        //adds all the different elements as subviews to the viewcontroller
        self.view.addSubview(advertPicFlipper)
        self.view.addSubview(moosnickTitleCard)
        self.view.addSubview(advertPicPageControl)
        self.view.addSubview(topicScrollView)
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
        if nextPageNumber >= advertPicPageControl.numberOfPages {
            nextPage = CGRect(x: 0, y: 0, width: 748, height: 594)
            advertPicPageControl.currentPage = 0
        }
        else{
            nextPage = CGRect(x: (748 * nextPageNumber), y: 0, width: 748, height: 594)
            advertPicPageControl.currentPage = advertPicPageControl.currentPage + 1
        }
        advertPicFlipper.scrollRectToVisible(nextPage, animated: true)
    }
    @objc func goToView(sender:UIButton!) {
        var tempB = sender
        switch tempB?.currentTitle {
        case "1"?:
            print("button 1 pressed")
            performSegue(withIdentifier: "introseg", sender: self)
        case "2"?:
            print("button 2 pressed")
            performSegue(withIdentifier: "galseg", sender: self)
        case "3"?:
                print("button 3 pressed")
        case "4"?:
            print("button 4 pressed")
        case "5"?:
            print("button 5 pressed")
        case "6"?:
            print("button 6 pressed")
        case "7"?:
            print("button 7 pressed")
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
