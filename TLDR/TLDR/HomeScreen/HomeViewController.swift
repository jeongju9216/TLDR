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
             
        addTargets()
        addObservers()
        addDelegate()
        
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //커스텀 네비게이션 사용함
        self.navigationController?.navigationBar.isHidden = true
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
                
                LoadingIndicator.hideLoading(self)
            } catch HttpError.summarizeError(let message) {
                Logger.error("error message: \(message)")
                self.showErrorAlert(message: message)
            } catch {
                Logger.error(error.localizedDescription)
                self.showErrorAlert()
            }
        }
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
        
    private func addTargets() {
        //매개변수 3개 이상은 세로로 분리
        self.layoutView.summarizeButton.addTarget(self,
                                                  action: #selector(clickedSummarizeButton),
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
