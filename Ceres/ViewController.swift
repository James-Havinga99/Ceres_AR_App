//
//  ViewController.swift
//  Ceres
//
//  Created by James Havinga on 2020/05/25.
//  Copyright © 2020 James Havinga. All rights reserved.
//

import UIKit
import RealityKit

class ViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
    @IBOutlet weak var textPanel: UIVisualEffectView!
    @IBOutlet weak var dropButton: UIButton!
    @IBOutlet weak var websiteLink: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the "Box" scene from the "Experience" Reality File
        let boxAnchor = try! Experience.loadBox()
        
        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)
        
        //Custom Behaviour
        
        boxAnchor.actions.showInterface.onAction = handleShowInterface(_:)
        
        boxAnchor.actions.startDropGrapes.onAction = handleStartDropGrapes(_:)
        
        boxAnchor.actions.stopDropGrapes.onAction = handleStopDropGrapes(_:)
    }
    
    //MARK: - Custom Behaviour
    
    func handleShowInterface(_ entity: Entity?) {
        guard entity != nil else {
            return
        }
        
        print("Scene Started")
        
        textPanel.isHidden = false
        websiteLink.isHidden = false
        dropButton.isHidden = true
    }
    
    func handleStartDropGrapes(_ entity: Entity?) {
        guard  entity != nil else {
            return
        }
        
        print("Start Drop Grapes")
        
        textPanel.isHidden = false
        websiteLink.isHidden = true
        dropButton.isHidden = false
    }
    
    func handleStopDropGrapes(_ entity: Entity?) {
        guard  entity != nil else {
            return
        }
        
        print("Stop Drop Grapes")
        
        textPanel.isHidden = true
        websiteLink.isHidden = true
        dropButton.isHidden = true
    }
    
    //MARK: - Custom Trigger
    
    @IBAction func onDropGrapesTapped(_ sender: Any) {
        if let sceneAnchor = arView.scene.anchors[0] as? Experience.Box {
            
            sceneAnchor.notifications.dropGrapes.post()
        }
    }
}
