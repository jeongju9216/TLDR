//
//  HomeViewController.swift
//  TLDR
//
//  Created by 유정주 on 2022/08/31.
//

import UIKit

final class HomeViewController: BaseViewController<HomeView> {
    
    //MARK: - Properties
    private var homeVM: HomeViewModel = HomeViewModel()
    private var summarizeResultStorage = SummarizeResultStorage()
    
    private var currentText: String {
        return layoutView.textView.text
    }
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(summarizeResultStorage.fetch())
        
        if BaseData.shared.isNeedForcedUpdate {
            forceUpdate()
        } else {
            addTargets()
            addObservers()
            addDelegate()
        }
    }
            
    //MARK: - Actions
    //요약 버튼 클릭
    @objc private func clickedSummarizeButton() {
        LoadingIndicator.showLoading(self)
        
        Task {
            do {
                let summarizeResult: SummarizeResult = try await homeVM.action(.summarize(currentText)).value() as! SummarizeResult
                
                goSummarizeVC(summarizeResult)
            } catch HttpError.summarizeError(let message) {
                log(.error, "error message: \(message)")
                self.showErrorAlert(message: message)
            } catch {
                log(.error, "error: \(error.localizedDescription)")
                self.showErrorAlert()
            }
            
            LoadingIndicator.hideLoading(self)
        }
    }
    
    @objc private func clickedInfoButton() {
        let infoVC: InfoViewController = InfoViewController()
        present(infoVC, animated: true)
    }
    
    //붙여넣기 버튼
    @objc private func clickedPasteButton() {
        //클립보드에서 복사한 텍스트 가져오기
        guard let pasteString = UIPasteboard.general.string else { return }
        
        //기존에 입력한 텍스트 + 복사한 텍스트
        update(text: currentText + pasteString)
    }
    
    //초기화 버튼
    @objc private func clickedResetButton() {
        update(text: "")
    }
    
    //키보드 숨겼을 때
    @objc private func clickedHideKeyboardButton() {
        layoutView.showTopBar()
        layoutView.showSummarizeButton()
        
        layoutView.textView.endEditing(true)
    }
    
    //키보드 보였을 때
    @objc func keyboardWillShow(notification: NSNotification) {
        layoutView.hideTopBar()
        layoutView.hideSummarizeButton()
    }
    
    //MARK: - Methods
    private func forceUpdate() {
        showAlert(title: "업데이트",
                       message: "새로운 버전으로 업데이트를 해야합니다.\n확인을 누르면 앱스토어로 이동합니다.",
                       action: { _ in
            if let url = URL(string: BaseData.shared.appStoreOpenUrlString) {
                UIApplication.shared.open(url, options: [:]) { _ in
                    exit(0)
                }
            }
        })
    }

    private func update(text: String) {
        layoutView.setText(text) //텍스트 설정
        layoutView.setEnabled(!text.isEmpty) //입력 안 하면 비활성화
    }

    private func goSummarizeVC(_ summarizeResult: SummarizeResult) {
        DispatchQueue.main.async {
            //summarizeData 전달하면서 VC 생성
            let summarizeVC = SummarizeResultViewController(summarizeResult: summarizeResult)
            
            self.navigationController?.pushViewController(summarizeVC, animated: true)
        }
    }
                
    private func addTargets() {
        //매개변수 3개 이상은 세로로 분리
        layoutView.summarizeButton.addTarget(self, action: #selector(clickedSummarizeButton), for: .touchUpInside)
        layoutView.infoButton.addTarget(self, action: #selector(clickedInfoButton), for: .touchUpInside)
        layoutView.hideKeyboardButton.addTarget(self, action: #selector(clickedHideKeyboardButton), for: .touchUpInside)
        layoutView.pasteButton.addTarget(self, action: #selector(clickedPasteButton), for: .touchUpInside)
        layoutView.resetButton.addTarget(self, action: #selector(clickedResetButton), for: .touchUpInside)
    }
    
    private func addDelegate() {
        self.layoutView.textView.delegate = self
    }
    
    private func addObservers() {
        //키보드 Notification
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification ,
                                               object:nil)
    }
}

//MARK: - UITextViewDelegate
extension HomeViewController: UITextViewDelegate {
    //입력이 완료되었을 때 값 넣기
    func textViewDidEndEditing(_ textView: UITextView) {
        update(text: textView.text)
    }
}
