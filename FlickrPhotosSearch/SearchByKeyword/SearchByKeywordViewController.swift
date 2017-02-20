//
//  SearchByKeywordViewController.swift
//  FlickrPhotosSearch
//
//  Created by Marian on 2/16/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import UIKit
import SDWebImage
import MBProgressHUD
import DZNEmptyDataSet

class SearchByKeywordViewController: BaseViewController ,UISearchBarDelegate ,SearchByKeywordPresenterViewProtocol,UITableViewDelegate ,UITableViewDataSource {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var presenter : SearchByKeywordViewPresenterProtocol?
    var photos : [Photo] = []
    var progressView : MBProgressHUD?
    var isNetworkValiable = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter  = SearchByKeywordPresenter(view: self)
        isNetworkValiable = NetworkUtil.getNetworkStatus()
        if isNetworkValiable == false {
            progressView = self.showGlobalProgressHUDWithTitle(view: self.view, title: nil)
            
            presenter?.getOfflinePhotos()
        }
    }
    
    //MARK:UISearchBarDelegate
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        searchBar.endEditing(true)
        
        isNetworkValiable = NetworkUtil.getNetworkStatus()
        if isNetworkValiable == false {
            
            self.alert(message: "Please check your connection and try again")
        }else{
            photos = []
            tableView.reloadData()
            if presenter != nil {
                progressView = self.showGlobalProgressHUDWithTitle(view: self.view, title: nil)
                presenter?.searchWithKeyword(keyword: searchBar.text!)
                
            }
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let indexPath = tableView.indexPathForSelectedRow{
            let selectedRow = indexPath.row
            let searchByUserViewController = segue.destination as! SearchByUserViewController
            searchByUserViewController.ownerID = photos[selectedRow].ownerID
        }
    }
    
    
    //MARK: SearchByKeywordPresenterViewProtocol
    
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
        
        if isNetworkValiable == false {
            cell.photoImageView.image = nil
            
            if photo.image != nil{
                cell.photoImageView.image = UIImage(data: photo.image as! Data , scale:1)
            }
            
        }else{
            cell.photoImageView.sd_setShowActivityIndicatorView(true)
            cell.photoImageView.sd_setIndicatorStyle(.gray)
            cell.photoImageView.sd_setImage(with: URL(string: photo.getPhotoThumbnailURL()))
            
            if indexPath.row == photos.count - 1 { // last cell
                progressView = self.showGlobalProgressHUDWithTitle(view: self.view, title: nil)
                presenter?.loadMorePhotos()
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
}

//MARK: - DZNEmptyDataSet Source/Delegate

extension SearchByKeywordViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate{
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "There is no photos")
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "You can start searching for photos.")
    }
}
