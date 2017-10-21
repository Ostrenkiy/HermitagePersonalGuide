//
//  MapViewController.swift
//  HermitagePersonalGuide
//
//  Created by Ostrenkiy on 21.10.2017.
//  Copyright © 2017 Ostrenkiy. All rights reserved.
//

import UIKit
import Pulsator
import Nuke

class MapViewController: UIViewController {
    
    var points: [UIView] = []
    
    let pointDiameter: CGFloat = 15
    
    @IBOutlet weak var mapImageScrollView: ImageScrollView!

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var interestsLabel: UILabel!
    
    var user: UserData!
    
    var halls = HallCoordinates.getHalls()
    
    var imageForFloor: [Int: UIImage] = [
        1: #imageLiteral(resourceName: "1_floor_cut"),
        2: #imageLiteral(resourceName: "2_floor_cut"),
        3: #imageLiteral(resourceName: "3_floor_cut")
    ]
    
    func getUserView(isPicture: Bool) -> UIView {
        let v = UIView(frame: CGRect(x: 0, y: 0, width: pointDiameter, height: pointDiameter))
        let iv = UIImageView(frame: CGRect(x: 0, y: 0, width: pointDiameter, height: pointDiameter))
        iv.contentMode = .scaleAspectFit
        iv.image = isPicture ? #imageLiteral(resourceName: "picture_location") : #imageLiteral(resourceName: "current_location")
        v.addSubview(iv)
        let pulsator = Pulsator()
        pulsator.radius = pointDiameter * 1.5
        pulsator.position = v.center
        pulsator.numPulse = 4
        pulsator.backgroundColor = isPicture ? UIColor(red: 110.0/255, green: 217.0/255, blue: 179.0/255, alpha: 1).cgColor : UIColor(red: 157.0/255, green: 201.0/255, blue: 252.0/255, alpha: 1).cgColor
        v.layer.addSublayer(pulsator)
        pulsator.start()
        return v
    }
    
//    func translateImageViewPointToImage(imageViewPoint: CGPoint) -> CGPoint {
//        let percentX = imageViewPoint.x / imageView.frame.size.width
//        let percentY = imageViewPoint.y / imageView.frame.size.height
//
//        return CGPoint(x: Int(imageView.image!.size.width * percentX), y: Int(imageView.image!.size.height * percentY))
//    }
    
    func updatePointSizes(scale: CGFloat) {
//        print(scale)
//        for point in points {
//            let prevCenter = point.center
//            point.frame.size = CGSize(width: pointDiameter, height: pointDiameter)
//            point.center = prevCenter
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = appBackgroundColor
        Nuke.loadImage(with: URL(string: user.avatarURL)!, into: avatarImageView)
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.setRoundedBounds(width: 1)
        nameLabel.text = user.name
        interestsLabel.text = "Интересы: \(user.interests)"
        mapImageScrollView.display(image: #imageLiteral(resourceName: "2_floor_cut"))
        let tapG = UITapGestureRecognizer(target: self, action: #selector(MapViewController.didTap(touch:)))
        mapImageScrollView.addGestureRecognizer(tapG)
        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        for hall in halls {
            if hall.floor == 2 {
                let userView = getUserView(isPicture: true)
                points += [userView]
                mapImageScrollView.zoomView?.addSubview(userView)
                mapImageScrollView.didZoomBlock = {
                    [weak self]
                    scale in
                    self?.updatePointSizes(scale: scale)
                }
                let imageViewPoint = mapImageScrollView.zoomView?.convertPoint(fromImagePoint: hall.coordinates)
                
                userView.center = imageViewPoint!
                
            }
        }
    }
    
    @objc func didTap(touch: UITapGestureRecognizer) {
        let userView = getUserView(isPicture: false)
        points += [userView]
        mapImageScrollView.zoomView?.addSubview(userView)
        mapImageScrollView.didZoomBlock = {
            [weak self]
            scale in
            self?.updatePointSizes(scale: scale)
        }
        userView.center = touch.location(in: mapImageScrollView.zoomView!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension UIView {
    func setRoundedBounds(width: CGFloat, color: UIColor = UIColor.white) {
        self.layer.cornerRadius = self.bounds.width / 2
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        self.layer.masksToBounds = true
        self.clipsToBounds = true
    }
}
