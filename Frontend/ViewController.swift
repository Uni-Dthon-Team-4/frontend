//
//  ViewController.swift
//  Frontend
//
//  Created by Jaeho Lee on 11/2/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    private func setupData() {
        let request = HomeRequest(page: 0)
        
        HomeService.getHomePost(request: request) { [weak self] data, failed in
            guard let data = data else {
                // 에러가 난 경우, alert 창 present
                switch failed {
                case .disconnected:
                    self?.present(UIAlertController.networkErrorAlert(title: failed!.localizedDescription), animated: true)
                case .serverError:
                    self?.present(UIAlertController.networkErrorAlert(title: failed!.localizedDescription), animated: true)
                case .unknownError:
                    self?.present(UIAlertController.networkErrorAlert(title: failed!.localizedDescription), animated: true)
                default:
                    self?.present(UIAlertController.networkErrorAlert(title: "요청에 실패하였습니다."), animated: true)
                }
                return
            }
            print("=== Home, setup data succeeded ===")
            print("== data: \(data)")
            
            self?.isLastPage = data.result.pageInfo.lastPage

            let newPosts = data.result.postList
            let startIndex = self?.postList.count
            let endIndex = startIndex! + newPosts.count
            let newIndexPathList = (startIndex! ..< endIndex).map { IndexPath(item: $0, section: 0) }

            self?.postList.append(contentsOf: newPosts)

            if self?.postList.count == 0 {
                self?.noPost = true
            }
            else {
                self?.noPost = false
            }

            print("== 보여주는 게시글 개수: \(self?.postList.count) ==")
            DispatchQueue.main.async {
                if self?.currentFetchingPage == 0 {
                    self?.collectionView.reloadData()
                }
                else {
                    self?.collectionView.insertItems(at: newIndexPathList)
                }

                self?.isCurrentlyFetching = false
                self?.currentFetchingPage += 1;
            }
        }
    }
}

