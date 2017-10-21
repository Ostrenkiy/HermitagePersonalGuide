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
    
    private func successHandler(token: String, id: Int){
        print(token)
        print("\(id)")
        UserAPISuccessMock().create(user: id, token: token, completion: {
            [weak self]
            error, userData in
            guard let user = userData else {
                print("pizdec \(error?.localizedDescription ?? "")")
                return
            }
            self?.showMap(user: user)
        })
    }
    
    func showMap(user: UserData) {
        self.performSegue(withIdentifier: "showMap", sender: user)
    }
    
    private func errorHandler(error:SocialSDKError){
        print(error)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showMap" {
            let dvc = segue.destination as! MapViewController
            dvc.user = sender as! UserData
        }
    }
    

}

extension VkViewController:VKSocialSDKProviderDelegate{
    func presentAuthController(_ controller: UIViewController) {
        self.present(controller, animated: true, completion: nil)
    }
}


