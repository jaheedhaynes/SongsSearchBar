//
//  SongDetailVC.swift
//  SongsTableViewSearchBar
//
//  Created by Jaheed Haynes on 12/5/19.
//  Copyright © 2019 C4Q . All rights reserved.
//

import UIKit

class SongDetailVC: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var artistLabel: UILabel!
    
    var song: Song?
//------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()

     updateUI()
    }
    
//------------------------------------------------------

    func updateUI() {
        guard let correctSongChoice = song else {
            fatalError("could not load song")
        }
        
        titleLabel.text = correctSongChoice.name
        artistLabel.text = correctSongChoice.artist
    }


}
