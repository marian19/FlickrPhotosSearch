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
    @IBOutlet weak var tableview: UITableView!
    
    var presenter : SearchByKeywordViewPresenterProtocol?
    var photos : [Photo] = []
    var progressView : MBProgressHUD?
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter  = SearchByKeywordPresenter(view: self)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        
        print(searchBar.text ?? "default value")
        
        photos = []
        tableview.reloadData()
        if presenter != nil {
            progressView = self.showGlobalProgressHUDWithTitle(view: self.view, title: nil)
            
            presenter?.searchWithKeyword(keyword: searchBar.text!)
            
        }
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func showSearchResult(photoArray : [Photo]){
        DispatchQueue.main.async  {
            self.progressView?.hide(animated: true)
            self.photos.append(contentsOf: photoArray)
            self.tableview.reloadData()
        }
    }
    
    func showErrorMsg(msg : String){
        self.alert(message: msg)
    }
    
    
    
    //MARK: - UITableView Data Source/Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if photos.count > 0 {
            return self.photos.count
            
        }else{
            
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let photo = photos[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! PhotoTableViewCell
        
        cell.titleLabel.text = photo.title
        
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

extension SearchByKeywordViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate{
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "There is no photos")
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "You can start searching for photos.")
    }
}
