//
//  ViewController.swift
//  NavBarAnimation
//
//  Created by Ion Sebastian Rodriguez Lara on 23/05/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var navBarView: UIView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var plusButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    var titleLabel: UILabel!
    var titleConstraint: NSLayoutConstraint!
    
    var isBarShown = false
    
    var stackView : UIStackView!
    
    var snacks = ["Oreos", "Pizza", "Popsicle", "Pop Tart", "Ramen"]
    var order = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel = UILabel()
        navBarView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: navBarView.centerXAnchor).isActive = true
        titleConstraint = titleLabel.centerYAnchor.constraint(equalTo: navBarView.centerYAnchor, constant: 20)
        titleConstraint.isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        titleLabel.text = "Snacks"
        titleLabel.font = .boldSystemFont(ofSize: 30)
        titleLabel.textAlignment = .center
        
        let image1 = UIImageView(image:(UIImage(named: "oreo")))
        let image2 = UIImageView(image:(UIImage(named: "pizza")))
        let image3 = UIImageView(image:(UIImage(named: "popsicle")))
        let image4 = UIImageView(image:(UIImage(named: "poptart")))
        let image5 = UIImageView(image:(UIImage(named: "ramen")))
        let images = [image1, image2, image3, image4, image5]

        stackView = UIStackView(frame: CGRect(x: 0, y: 88, width: view.frame.width, height: 88))
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        for i in 0..<images.count {
            images[i].isUserInteractionEnabled = true
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addItem(_:)))
            images[i].addGestureRecognizer(tapGestureRecognizer)
            images[i].tag = i
            stackView.addArrangedSubview(images[i])
        }
        stackView.isHidden = true
        navBarView.addSubview(stackView)
        
        stackView.leadingAnchor.constraint(equalTo: navBarView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: navBarView.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: navBarView.bottomAnchor).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        tableView.fillerRowHeight = 44
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @objc func addItem(_ sender: UITapGestureRecognizer) {
        if isBarShown {
            if let index = sender.view?.tag {
                order.append(snacks[index])
                tableView.reloadData()
                print(order)
            }
        }
    }

    @IBAction func plusIconPressed(_ sender: UIButton) {
        if !isBarShown {
            UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 2, options: .curveEaseInOut, animations: {
                self.stackView.isHidden = false
                self.heightConstraint.constant = 200
                self.plusButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 0.25)
                self.titleConstraint.constant = -30
                self.view.layoutIfNeeded()
            }, completion: nil)
        } else {
            UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 2, options: .curveEaseInOut, animations: {
                self.stackView.isHidden = true
                self.heightConstraint.constant = 108
                self.plusButton.transform = CGAffineTransform(rotationAngle: -CGFloat.pi * 0.25)
                self.titleConstraint.constant = 20
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
        isBarShown.toggle()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        order.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath)
        cell.textLabel?.text = order[indexPath.row]
        return cell
    }
    
    
}

