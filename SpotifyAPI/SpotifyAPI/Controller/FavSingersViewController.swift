//
//  FavSingersViewController.swift
//  iTunesSearch
//
//  Created by Angel Zambrano on 2/11/22.
//

import UIKit



class FavSingersViewController: UIViewController,FavArtDelegate {
    
    let token = "BQA5tLMdqFAdFlaXsbYP-y4Hp3ShTvC0VzO5nUysgmGb5twrwzozZumXruSVmLrQmEj_zuWHDGTuSTK1f8Q"
    
    private var singersGridCollectionView: UICollectionView! // the collection that displays people
    private var pickedArtistsCollectionView: UICollectionView! // the collection that includes the artists that have been picked
    private var favoriteGenresLbl: UILabel = UILabel() // the filter label that describes the collection
    
    var searching = false // this tells us if the search bar is being used
    var  arti: [Artist] = []
    
    // the artists the user has chosen
    var values = [Artist]()

    // when searching for an artist this is shown
    var filteredSingers = [Artist]()
    
    
    
    fileprivate let emailTextField: UITextField = {
        let tf = CustomTextfield(padding: 16, height: 50)
        tf.placeholder = "enter name"
        tf.addTarget(self, action: #selector(textfieldDidChange), for: .editingChanged)
        tf.textContentType = .oneTimeCode
        return tf
    }()
    
    
    
    private var people: [Artist] = [] // people sorted by filters
    
    // Constants for the filter collection view
    private let peopleCellReuseIdentifier = "peopleCellReuseIdentifier"
    private let pickedArtistsReuseIdentifier = "colorCellReuseIdentifier"

    private let artistController = SpotifyArtistController()

    fileprivate let gestureView = UIView()

    let favArtists = ["790FomKkXshlbRYZFtlgla","4obzFoKoKRHIphyHzJ35G3,0XwVARXT135rw8lyw1EeWP,1uNFoZAHBGtllmzznpCI3s",
                      "6qqNVTkY8uBg9cP3Jd7DAH","2C6i0I5RiGzDKN9IAF8reh", "60d24wfXkVzDSfLS6hyCjZ", "76YIoWHp3Ri3q1ocOPtFzp", "1vCWHaC5f2uS3yhpwWbIA6", "5K4W6rqBFWDnAN6FQUkS6x"
    
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.

        
        navigationItem.hidesBackButton = true

        // adding that gesture
        view.addSubview(gestureView)
        gestureView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading:  view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
        
        setUpTapGesture()
        
        setUpLayout()
       
        // this fetches the artists we start off with
        fetchHomeArtists()
       
    }
    

    // this fetches all of the artists
    fileprivate func fetchHomeArtists() {
        
        artistController.getArtists(with: favArtists) { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    if let artist = items {
                        self.people = artist.artists
                        self.singersGridCollectionView.reloadData()
                        self.filteredSingers = []
                  }
                }
            case .failure(let error):
                // otherwise, print an error to the console
                print(error)
            }
        }
    }
    
    

    
    func fetchRelatedArtists(artistId: String) {
        
        artistController.getRelatedArtistss(artistId: artistId) { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    if let artist = items {
                        self.people = artist.artists
                        self.filteredSingers = []
                        self.singersGridCollectionView.reloadData()
                  }
                }
            case .failure(let error):
                // otherwise, print an error to the console
                print(error)
            }
        }
        
    }
    
    
    
    
    
    func configure(cell: SingerCollectionViewCell, forItemPath indexpath: IndexPath, isPeople: Bool) {
         // set up the artists page
        // gets the artists
        let art = (isPeople) ? people[indexpath.row] : filteredSingers[indexpath.row]
        
        
        // configures the title of the artist.
        cell.configure(singer: art)
        
        Task {
            do {
                // TODO:
                if art.images.isEmpty {
                    print("image is empty")
                    cell.configureImage(image: UIImage(named: "Ellipse 2"))
                    return
                }
               
                guard let url = URL(string:  art.images[0].url) else {return}
                let image = try await NetworkManager.fetchImage(from: url)
                        cell.configureImage(image: image)
            } catch { // prints an error
                print(error)
                
            }
        }
        
    }
    
    // configures
    //
    func configure(cell: FavArtistCollectionViewCell, forItemPathAt indexpath: IndexPath) {
        let art = values[indexpath.item]
        // sets the name of the artist
        cell.conf(str: art.name)
        
        // setting the  image
        
        // setting up the task
        Task {
            do {
                if art.images.isEmpty {
                    cell.conf(img: UIImage(named:"Ellipse 2"))
                    return
                }
               
                guard let url = URL(string:  art.images[0].url) else {return}
                let image = try await NetworkManager.fetchImage(from: url)
                cell.conf(img: image)
            } catch { // prints an error
                print(error)
                
            }
        }
        

    }

    
    
    // MARK: gesture methods
    
    fileprivate func setUpTapGesture() {
        gestureView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
    }
    
    
    @objc func handleTapDismiss() {
        self.view.endEditing(true) // dismiss keyboard
        // adding animate method
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.view.transform = .identity
        }
    }
    

    
    // MARK: action methods
    
    /// deals with the next button being pressed
    @objc fileprivate func nextButtonWasPressed() {
        if values.count == 5 {
        }
        
    }
    
    
    func fetchArtistsGivenText(text: String) {
       
              
        artistController.searchby(searchingString: text) { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    if let artist = items?.artists?.items {
                        self.filteredSingers = artist
                        self.singersGridCollectionView.reloadData()
                  }
                }
            case .failure(let error):
                    
                print(error)
            }
        }
        
        
    }
    
    
    @objc func textfieldDidChange(textfield: UITextField) {
        guard let searchText = textfield.text else {return}
        
        if textfield.text ==  "" {
            filteredSingers = []
            searching = false
            singersGridCollectionView.reloadData()
        } else {
            searching = true
            fetchArtistsGivenText(text: searchText)
        }
        
    }
    
    // MARK: methods
    
    // deals with the layout
    // TODO: Refactor some more
    fileprivate func setUpCollectionViews() {
        //        // set up the filtCollectionView
        // TODO 2: Setup flow layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let peopleLayout = UICollectionViewFlowLayout()
        peopleLayout.scrollDirection = .vertical
        
        let chosenArtistsLayout = UICollectionViewFlowLayout()
        chosenArtistsLayout.scrollDirection = .horizontal
        chosenArtistsLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        chosenArtistsLayout.invalidateLayout()
        chosenArtistsLayout.sectionInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        chosenArtistsLayout.minimumLineSpacing = 20
        chosenArtistsLayout.minimumInteritemSpacing = 20
        
        
        view.backgroundColor = .white
        
        // TODO 1: Instantiate collectionView
        singersGridCollectionView = UICollectionView(frame: .zero, collectionViewLayout: peopleLayout)
        singersGridCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        // setting up chosen artists
        pickedArtistsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: chosenArtistsLayout)
        pickedArtistsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        pickedArtistsCollectionView.backgroundColor = .clear
        
        
        
        // TODO 3: Create collection view cell and register it here.
        // TODO 3a: Add content to collection view cell.
        // TODO 3b: Create function to configure collection view cell.
        
        singersGridCollectionView.register(SingerCollectionViewCell.self, forCellWithReuseIdentifier: peopleCellReuseIdentifier)
        pickedArtistsCollectionView.register(FavArtistCollectionViewCell.self, forCellWithReuseIdentifier: pickedArtistsReuseIdentifier)
        
        
        singersGridCollectionView.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        
        //  TODO 4: Extend collection view data source.
        singersGridCollectionView.dataSource = self
        pickedArtistsCollectionView.dataSource = self
        //
        
        singersGridCollectionView.delegate = self
        
        view.addSubview(pickedArtistsCollectionView)
        
        view.addSubview(singersGridCollectionView)
        singersGridCollectionView.clipsToBounds = true
    }
    
    fileprivate func setUpLayout() {
        // adding fake data
        people = fakeData()
    
    
        // adding your favorite artists
        favoriteGenresLbl.translatesAutoresizingMaskIntoConstraints = false
        favoriteGenresLbl.font = UIFont(name: "Poppins-Bold", size: 24)
        favoriteGenresLbl.textColor =  .black
        favoriteGenresLbl.text = "Favorite Artists"
        view.addSubview(favoriteGenresLbl)
        
        
        setUpCollectionViews()
        
        setupConstraints()
        
      
    }
    
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        singersGridCollectionView.layer.cornerRadius = 8
        emailTextField.addUnderLine()
    }
    
    
    // conforming to delegate
    func delete(cell: FavArtistCollectionViewCell) {

        // TODO:
        if let indexpath = pickedArtistsCollectionView.indexPath(for: cell) {
            // delete photo from data source
            values.remove(at: indexpath.item)
            
            //
            pickedArtistsCollectionView.deleteItems(at: [indexpath])
        }
    }
    
    // sets up the constraints for the collectionViews
    func setupConstraints() {
        
        
        favoriteGenresLbl.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 47, left: 25, bottom: 0, right: 25))
        
        
        // adding the email textfield
        view.addSubview(emailTextField)
        
        emailTextField.anchor(top: favoriteGenresLbl.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 34, left: 25, bottom: 0, right: 25))
        

