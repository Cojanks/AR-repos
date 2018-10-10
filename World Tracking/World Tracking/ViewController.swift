//
//  ViewController.swift
//  World Tracking
//
//  Created by Corey Jenkins on 4/15/18.
//  Copyright © 2018 Corey Jenkins. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController,ARSCNViewDelegate {

    @IBOutlet weak var sceneview: ARSCNView!
    @IBOutlet weak var draw: UIButton!
    
//    Lets shorten this ARWorldTracking yadda yadda
    let configuration = ARWorldTrackingConfiguration()
    var timer = Timer()
    
    @objc func pingPing() {
        print("3 seconds have passed")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//      Visually adds the feature points and world origin to ensure that the world origin loads correctly when app starts
        self.sceneview.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        
//        Will show framerate info, etc
//        self.sceneview.showsStatistics = true
        
//      when the app loads, start a session
        self.sceneview.session.run(configuration)
        
        self.sceneview.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        
//        Timer
//        Should have the timer fire every... half second and render a new node/cirle?
//        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(ViewController.pingPing), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func add(_ sender: Any) {
//        print("Add button pressed")
        let node = SCNNode()
        node.geometry = SCNBox(width: 0.01, height: 0.01, length: 0.01, chamferRadius: 0)
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.cyan
        //        SCNVector3 is based on a 3-axis position: X,Y,Z of the node that we are created in relation to the parent node
        node.position = SCNVector3(0,0,0)
//        rootNode is the first node put down (at the world origin) and to ensure that another node is placed in relation to this first node, it must be a child node of that rootnode.
        self.sceneview.scene.rootNode.addChildNode(node)
    }
    
    @IBAction func reset(_ sender: Any) {
        restartSession()
        timer.invalidate()
    }
    
    func restartSession() {
        self.sceneview.session.pause()
        self.sceneview.scene.rootNode.enumerateChildNodes { (node, _) in
            node.removeFromParentNode()
        }
        self.sceneview.session.run(configuration, options:
            [.resetTracking, .removeExistingAnchors])
    }
    
    func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
        guard let pointOfView = sceneview.pointOfView else { return }
        let transform = pointOfView.transform
//
//        let orientation = SCNVector3(-transform.m31,-transform.m32,-transform.m33)
        let location = SCNVector3(transform.m41,transform.m42,transform.m43)
        print(location.x, location.y, location.z)
        let currentPositionOfCamera = location
//        print(orientation.x, orientation.y, orientation.z)
        
//        detecting if a button is being held. When a button is being pressed, it is highlighted so the following will only activate when the button is held
//        if IBActionHere.isHighlighted {
//          print("IBaction button is being pressed")
//        }
        
        if draw.isHighlighted {
//            print("button pressed")
            let sphereNode = SCNNode(geometry: SCNSphere(radius: 0.03))
            sphereNode.position = currentPositionOfCamera
            self.sceneview.scene.rootNode.addChildNode(sphereNode)
            sphereNode.geometry?.firstMaterial?.diffuse.contents = UIColor.green
        }
    }
}

func +(left: SCNVector3, right: SCNVector3) -> SCNVector3{
    return SCNVector3Make(left.x + right.x, left.y + right.y, left.z + right.z)
}

