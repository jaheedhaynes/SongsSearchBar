//
//  ViewController.swift
//  SongsTableViewSearchBar
//
//  Created by C4Q  on 11/6/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

enum SearchScope {
    case name
    case artist
}




class SongViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
var songs = [Song]() {
        didSet {
        tableView.reloadData()
        }
    }
    
    var currentScope = SearchScope.name
    
    var searchInput = "" {
        didSet {
            switch currentScope {
            case .name:
                songs = Song.loveSongs.filter { $0.name.lowercased().contains(searchInput.lowercased()) }
            case .artist:
                songs = Song.loveSongs.filter { $0.artist.lowercased().contains(searchInput.lowercased()) }
            }
        }
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        searchBar.delegate = self
        
        loadData()
       
    }

    func loadData() {
            songs = Song.loveSongs
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            guard let songViewCon = segue.destination as? SongDetailVC, let indexPath = tableView.indexPathForSelectedRow else {
                fatalError("You broke the App ☠️")
            }
            
            songViewCon.song = songs[indexPath.row]
        }
        
        
    }

    extension SongViewController: UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return songs.count
            
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)
            
            let song = songs[indexPath.row]
            
            cell.textLabel?.text = song.name
            cell.detailTextLabel?.text = song.artist
            
            
            return cell
        }
        
        
    }

    extension SongViewController: UISearchBarDelegate {
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

            searchBar.resignFirstResponder()
            
            guard let searchText = searchBar.text else {
                return
            }
            
            guard !searchText.isEmpty else {
                loadData()
                return
            }
            
            searchInput = searchText

        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            
            guard !searchText.isEmpty else {
                loadData()
                return
            }
            
            searchInput = searchText

        }
        
        func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
            
            switch selectedScope {
            case 0:
                currentScope = .name
            case 1:
                currentScope = .artist
            default:
                print("Not a valid search, Try again")
            }
        }
        
        
    }


    
    



