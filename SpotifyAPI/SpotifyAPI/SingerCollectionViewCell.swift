//
//  PeopleCollectionViewCell.swift
//  ProjectFive
//
//  Created by angel zambrano on 11/21/21.
//

import UIKit

class SingerCollectionViewCell: UICollectionViewCell {
    private var imgview: UIImageView = UIImageView() // the image of the user
    private var nameLbl: UILabel = UILabel() // the name of the user
    private var yearLbl: UILabel = UILabel() // the year of the user
    
    override init(frame: CGRect) {
        super.init(frame: frame) // adds the frame into the super view
        // set up for the content viww
 
        contentView.backgroundColor = .clear
        
//        contentView.backgroundColor = .red
        // set up for the name Label
        nameLbl.translatesAutoresizingMaskIntoConstraints = false
        nameLbl.font = UIFont.systemFont(ofSize: 12)
        nameLbl.textColor = .black
        nameLbl.text = "Connie Pena"
        nameLbl.textAlignment = .center
        nameLbl.numberOfLines = 1
//        nameLbl.backgroundColor = .blue
        
        
        contentView.addSubview(nameLbl)
        
        
        
        // adds the imgView
        imgview.translatesAutoresizingMaskIntoConstraints = false
        if let img = UIImage(named: "Ellipse 2") {
            imgview.image = img
        }
       
        contentView.addSubview(imgview)
        setUpConstraints()
        imgview.contentMode = .scaleAspectFit
    }
    
    // this is called what once all of views are layed out
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    
    
    // setting up the constraints for the imgView
    func setUpConstraints() {
    
        
        
        // sets the constrains for the imgView
        NSLayoutConstraint.activate([
            imgview.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            imgview.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imgview.widthAnchor.constraint(equalToConstant: 71),
            imgview.heightAnchor.constraint(equalToConstant: 71)
        ])
        
        imgview.layer.borderWidth = 2
        imgview.layer.borderColor = UIColor(red: 46/255, green: 78/255, blue: 136/255, alpha: 1).cgColor
        imgview.clipsToBounds = true
        imgview.layer.cornerRadius = 71 / 2
        
        // set the constrains for the
        NSLayoutConstraint.activate([
            nameLbl.topAnchor.constraint(equalTo: imgview.bottomAnchor, constant: 4),
            nameLbl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            nameLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            // make the botttom container bigger (closer to the posititive direction)
            // to allo more room, if not.
//            nameLbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3)
            
    
        ])
        
//        nameLbl.contentScaleFactor = 1000
        
        
    }
 
    
    
    // configure the collectionViewCell
    func configure(person: Person) {
//        imgview.image = person.img
        nameLbl.text = person.name
    }
    
    func configure(singer: Artist) {
        nameLbl.text = singer.name
        
//        nameLbl.text = singer.sing
    }
    
    func configureImage(image: UIImage?) {
        // checking if an image exists
        if let image2 =  image {
            imgview.image = image2
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension UIView {

  
    func addShadow2(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.masksToBounds = false
        layer.cornerRadius = radius
        layer.backgroundColor = UIColor.white.cgColor
        layer.borderColor = UIColor.clear.cgColor
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity =  opacity
        layer.shadowRadius = radius
       backgroundColor = UIColor.init(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
    }
}
