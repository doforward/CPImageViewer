//
//  CollectionViewController.swift
//  CPImageViewer
//
//  Created by ZhaoWei on 16/2/27.
//  Copyright © 2016年 cp3hnu. All rights reserved.
//

import UIKit
import CPImageViewer

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController, CPImageControllerProtocol {

    var isPresented = false
    var animationImageView: UIImageView!
    var animator = CPImageViewerAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if !isPresented {
            self.navigationController?.delegate = animator
        }
    }

    // MARK: UICollectionViewDataSource
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CollectionViewCell
    
        // Configure the cell
        cell.imageView.image = UIImage(named: "\(indexPath.item + 1)")
        cell.label.text = "\(indexPath.item + 1)"
    
        return cell
    }

    // MARK: UICollectionViewDelegate
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CollectionViewCell
        
        animationImageView = cell.imageView
        
        tap()
    }
    
    func tap() {
        let controller = CPImageViewerViewController()
        controller.transitioningDelegate = animator
        controller.image = animationImageView.image
        
        if !isPresented {
            controller.viewerStyle = .Push
            controller.title = "CPImageViewer"
            self.navigationController?.pushViewController(controller, animated: true)
        } else {
            self.presentViewController(controller, animated: true, completion: nil)
        }
    }

}
