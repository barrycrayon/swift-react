//: A Simple ReactJS like implementation in Swift

import UIKit
import XCPlayground

//: A simple User model
class User {
    
    enum FavColour {
        case Red
        case Green
        case Blue
    }
    
    let id: Int
    var name: String
    var emailAddress: String
    var favouriteColour = FavColour.Red
    
    init(id: Int, name: String, emailAddress: String) {
        self.id = id
        self.name = name
        self.emailAddress = emailAddress
    }
    
}

//: Presenters are simple read only structs that calculate their values from the current state of the model (UI as a function of state)
struct UserPresenter {
    
    let user: User
    
    var id: String {
        return "UserId: \(self.user.id)"
    }
    
    var name: String {
        return "Name: "+self.user.name
    }
    
    var emailAddress: String {
        return "Email: "+self.user.emailAddress
    }
    
    var favouriteColour: UIColor {
        switch self.user.favouriteColour {
            case .Red:
                return UIColor.redColor()
            case .Green:
                return UIColor.greenColor()
            case .Blue:
                return UIColor.blueColor()
        }
    }
    
    // MARK: -
    
    init(user: User) {
        self.user = user
    }
    
}

class UserProfileViewController: UIViewController {
    
    var presenter: UserPresenter!
    let user = User(
        id: 1,
        name: "Homer Simpson",
        emailAddress: "homer@burnspower.com"
    )
    
//: These would normally be IBOutlets and init'd from the storyboard
    let userIdLabel = UILabel(frame: CGRect(x:0, y:0, width:320, height:100))
    let userNameLabel = UILabel(frame: CGRect(x:0, y:100, width:320, height:100))
    let userEmailLabel = UILabel(frame: CGRect(x:0, y:200, width:320, height:100))
    let button = UIButton(frame: CGRect(x:0, y:300, width:200, height:100))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.layoutViews()
        
//: Set up the presenter
        self.presenter = UserPresenter(user: self.user)
        
//: Call render to set the initial UI
        self.render(self.presenter)
    }
    
//: Any UI that can change based on state is set in here, this should be the only method you need to call to set up or change your UI
    func render(userPresenter: UserPresenter) {
        // set the label values
        self.userIdLabel.text = userPresenter.id
        self.userNameLabel.text = userPresenter.name
        self.userEmailLabel.text = userPresenter.emailAddress
        
        // set the label colours
        self.userIdLabel.textColor = userPresenter.favouriteColour
        self.userNameLabel.textColor = userPresenter.favouriteColour
        self.userEmailLabel.textColor = userPresenter.favouriteColour
    }
    
    func layoutViews() {
        self.view.addSubview(self.userIdLabel)
        self.view.addSubview(self.userNameLabel)
        self.view.addSubview(self.userEmailLabel)
        
        self.view.addSubview(self.button)
        self.button.setTitle("Press", forState: .Normal)
        self.button.addTarget(self, action: Selector("someViewThingHappend"), forControlEvents: .TouchUpInside)
        self.button.setTitleColor(UIColor.blackColor(), forState: .Normal)
    }
    
    @IBAction func someViewThingHappend() {
        // update the model
        self.user.name = "Fred Flintstone"
        self.user.emailAddress = "fred@bedrock.com"
        self.user.favouriteColour = .Blue
        
        // re-render now model has changed
        self.render(self.presenter)
    }
    
}

let vc = UserProfileViewController()
XCPShowView("React Demo", vc.view)

//: Button press isn't working, so simulate the button press here by uncommenting the line below
//vc.someViewThingHappend()





