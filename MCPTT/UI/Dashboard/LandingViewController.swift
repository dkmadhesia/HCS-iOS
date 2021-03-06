//
//  LandingViewController.swift
//  mcpttapp
//
//  Created by Sunil Kumar Yadav on 08/10/18.
//  Copyright © 2018 Harman connected services. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {
    
    @IBOutlet weak var scrollPager: ScrollPager!
    
    static func makeViewController(collectionViewLayout: UICollectionViewLayout) -> LandingViewController {
        let landingViewController = LandingViewController.instantiateFromStoryboard("Dashboard", storyboardId: "LandingViewController")
        return landingViewController
    }
    
     var channelListViewController: ChannelListViewController?
    
     var contactListViewController: ContactListViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //self.title = "MCPTT"
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.size.width-32, height: view.frame.size.height))
        titleLabel.text = "MCPTT"
        navigationItem.titleView = titleLabel
        navigationController?.isNavigationBarHidden = false
        navigationItem.hidesBackButton = true
        
        scrollPager.delegate = self
        
         let channelStoryboard = UIStoryboard.init(name: "Channel", bundle: nil)
         channelListViewController = channelStoryboard.instantiateViewController(withIdentifier: "ChannelListViewController") as? ChannelListViewController
        let contactStoryboard = UIStoryboard.init(name: "Contact", bundle: nil)
        
        contactListViewController = contactStoryboard.instantiateViewController(withIdentifier: "ContactListViewController") as? ContactListViewController
        
        if let channelListViewController = channelListViewController {
            addChildViewController(channelListViewController)
            view.addSubview(channelListViewController.view)
            channelListViewController.didMove(toParentViewController: self)
        }
        
        if let contactListViewController = contactListViewController {
            addChildViewController(contactListViewController)
            view.addSubview(contactListViewController.view)
            contactListViewController.didMove(toParentViewController: self)
        }
        
        if let channelView = channelListViewController?.view, let contactListView = contactListViewController?.view {
            
            scrollPager.addSegmentsWithTitlesAndViews(segments: [
                ("CHANNELS", channelView),
                ("CONTACTS", contactListView)
                ])
        }
        
        let settingImage = UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysTemplate)
        let settingButton = UIBarButtonItem(image: settingImage, style: .plain, target: self, action: #selector(handleSettings))
        settingButton.tintColor = UIColor.black
        
        navigationItem.rightBarButtonItems = [settingButton]
    }
    
    @objc func handleSettings() {
        var actions: [(String, UIAlertActionStyle)] = []
        actions.append(("Settings", UIAlertActionStyle.default))
        actions.append(("Sign Out", UIAlertActionStyle.default))
        actions.append(("Cancel", UIAlertActionStyle.cancel))
        
        CommonUtility.showActionsheet(viewController: self, title: "", message: "", actions: actions) { (index) in
            switch index {
            case 0:
                 let settingViewController = SettingsViewController.instantiateFromStoryboard("Setting", storyboardId: "SettingsViewController")
                self.navigationController?.pushViewController(settingViewController, animated: true)
            case 1:
            //Need to implement logoout funtionality
            return
            default:
                return
            }
        }
    }
}
extension LandingViewController: ScrollPagerDelegate {
    func scrollPager(scrollPager: ScrollPager, changedIndex: Int) {
        print("scrollPager index changed: \(changedIndex)")
    }
}
