//
//  VkViewController.swift
//  HermitagePersonalGuide
//
//  Created by Андрей on 21.10.2017.
//  Copyright © 2017 Ostrenkiy. All rights reserved.
//

import UIKit
import VK_ios_sdk

class VkViewController: UIViewController{
    var vkProvider:VKSocialSDKProvider?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vkProvider = VKSocialSDKProvider.instance
        vkProvider?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func authorize(_ sender: Any) {
        vkProvider?.getAccessInfo(success: successHandler, error: errorHandler)
    }
    
    private func successHandler(token: String, email:String?){
        print(token)
        print(email ?? "empty email")
    }
    
    private func errorHandler(error:SocialSDKError){
        print(error)
    }
}

extension VkViewController:VKSocialSDKProviderDelegate{
    func presentAuthController(_ controller: UIViewController) {
        self.present(controller, animated: true, completion: nil)
    }
}


