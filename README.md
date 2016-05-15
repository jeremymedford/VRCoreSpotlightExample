# VRCoreSpotlightExample
CoreSpotlight Search Example

 # Integrating your app into Spotlight Search for iOS

## Background

Our sample project consists of a short list of parks in San Francisco. This is a subset of the much larger database of parks and includes just a few details and a thumbnail image for each park. Initially, the app presents a list of the parks. When a specific park is tapped in the list, a detail view is presented. Pretty simple. 

What we'd like to do is to add a park to the Spotlight index at the point when the park is tapped from the list. That way, in the future if the user searches for that park by name in Spotlight, they will see the item, be able to tap on it and from there be taken directly to the app's details for that specific park. 

What follows is the steps needed to add this ability to the app. The sample app (minus the CoreSpotlight code) can be downloaded here. As we go along we'll be updating the project with code snippets. 

## Implementation

Open the Xcode project file, and run it in the simulator under the iPhone device of your choice. A list of parks After tapping on a few parks, go to the 'Home' screen and bring down the Searchlight bar. Enter one of the parks by name. Note that no item appears from our VRCoreSpotlightExample app.

(Image)

Now, stop the app and let's add the Spotlight Search functionality.

#### Importing the Necessary Frameworks

1. Select the 'VRCoreSpotlightExample' project in then Project Navigator
2. Select the 'VRCoreSpotlightExample' target underneath TARGETS
3. Be sure 'General' is displayed (Image)
4. From here go down to the 'Linked Frameworks and Binaries' section and tap the '+' icon
5. Select CoreSpotlight.framework from the list and click 'Add'
6. Repeat steps 4 and 5 for MobileCoreServices.framework

Both frameworks should now be visible in the list. Keep the Status as 'Required' since this is an iOS 9 and greater project.

### Adding the searchable items to the index

From the Project Navigator, open VRParksViewController.swift. For this example we want to add the park to be indexed at the point where we select it in the list. Locate the following section of code: 

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      let park = parks[indexPath.row]

      // 1. Create attribute set with desired metadata for the index item

      // 2. Create item with unique id, a domain id, and the attribute set

      // 3. Add item to default searchable index

    pushDetailsController(park)
    }

Add the following code snippets underneath the corresponding number in comments.

1. Create the CSSearchableItemAttributeSet, passing in the content type of "kUTTypeImage" since we will be using image data for the item.
 
		let parkName = park.name
		let attributeSet = CSSearchableItemAttributeSet(itemContentType: "kUTTypeImage")
		attributeSet.title = parkName
		attributeSet.contentDescription = "Learn what \(parkName) has to offer!"
    
		let thumbnail = UIImage(named: park.thumb)
		let thumbnailData = UIImagePNGRepresentation(thumbnail!)
		attributeSet.thumbnailData = thumbnailData
  
2. Create a CSSearchableItem to represent the park we wish to index.

		let item = CSSearchableItem(uniqueIdentifier: parkName, domainIdentifier: "Parks", attributeSet: attributeSet)
    
3. Add the items to the default searchable index.

		CSSearchableIndex.defaultSearchableIndex().indexSearchableItems([item]) { (error: NSError?) in
			if let error = error {
				print("Error indexing items: \(error.localizedDescription)")
			}
		}

To summarize what we just did...
The CSSearchableItem is an object that represents an item that can be indexed and returned in Spotlight when users search on their devices. First we created an attribute set that contains properties that specify the metadata you want to display about an item in a search result. Note that the image must be NSData format to be included in the attribute set. The domainIdentifier can be useful if your app contains categories of searchable items that you'd like to group accordingly.

The CSSearchableIndex class defines an object that represents the on-device index. We call indexSearchItems() to update the index with an array of items. In this scenario we are adding one at a time.

Go ahead and run the app. Tap on a couple of parks to ensure they are added to the index. To see a park in Spotlight, navigate back out to the Home screen, pull down to reveal the Spotlight Search Bar. Type in one of the parks you tapped in the app. The park should appear with its thumbnail like the screenshot below. It may require scrolling depending on which park you typed.

(Image)

The restoring process 

In the AppDelegate.swift we make use of the existing UIApplicationDelegate method:
    func application(application: UIApplication, continueUserActivity userActivity: NSUserActivity, restorationHandler: ([AnyObject]?) -> Void) -> Bool {
    
        // 4. Capture activity type and pass unique id to VRParksViewController to load correct park
    
        return true
    }

    4. Add the necessary code to inspect the activity type and have the app perform the necessary action
    let type = userActivity.activityType
    
    if type == CSSearchableItemActionType {
    
        let uniqueIdentifier = userActivity.userInfo?[CSSearchableItemActivityIdentifier] as? String
    
        let navController = self.window!.rootViewController as! UINavigationController
        if let parksVC = navController.topViewController as? VRParksViewController {
            parksVC.showPark(uniqueIdentifier)
        }
    }

The important parts of this code are the userActivity.activityType being CSSearchItemActionType, and accessing the 'uniqueIdentifier' with the userActivity.userInfo dictionary. From their we just need to tell our VRParksViewController that we'd like to show the Park that corresponds to the uniqueIdentifier we specified at the time of creating the CSSearchableItems. Great, now run the app, perform a Spotlight search, and tap the corresponding park. The app should open up to that specific park detail view.

More Information

A couple of additional topics I did not cover in this article relate to updating and removing index items.

For updating, the steps are exactly the same as adding a new item. Since the item is identified by the uniqueIdentifier, the associated item is updating for you automatically when adding it via CSSearchableIndex.defaultSearchableIndex().indexSearchableItems.

For removing an item, call
    deleteSearchableItemsWithIdentifiers(_ identifiers: [String], completionHandler completionHandler: ((NSError?) -> Void)?) 
  
and pass in either an array of identifiers ["Mission Dolores Park", "Hayes Valley Playground"] or by domainIdentifier,
    deleteSearchableItemsWithDomainIdentifiers(_ domainIdentifiers: [String], completionHandler completionHandler: ((NSError?) -> Void)?) 
and pass in an array of domain identifiers, ["Parks"]. Awesome. For more information check out these resources:

[Introducing Search APIs][https://developer.apple.com/videos/play/wwdc2015/709/]
[CoreSpotlight Framework Reference][https://developer.apple.com/library/ios/documentation/CoreSpotlight/Reference/CoreSpotlight_Framework/]
