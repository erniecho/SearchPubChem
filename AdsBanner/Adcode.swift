//
//  Adcode.swift
//  EngRead
//
//  Created by Ernie Cho on 9/3/17.
//  Copyright © 2017 ErnShu. All rights reserved.
//
// https://developers.google.com/admob/ios/interstitial


import Foundation
import UIKit
import GoogleMobileAds

class Adcode: UIViewController, GADBannerViewDelegate {
    // Ad banner varible
    @IBOutlet weak var bannerView: GADBannerView!
    //Live Ad String
    //let adUnitIDString: String = "ca-app-pub-3777362353172933/6260132465"
    
    //Testing Ad String
    var adUnitIDString: String = "ca-app-pub-3940256099942544/6300978111"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Banner View Code
        bannerView.delegate = self
        bannerView.adUnitID = adUnitIDString
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        }
    
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("adViewDidReceiveAd")
        view.addSubview(bannerView)
    }
    
    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
                didFailToReceiveAdWithError error: GADRequestError) {
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that a full screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("adViewWillPresentScreen")
    }
    
    /// Tells the delegate that the full screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("adViewWillDismissScreen")
    }
    
    /// Tells the delegate that the full screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("adViewDidDismissScreen")
    }
    
    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print("adViewWillLeaveApplication")
    }

}
