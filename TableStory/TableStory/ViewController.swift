//
//  ViewController.swift
//  TableStory
//
//  Created by Vo, Anh Vo on 3/20/24.
//

import UIKit
import MapKit

//array objects of our data.
let data = [
    Item(name: "Buenos Aires Cafe", desc: "Upscale bistro spotlighting Argentine cuisine ", lat: 30.271502855825293, long: -97.72886037647798, imageName: "rest1"),
    Item(name: "Sijie Special Noodles", desc: "Amazing grill beef tendon with Chinese BBQ seasoning ", lat: 30.480516782775005, long: -97.79287564552497, imageName: "rest2"),
    Item(name: "Tacos El Charly", desc: "The most affordable tacos and yet, with the best homemade sauces", lat:30.365719369278136, long: -97.69682804550698, imageName: "rest3"),
    Item(name: "Gyu Kaku Japanese BBQ", desc: "Japanese restaurant that has famous Lady M for dessert ", lat: 30.268745939401352, long: -97.72957674952563, imageName: "rest4"),
    Item(name: "Valentina's Tex Mex BBQ", desc: "Permanent trailer for mesquite-smoked BBQ with a Tex Mex Twist", lat: 30.08074227975026, long: -97.8461902601336, imageName: "rest5")
   
]
   

struct Item {
    var name: String
    var desc: String
    var lat: Double
    var long: Double
    var imageName: String
}









class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    
    //table view
    @IBOutlet weak var theTable: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return data.count
  }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
        let item = data[indexPath.row]
        cell?.textLabel?.text = item.name

        //Add image references
        let image = UIImage(named: item.imageName)
        cell?.imageView?.image = image
        cell?.imageView?.layer.cornerRadius = 10
        cell?.imageView?.layer.borderWidth = 5
        cell?.imageView?.layer.borderColor = UIColor.white.cgColor
        
        return cell!
    }
                 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = data[indexPath.row]
        performSegue(withIdentifier: "ShowDetailSegue", sender: item)
      
    }
        
    // add this function to original ViewController
           override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
             if segue.identifier == "ShowDetailSegue" {
                 if let selectedItem = sender as? Item, let detailViewController = segue.destination as? DetailViewController {
                     // Pass the selected item to the detail view controller
                     detailViewController.item = selectedItem
                 }
             }
         }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        theTable.delegate = self
        theTable.dataSource = self
    

    //set center, zoom level and region of the map
          let coordinate = CLLocationCoordinate2D(latitude: 30.295190, longitude: -97.7444)
          let region = MKCoordinateRegion(center: coordinate,span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
          mapView.setRegion(region, animated: true)
          
       // loop through the items in the dataset and place them on the map
           for item in data {
              let annotation = MKPointAnnotation()
              let eachCoordinate = CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)
              annotation.coordinate = eachCoordinate
                  annotation.title = item.name
                  mapView.addAnnotation(annotation)
                  }
    }
        
}

