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

enum PointType {
    case picture, nextPicture, current
    
    var image: UIImage {
        switch self {
        case .picture:
            return #imageLiteral(resourceName: "picture_location")
        case .nextPicture:
            return #imageLiteral(resourceName: "current_location")
        case .current:
            return #imageLiteral(resourceName: "next_location")
        }
    }
    
    var pulseColor: CGColor {
        switch self {
        case .picture:
            return UIColor(red: 110.0/255, green: 217.0/255, blue: 179.0/255, alpha: 1).cgColor
        case .nextPicture:
            return UIColor(red: 157.0/255, green: 201.0/255, blue: 252.0/255, alpha: 1).cgColor
        case .current:
            return UIColor(red: 20.0/255, green: 133.0/255, blue: 169.0/255, alpha: 1).cgColor
        }
    }
}

class MapViewController: UIViewController {
    
    var points: [Int: UIView] = [:]
    
    var route: Route? {
        didSet {
            highlightRoute(route: route!)
        }
    }
    
    let pointDiameter: CGFloat = 15
    
    @IBOutlet weak var mapImageScrollView: ImageScrollView!

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var interestsLabel: UILabel!
    
    var user: UserData!
    let halls = HallCoordinates.getHalls()

    var currentUserView: UIView?
    
    var currentUserHallID: Int! {
        didSet {
            if points[currentUserHallID] != nil {
                points[currentUserHallID]?.removeFromSuperview()
                points[currentUserHallID] = nil
            }
            currentUserView?.removeFromSuperview()
            if currentUserView == nil {
                currentUserView = getPointView(type: .current)
            }
            if let hall = hallFor(id: currentUserHallID) {
                if hall.floor != currentFloor {
                    currentFloor = hall.floor
                }
                placeHallPoint(hall: hall, pointView: currentUserView!)
                points[currentUserHallID] = currentUserView
                points[currentUserHallID]?.tag = currentUserHallID
                updateRoute()
            }
        }
    }
    
    var imageForFloor: [Int: UIImage] = [
        1: #imageLiteral(resourceName: "1_floor_cut"),
        2: #imageLiteral(resourceName: "2_floor_cut"),
        3: #imageLiteral(resourceName: "3_floor_cut")
    ]
    var currentFloor = 1 {
        didSet {
            updateFloorImage()
        }
    }
    
    private func updateFloorImage() {
        mapImageScrollView.display(image: imageForFloor[currentFloor]!)
    }
    
    func getPointView(type: PointType) -> UIView {
        let v = UIView(frame: CGRect(x: 0, y: 0, width: pointDiameter, height: pointDiameter))
        let iv = UIImageView(frame: CGRect(x: 0, y: 0, width: pointDiameter, height: pointDiameter))
        iv.contentMode = .scaleAspectFit
        iv.image = type.image
        v.addSubview(iv)
        let pulsator = Pulsator()
        pulsator.radius = pointDiameter * 2.0
        pulsator.position = v.center
        pulsator.numPulse = 4
        pulsator.backgroundColor = type.pulseColor
        v.layer.addSublayer(pulsator)
        pulsator.start()
        return v
    }
    
    private func placeHallPoint(hall: Hall, pointView: UIView) {
        points[hall.id]?.removeFromSuperview()
        points[hall.id] = pointView
        mapImageScrollView.zoomView?.addSubview(pointView)
        let imageViewPoint = mapImageScrollView.zoomView?.convertPoint(fromImagePoint: hall.coordinates)
        
        pointView.center = imageViewPoint!
    }
    
    private func hallFor(id: Int) -> Hall? {
        return halls.filter({$0.id == id}).first
    }
    
    func highlightRoute(route: Route) {
//        if let nextHall = hallFor(id: route.halls[0]) {
//            if nextHall.floor != currentFloor {
//
//            }
//        }
        for (index, hallID) in route.halls.enumerated() {
            if let hall = hallFor(id: hallID) {
                let pv = getPointView(type: index == 0 ? .nextPicture : .picture)
                placeHallPoint(hall: hall, pointView: pv)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = appBackgroundColor
        Nuke.loadImage(with: URL(string: user.avatarURL)!, into: avatarImageView)
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.setRoundedBounds(width: 1)
        nameLabel.text = user.name
        interestsLabel.text = "Интересы: \(user.interests)"
        updateFloorImage()
        // Do any additional setup after loading the view.
    }
    
    func updateRoute() {
        RouteAPIMock().retrieve(user: user.id, location: currentUserHallID, wantOut: false, completion: {
            [weak self]
            error, route in
            self?.route = route
        })
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        currentUserHallID = 192
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextPressed(_ sender: Any) {
        currentUserHallID = route?.halls.first!
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
