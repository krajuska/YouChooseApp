//
//  MainViewController.swift
//  YouChooseApp
//
//  Created by Aline Krajuska on 5/10/19.
//  Copyright © 2019 Aline Krajuska. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let data = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var videos = [Playlist]()
    
    @IBOutlet weak var gearButton: UIBarButtonItem!
    @IBOutlet weak var clockButton: UIBarButtonItem!
    
    var channelsThumbnail = ["FC.jpg", "RTG.jpg", "M.jpg", "JM.jpg", "CSC.jpg"]
    var videoPicThumbnails = ["c.jpg", "lt.jpg", "mb.jpg", "pc.jpg", "pp.jpg"]
    
    @IBOutlet weak var thumbnailCollectionView: UICollectionView!
    @IBOutlet weak var videosCollectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == thumbnailCollectionView {
            return channelsThumbnail.count
        } else {
            return videoPicThumbnails.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if collectionView == thumbnailCollectionView { //channels
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChannelsOnMainCollectionViewCell", for: indexPath) as! ChannelsOnMainCollectionViewCell
            cell.thumbnailImageView.image = UIImage(named: channelsThumbnail[indexPath.row])
            cell.thumbnailImageView.layer.cornerRadius = cell.thumbnailImageView.frame.size.width / 2
            cell.thumbnailImageView.clipsToBounds = true
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThumbnailsOnMainCollectionViewCell", for: indexPath) as! ThumbnailsCollectionViewCell
            cell.videoThumbnails.image = UIImage(named: videoPicThumbnails[indexPath.row])
            return cell
        }
        
        
//        let title = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: cell.bounds.size.width, height: cell.bounds.size.height))
//        title.textColor = UIColor.red
//        cell.contentView.addSubview(title)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == thumbnailCollectionView {
             return CGSize(width: collectionView.layer.frame.height-10, height: collectionView.layer.frame.height-10)
        }
        return CGSize(width: collectionView.layer.frame.width - 20, height: CGFloat((CGFloat(collectionView.layer.frame.width - 20) * 9) / 16))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        thumbnailCollectionView.delegate = self
        thumbnailCollectionView.dataSource = self
        videosCollectionView.delegate = self
        videosCollectionView.dataSource = self
        
        createTestPlaylistInstance(self)
        videos = loadAvailableContent(self)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setHeader(self)
    }
}

