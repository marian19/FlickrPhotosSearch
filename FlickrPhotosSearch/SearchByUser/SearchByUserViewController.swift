//
//  PhotosByUserViewController.swift
//  FlickrPhotosSearch
//
//  Created by Marian on 2/16/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import UIKit
import SDWebImage
import MBProgressHUD
import DZNEmptyDataSet


class SearchByUserViewController: BaseViewController ,SearchByUserPresenterViewProtocol,UITableViewDelegate ,UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter : SearchByUserViewPresenterProtocol?
    var photos : [Photo] = []
    var progressView : MBProgressHUD?
    var ownerID : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter  = SearchByUserPresenter(view: self)
        if presenter != nil {
            progressView = self.showGlobalProgressHUDWithTitle(view: self.view, title: nil)
            presenter?.searchWithUser(ownerID: ownerID!)
            
        }
        // Do any additional setup after loading the view.
    }
    
    //MARK: SearchByUserPresenterViewProtocol
    
    func showSearchResult(photoArray : [Photo]){
        DispatchQueue.main.async  {
            self.progressView!.hide(animated: false)
            self.photos.append(contentsOf: photoArray)
            self.tableView.reloadData()
        }
    }
    
    func showErrorMsg(msg : String){
        self.alert(message: msg)
    }
    
    
    //MARK: - UITableView Data Source/Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.photos.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let photo = photos[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! PhotoTableViewCell
        
        cell.titleLabel.text = photo.title
        cell.photoImageView.sd_setShowActivityIndicatorView(true)
        cell.photoImageView.sd_setIndicatorStyle(.gray)
        cell.photoImageView.sd_setImage(with: URL(string: photo.getPhotoThumbnailURL()))
        
        if indexPath.row == photos.count - 1 { // last cell
            progressView = self.showGlobalProgressHUDWithTitle(view: self.view, title: nil)
            presenter?.loadMorePhotos()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
}

//MARK: - DZNEmptyDataSet Source/Delegate

extension SearchByUserViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate{
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "NoPhotos".localized)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "")
    }
}