//        pickedArtistsCollectionView.backgroundColor = .blue
        pickedArtistsCollectionView.anchor(top: emailTextField.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: 70))
        
//        pickedArtistsCollectionView.backgroundColor = .red
        

        
        NSLayoutConstraint.activate([
            singersGridCollectionView.topAnchor.constraint(equalTo: pickedArtistsCollectionView.bottomAnchor, constant: 17),
            singersGridCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            singersGridCollectionView.heightAnchor.constraint(equalToConstant: 330),
//            SingersGridCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            
            singersGridCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        
        ])
        
        // setting up the next button
        
    }
    
    // MARK: helper methods
    
    func fakeData() -> [Artist] {
        let artistsFakeDate = [Artist]()
        
        return artistsFakeDate
    }
    

}


extension FavSingersViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        if collectionView == singersGridCollectionView {
            if searching {
                return filteredSingers.count
            }
            return people.count
        } else {
            return values.count
        }
        

        
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
        
        if collectionView == singersGridCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: peopleCellReuseIdentifier, for: indexPath) as! SingerCollectionViewCell
                        
            
            if searching {
                configure(cell: cell, forItemPath: indexPath,isPeople: false)
            } else {

                configure(cell: cell, forItemPath: indexPath, isPeople: true)
            }
            
        
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pickedArtistsReuseIdentifier, for: indexPath) as! FavArtistCollectionViewCell
            cell.delegate = self
            
            configure(cell: cell, forItemPathAt: indexPath)
