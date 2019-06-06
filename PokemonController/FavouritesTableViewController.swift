//
//  FavouritesTableViewController.swift
//  PokemonController
//
//  Created by win on 7/13/16.
//  Copyright © 2016 Ka Ho. All rights reserved.
//

import UIKit

protocol FavouritesTableViewControllerDelegate {
    func favouritesTableViewControllerDidSelectLocation(viewController: FavouritesTableViewController, location: Location)
}

class FavouritesTableViewController: UITableViewController {

    var delegate: FavouritesTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func didPressDoneButton(sender: Any) {
      dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension FavouritesTableViewController {
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Location.allLocations().count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath)
        
        let location = Location.allLocations()[indexPath.row]
        
        cell.textLabel?.text = location.name
        cell.detailTextLabel?.text = "\(location.lat),\(location.lng)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: true)
        
      showAlert(location: Location.allLocations()[indexPath.row])
    }
}

extension FavouritesTableViewController {
    func showAlert(location: Location) {
      let alertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
      let goAction = UIAlertAction(title: "Go", style: UIAlertActionStyle.default) { [unowned self] (action) in
        self.delegate?.favouritesTableViewControllerDidSelectLocation(viewController: self, location: location)
        self.dismiss(animated: true, completion: nil)
        }
        
      let removeAction = UIAlertAction(title: "Remove from Favourites", style: UIAlertActionStyle.destructive) { [weak self] (action) in
            
            location.remove()
            
            self?.tableView.reloadData()
        }
        
        alertController.addAction(goAction)
        alertController.addAction(removeAction)
        
      present(alertController, animated: true, completion: nil)
    }
}
