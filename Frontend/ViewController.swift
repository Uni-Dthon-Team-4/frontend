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
        
        NetworkExService.getHomePost(request: request) { [weak self] data, failed in
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
            
            /* 필요한 UI 변경 코드 .... */
        }
    }
}