//            cell.conf(str: values[indexPath.item].name)
            return cell
        }
    
        
    }

}

// Set up for the collectionView
extension FavSingersViewController: UICollectionViewDelegateFlowLayout {
    // TODO 5a: override default flow (optional, has default flow).
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
   
        if collectionView == singersGridCollectionView {
            return CGSize(width: (collectionView.frame.size.width/3) - 20  , height: (collectionView.frame.size.height/3) - 20   )
        }
        
        return CGSize(width: 38, height: 38)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 14
        
        
    }
    
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == singersGridCollectionView {
            return UIEdgeInsets(top: 15, left: 20, bottom: 20, right: 20)

        }
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0
        )
    }
//

}


// TODO: refactor
extension FavSingersViewController: UICollectionViewDelegate {
    // TODO 9: provide selection functionality
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == singersGridCollectionView  {
            // check if it has existed and do not add if it hasnt existed.
        
            if values.count < 5  {
               
                if filteredSingers.isEmpty {
                    
                    if !values.contains(where: {$0.name == people[indexPath.row].name})  {
                        
                        let p = people[indexPath.row]
                        
                        print(p.name)
                        values.append( people[indexPath.row])
                            
                        fetchRelatedArtists(artistId: people[indexPath.row].id)
                    }
                    
                   
                } else {
                    
                    if !values.contains(where: {$0.name == filteredSingers[indexPath.row].name})  {
                        let p = filteredSingers[indexPath.row]
                        print(p.name)
                        values.append(filteredSingers[indexPath.row])
                    }
   
                }
                pickedArtistsCollectionView.reloadData()
            }

        }
        }
    }
