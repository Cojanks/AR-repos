//
//  ViewController.swift
//  World Tracking
//
//  Created by Corey Jenkins on 4/15/18.
//  Copyright © 2018 Corey Jenkins. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneview: ARSCNView!

//    Lets shorten this ARWorldTracking yadda yadda
    let configuration = ARWorldTrackingConfiguration()
    override func viewDidLoad() {
        super.viewDidLoad()
        
//      Visually adds the feature points and world origin to ensure that the world origin loads correctly when app starts
        self.sceneview.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        
//        when the app loads, start a session
        self.sceneview.session.run(configuration)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    @IBAction func add(_ sender: Any) {
        print("Add button pressed")
        let node = SCNNode()
        node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.cyan
        //        SCNVector3 is based on a 3-axis position: X,Y,Z
        node.position = SCNVector3(0,0,0)
//        rootNode is the first node put down (at the world origin) and to ensure that another node is placed in relation to this first node, it must be a child node of that rootnode.
        self.sceneview.scene.rootNode.addChildNode(node)
    }
    
    @IBAction func reset(_ sender: Any) {
        restartSession()
    }
    
    func restartSession() {
        self.sceneview.session.pause()
        self.sceneview.scene.rootNode.enumerateChildNodes { (node, _) in
            node.removeFromParentNode()
        }
        self.sceneview.session.run(configuration, options:
            [.resetTracking, .removeExistingAnchors])
    }
}

