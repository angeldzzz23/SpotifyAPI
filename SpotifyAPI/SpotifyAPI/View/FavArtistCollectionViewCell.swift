//
//  FavArtistCollectionViewCell.swift
//  iTunesSearch
//
//  Created by Angel Zambrano on 2/11/22.
//

import UIKit


protocol FavArtDelegate: AnyObject {
    func delete(cell: FavArtistCollectionViewCell)
}




class FavArtistCollectionViewCell: UICollectionViewCell {
    private var filtLabel: UILabel = UILabel()
    
    private var button: UIButton = UIButton(type: .system)
    private var imageOfSinger = UIImageView()
    
    weak var delegate: FavArtDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        filtLabel.translatesAutoresizingMaskIntoConstraints = false
        filtLabel.font = UIFont.systemFont(ofSize: 14)
        
        filtLabel.textColor = .white
        filtLabel.text = "WEED"
        contentView.addSubview(filtLabel)
       

        contentView.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
    
        contentView.layer.cornerRadius = 22
        
    
        
        
        button.imageView?.image = UIImage(named: "close-4")!
        button.setImage(UIImage(named: "close-4")!, for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.widthAnchor.constraint(equalToConstant: 10).isActive = true
        button.imageView?.heightAnchor.constraint(equalToConstant: 10).isActive = true
        button.addTarget(self, action: #selector(buttonWasPressed), for: .touchUpInside)

        
        
            
        contentView.addSubview(button)

        // adding the subview
        
        imageOfSinger.image = UIImage(named: "Ellipse 2")!
        imageOfSinger.translatesAutoresizingMaskIntoConstraints = false
        imageOfSinger.layer.borderWidth = 2
        imageOfSinger.layer.borderColor = .init(red: 1, green: 1, blue: 1, alpha: 1) // sets the color to white
        
        
        imageOfSinger.clipsToBounds = true
        imageOfSinger.contentMode = .scaleAspectFill
        
//        imageOfSinger.backgroundColor = .red
        contentView.addSubview(imageOfSinger)
        
        
        contentView.backgroundColor = .init(red: 46/255, green: 78/255, blue: 136/255, alpha: 1)
        setUpConstraints()
        
        imageOfSinger.layer.cornerRadius = 19
    }
    
    // delete button was called
    @objc func buttonWasPressed() {
        delegate?.delete(cell: self)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // TODO: this has an error somewhere
    // for some reason this throwws some type of error.
    func setUpConstraints() {
           
        NSLayoutConstraint.activate([
                      imageOfSinger.widthAnchor.constraint(equalToConstant: 38),
                      imageOfSinger.heightAnchor.constraint(equalToConstant: 38),
                      imageOfSinger.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
                      imageOfSinger.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
                      imageOfSinger.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
                      imageOfSinger.trailingAnchor.constraint(equalTo: filtLabel.leadingAnchor, constant: -8)

                  ])
                  
                  NSLayoutConstraint.activate([
          
                      filtLabel.centerYAnchor.constraint(equalTo: imageOfSinger.centerYAnchor),
          
                      filtLabel.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: -8),
          
                  ])
                  
              
                  
                  NSLayoutConstraint.activate([
                      button.centerYAnchor.constraint(equalTo: imageOfSinger.centerYAnchor),
                      button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
                      button.widthAnchor.constraint(equalToConstant: 11),
                      button.heightAnchor.constraint(equalToConstant: 11),
                  ])
                  
            

            
        }
    
    
    // configuring images
    func conf(str: String) {
        filtLabel.text = str

    }
    
    func conf(img: UIImage?) {
        if let img = img {
            imageOfSinger.image = img
        }
    }
    
}
