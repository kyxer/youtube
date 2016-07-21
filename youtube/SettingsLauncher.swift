//
//  SettingsLauncher.swift
//  youtube
//
//  Created by German Mendoza on 7/20/16.
//  Copyright © 2016 German LLC. All rights reserved.
//

import UIKit

class Setting:NSObject {
    
    let name:SettingName
    let imageName: String
    
    init(name:SettingName, imageName:String){
        self.name = name
        self.imageName = imageName
    }
    

}

enum SettingName:String {
    
    case Cancel = "Cancel & Dismiss"
    case Settings = "Settings"
    case TermsPrivacy = "Terms & Privacy policy"
    case SendFeedback = "Send Feedback"
    case Help = "Help"
    case SwitchAccount = "Switch Account"

}

class SettingsLauncher: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    override init(){
        super.init()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerClass(SettingCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    let cellId = "cellId"
    let cellHeight:CGFloat = 50
    
    let settings:[Setting] = {
        
        return [Setting(name:.Settings, imageName:"settings"), Setting(name: .TermsPrivacy, imageName: "privacy"),Setting(name: .SendFeedback, imageName: "feedback"),Setting(name: .Help, imageName: "help"),Setting(name: .SwitchAccount, imageName: "switch_account"),Setting(name: .Cancel, imageName: "cancel")]
    }()
    
    var homeController:HomeController?
    let blackView = UIView()
    
    let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.whiteColor()
        return cv
    }()
    
    func showSettings(){
        if let window = UIApplication.sharedApplication().keyWindow {

            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            
            
            let height:CGFloat = CGFloat(settings.count) * cellHeight
            let y = window.frame.height - height
            
            collectionView.frame = CGRectMake(0, window.frame.height, window.frame.width, height)
            
            window.addSubview(blackView)
            window.addSubview(collectionView)
            blackView.alpha = 0
            blackView.frame = window.frame
            
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .CurveEaseOut, animations: {
                self.blackView.alpha = 1
                self.collectionView.frame = CGRectMake(0, y, self.collectionView.frame.width, height)
                }, completion: nil)
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(collectionView.frame.width, cellHeight)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func handleDismiss(setting:Setting) {
        
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .CurveEaseOut, animations: {
            
            self.blackView.alpha = 0
            
            if let window = UIApplication.sharedApplication().keyWindow {
                self.collectionView.frame = CGRectMake(0, window.frame.height, window.frame.width, window.frame.height)
            }
            
            
            }, completion: { (completed: Bool) in
                if setting.name != .Cancel {
                    self.homeController?.showControllerForSetting(setting)
                }
        })
    
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! SettingCell
        
        cell.setting = settings[indexPath.item]
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let setting = self.settings[indexPath.item]
        handleDismiss(setting)
    }
}

