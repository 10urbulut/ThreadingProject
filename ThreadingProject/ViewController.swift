//
//  ViewController.swift
//  ThreadingProject
//
//  Created by Onur Bulut on 25.09.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    
    let urlStrings = ["https://upload.wikimedia.org/wikipedia/commons/c/cc/ESC_large_ISS022_ISS022-E-11387-edit_01.JPG","https://upload.wikimedia.org/wikipedia/commons/7/74/Earth_poster_large.jpg"]
    
    var data = Data()
    var tracker = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        DispatchQueue.global().async {
            self.data = try!  Data(contentsOf: URL(string: self.urlStrings[self.tracker])!)
            
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: self.data)
            }
            
          
        }
        
        
        
    
        
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(changeImage))
    }

    @objc func changeImage(){
        if tracker == 0{
            tracker += 1
        }else {
            tracker -= 1
        }
        
        DispatchQueue.global().async {
            self.data = try!  Data(contentsOf: URL(string: self.urlStrings[self.tracker])!)
            
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: self.data)
            }
            
          
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Threding test: \(indexPath.row + 1)"
        return cell
    }
}

