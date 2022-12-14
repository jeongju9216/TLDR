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
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if BaseData.shared.isNeedForcedUpdate {
            forceUpdate()
        } else {
            addTargets()
            addObservers()
            addDelegate()
            
            bind()
        }
    }
    
    //MARK: - Methods
    private func bind() {
        homeVM.text.bind { [weak self] text in
            guard let self = self else {
                return
            }
            
            self.layoutView.setText(text) //텍스트 설정
            self.layoutView.setEnabled(!text.isEmpty) //입력 안 하면 비활성화
        }
    }
        
    //MARK: - Actions
    //요약 버튼 클릭
    @objc private func clickedSummarizeButton() {
        LoadingIndicator.showLoading(self)
        
        Task {
            do {
                let summarizeData: SummarizeData = try await homeVM.summarizeText()
                
                goSummarizeVC(summarizeData)
            } catch HttpError.summarizeError(let message) {
                Logger.error("error message: \(message)")
                self.showErrorAlert(message: message)
            } catch {
                Logger.error(error.localizedDescription)
                self.showErrorAlert()
            }
            
            LoadingIndicator.hideLoading(self)
        }
    }
    
    @objc private func clickedInfoButton() {
        let infoVC: InfoViewController = InfoViewController()
        self.present(infoVC, animated: true)
    }
    
    //붙여넣기 버튼
    @objc private func clickedPasteButton() {
        //클립보드에서 복사한 텍스트 가져오기
        if let pasteString = UIPasteboard.general.string {
            //기존에 입력한 텍스트 + 복사한 텍스트
            homeVM.updateText(homeVM.text.value + pasteString)
        }
    }
    
    //초기화 버튼
    @objc private func clickedResetButton() {
        homeVM.resetText()
    }
    
    //키보드 숨겼을 때
    @objc private func clickedHideKeyboardButton() {
        self.layoutView.showTopBar()
        self.layoutView.showSummarizeButton()
        
        self.layoutView.textView.endEditing(true)
    }
    
    //키보드 보였을 때
    @objc func keyboardWillShow(notification: NSNotification) {
        self.layoutView.hideTopBar()
        self.layoutView.hideSummarizeButton()
    }
    
    //MARK: - Methods
    private func goSummarizeVC(_ summarizeData: SummarizeData) {
        DispatchQueue.main.async {
            //summarizeData 전달하면서 VC 생성
            let summarizeVC: SummarizeViewController = SummarizeViewController(summarizeData: summarizeData)
            
            self.navigationController?.pushViewController(summarizeVC, animated: true)
        }
    }
    
    private func forceUpdate() {
        self.showAlert(title: "업데이트",
                       message: "새로운 버전으로 업데이트를 해야합니다.\n확인을 누르면 앱스토어로 이동합니다.",
                       action: { _ in
            if let url = URL(string: BaseData.shared.appStoreOpenUrlString) {
                UIApplication.shared.open(url, options: [:]) { _ in
                    exit(0)
                }
            }
        })
    }
            
    private func addTargets() {
        //매개변수 3개 이상은 세로로 분리
        self.layoutView.summarizeButton.addTarget(self,
                                                  action: #selector(clickedSummarizeButton),
                                                  for: .touchUpInside)
        self.layoutView.infoButton.addTarget(self,
                                                  action: #selector(clickedInfoButton),
                                                  for: .touchUpInside)
        self.layoutView.hideKeyboardButton.addTarget(self,
                                                     action: #selector(clickedHideKeyboardButton),
                                                     for: .touchUpInside)
        self.layoutView.pasteButton.addTarget(self,
                                              action: #selector(clickedPasteButton),
                                              for: .touchUpInside)
        self.layoutView.resetButton.addTarget(self,
                                              action: #selector(clickedResetButton),
                                              for: .touchUpInside)
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

extension HomeViewController: UITextViewDelegate {
    //입력이 완료되었을 때 값 넣기
    func textViewDidEndEditing(_ textView: UITextView) {
        self.homeVM.updateText(textView.text)
    }
}
