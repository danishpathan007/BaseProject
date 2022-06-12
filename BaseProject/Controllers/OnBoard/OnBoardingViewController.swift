import UIKit
/**
 OnBoardingViewController.swift
 
 This is the screen that is displayed after the splash screen when the user installs the app for the first time. This screen gives a brief detail about the application.
 
 - Date:
 08/12/2021
 
 - Version:
 1.0
 */

class OnBoardingViewController: UIViewController {
    //MARK: - Outlets -
    @IBOutlet private weak var pageControl: UIPageControl!
    @IBOutlet private weak var guideCollectionView: UICollectionView!
    @IBOutlet private weak var skipButton: UIButton!
    
    //MARK: - Variables -
    private var  displayedScreenIndex:Int?
    private var onBoardingDataModel: [OnBoardingData]!
    
    private struct OnBoardingData {
        var title:String?
        var description:String?
        var image:UIImage?
        var boldTitleText:String?
    }
    
//    lazy private var window: UIWindow? = {
//        return RootScreenUtility.window(for: view)
//    }()
    
    
    //MARK: - View Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setGuideScreenData()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.numberOfPages = onBoardingDataModel.count
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        pageControl.currentPage = 0
        displayedScreenIndex =  pageControl.currentPage
    }
    
    /*
     Manage Page Control Dot size
     */
    override func viewDidLayoutSubviews() {
        pageControl.subviews.forEach {
            $0.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }
    }
    
    
    //MARK:- Private Functions
    private func setGuideScreenData() {
        onBoardingDataModel = [
            OnBoardingData(title: "Create your Wedding Moment", description: "Be inspired by various wedding ideas and celebrate your dream wedding.", image: #imageLiteral(resourceName: "step1") ,boldTitleText: "Moment"),
            OnBoardingData(title: "Search the Wed-Vendors", description:  "Find a matching wedding vendors in your area and start connecting.", image: #imageLiteral(resourceName: "step2") ,boldTitleText: "Wed-Vendors"),
            OnBoardingData(title: "Looking for Wedding EO", description:  "Choose the service you are looking for and start matching with vendors. Plan your wedding the easy way.", image: #imageLiteral(resourceName: "step3") ,boldTitleText: "Wedding EO"),
            OnBoardingData(title: "We provide what you wish for", description: "Rebuild the connection and celebrate your wedding day.", image: #imageLiteral(resourceName: "step4") ,boldTitleText: "provide")
        ]
    }
    
    //MARK:-  IBActions
    @IBAction private func nextButtonTapped(_ sender: UIButton) {
        // At last page
        if displayedScreenIndex == onBoardingDataModel.count - 1 {
            //UserDefaultManager.sharedManager.setGuideScreen(true)
            //RootScreenUtility.setRootScreen(window: window)
            return
        }
        let indexPath = IndexPath(row: displayedScreenIndex! + 1, section: 0);
        guideCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        displayedScreenIndex! += 1
        pageControl.currentPage  = displayedScreenIndex!
    }
    
    @IBAction private func skipButtonTapped(_ sender: UIButton) {
        //UserDefaultManager.sharedManager.setGuideScreen(true)
        //RootScreenUtility.setRootScreen(window: window)
    }
    
}


//MARK:-  UICollectionViewDataSource
extension OnBoardingViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onBoardingDataModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = guideCollectionView.dequeueReusableCell(withReuseIdentifier: "OnBoardingCollectionViewCell", for: indexPath) as! OnBoardingCollectionViewCell
        
        let data = onBoardingDataModel[indexPath.row]
        
//        DispatchQueue.main.async {
//            cell.guideImageView.roundedImage()
//            cell.layoutIfNeeded()
//        }
        
        cell.setCellData(image: data.image!, title: data.title!, cellDescription: data.description!,boldText: data.boldTitleText!)
        return cell
    }
    
}


//MARK:-  Scroll View Delegates
extension OnBoardingViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
        displayedScreenIndex = pageControl.currentPage
        
        if displayedScreenIndex == onBoardingDataModel.count - 1 {
            skipButton.isHidden = true
        }else{
            skipButton.isHidden = false
        }
    }
}

//MARK:-  UICollectionViewDelegateFlowLayout
extension OnBoardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}



