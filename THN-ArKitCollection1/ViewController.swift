//
//  ViewController.swift
//  THN-ArKitCollection1
//
//  Created by HaN  on 5/31/19.
//  Copyright © 2019 HaN . All rights reserved.
//


import ARKit
import LBTAComponents

class GameViewController : UIViewController {
    
    let arView : ARSCNView = {   //1
        let view = ARSCNView()
        
        return view
    }()
    
    let plusButtonWidth = ScreenSize.width * 0.1
    lazy var plusButton : UIButton = {
        var button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "PlusButton").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = UIColor(white: 1.0, alpha: 0.7)
        button.layer.cornerRadius = plusButtonWidth * 0.5
        button.layer.masksToBounds = true
        button.layer.zPosition = 1
        button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handlePlusButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func handlePlusButtonTapped() {
        print("Tapped on plus button ...")
        addBox()
    }
    
    let minusButtonWidth = ScreenSize.width * 0.1
    lazy var minusButton : UIButton = {
        var button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "MinusButton").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = UIColor(white: 1.0, alpha: 0.7)
        button.layer.cornerRadius = plusButtonWidth * 0.5
        button.layer.masksToBounds = true
        button.layer.zPosition = 1
        button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleMinusButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func handleMinusButtonTapped() {
        print("Tapped on plus button ...")
        removeAllBoxes()
    }
    
    let resetButtonWidth = ScreenSize.width * 0.1
    lazy var resetButton : UIButton = {
        var button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "ResetButton").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = UIColor(white: 1.0, alpha: 0.7)
        button.layer.cornerRadius = plusButtonWidth * 0.5
        button.layer.masksToBounds = true
        button.layer.zPosition = 1
        button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleResetButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func handleResetButtonTapped() {
        print("Tapped on plus button ...")
        resetScene()
    }
    
    let configuration = ARWorldTrackingConfiguration()  //3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        arView.session.run(configuration, options: [])   //2
        arView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]   //4
        arView.autoenablesDefaultLighting = true
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    func setupView() {
        
        view.addSubview(arView)
        arView.fillSuperview()
        
        view.addSubview(plusButton)
        plusButton.anchor(nil, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: nil, topConstant: 0, leftConstant: 24, bottomConstant: 12, rightConstant: 0, widthConstant: plusButtonWidth, heightConstant: plusButtonWidth)
        
        view.addSubview(minusButton)
        minusButton.anchor(nil, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 12, rightConstant: 24, widthConstant: minusButtonWidth, heightConstant: minusButtonWidth)
        
        view.addSubview(resetButton)
        resetButton.anchor(nil, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 12, rightConstant: 0, widthConstant: resetButtonWidth, heightConstant: resetButtonWidth)
        resetButton.anchorCenterXToSuperview()
    }
    
    //random
    
    func addBox() {
        let shapeNode = SCNNode()   //5
        shapeNode.geometry = SCNBox(width: 0.05, height: 0.05, length: 0.05, chamferRadius: 0.0002)  //6
        shapeNode.geometry?.firstMaterial?.diffuse.contents = UIImageView(image: #imageLiteral(resourceName: "Material"))
        //        shapeNode.position = SCNVector3(0, 0, -0.3)  //7
        shapeNode.position = SCNVector3(Float.random(-0.5, max: 0.5), Float.random(-0.5, max: 0.5), Float.random(-0.5, max: 0.5) )
        shapeNode.name = "node"
        arView.scene.rootNode.addChildNode(shapeNode) //8
    }
    
    func removeAllBoxes() {
        
        arView.scene.rootNode.enumerateChildNodes { (node, _) in
            if node.name == "node"{
                node.removeFromParentNode()
            }
        }
    }
    
    func resetScene(){
        arView.session.pause()
        arView.scene.rootNode.enumerateChildNodes { (node, _) in
            if node.name == "node"{
                node.removeFromParentNode()
            }
        }
        arView.session.run(configuration, options: [.removeExistingAnchors, .resetTracking])
    }
    
}


