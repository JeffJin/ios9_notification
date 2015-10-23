

import Foundation

@objc public class EventDetailsViewModel : NSObject {
    let defaultImage: NSString = "default-no-image.png"
    
    //MARK: Properties
    
    dynamic var searchText = ""
    dynamic var previousSearches: [PreviousSearchViewModel]
    var executeSearch: RACCommand!
    let title = "Event Search"
    var previousSearchSelected: RACCommand!
    var connectionErrors: RACSignal!
    
    private let services: ViewModelServices
    
    //MARK: Public APIprintln
    
    init(services: ViewModelServices) {
        
        self.services = services
        self.previousSearches = []
        
        super.init()
        
        setupRac()
    }
    
    func setupRac(){
              

    }
    
    public func getImage(imageLink:String) -> UIImage{
        if(imageLink != ""){
            var url: NSURL = NSURL(string:  imageLink)!
            var imageData = NSData(contentsOfURL: url)!
            return UIImage(data: imageData)!
        }
        else{
            return UIImage(named: self.defaultImage as String)!
        }
    }
    
    
}

