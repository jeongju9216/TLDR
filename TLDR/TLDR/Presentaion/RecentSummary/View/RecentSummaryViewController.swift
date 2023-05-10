//
//  RecentSummaryViewController.swift
//  TLDR
//
//  Created by 유정주 on 2023/05/05.
//

import UIKit
import Combine

final class RecentSummaryViewController: UIViewController, Alertable, Loggable {

    private typealias DataSource = UICollectionViewDiffableDataSource<Section, SummarizeResult>
    private typealias SnapShot = NSDiffableDataSourceSnapshot<Section, SummarizeResult>

    //MARK: - Views
    @IBOutlet weak var collectionView: UICollectionView!
    weak var delegate: RecentSummaryDelegate?
    
    //MARK: - Properties
    private var dataSource: DataSource!
    private var snapshot: SnapShot = SnapShot()
    
    private let viewModel: RecentSummaryViewModel = RecentSummaryViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        bind()
        
        try? viewModel.action(.recentSummary)
    }
    
    private func bind() {
        viewModel.$recentSummaries
            .receive(on: RunLoop.main)
            .sink { [weak self] recentSummaries in
                guard let self = self else { return }
                
                self.updateList(recentSummaries)
            }
            .store(in: &cancellables)
    }
    
    //MARK: - Actions
    @IBAction func clickedDeleteAllButton(_ sender: UIButton) {
        showCancelAlert(message: "모든 최근 요약을 삭제하겠습니까?", doneAction: { [weak self] _ in
            guard let self = self else { return }
            
            try? viewModel.action(.deleteAll)
        })
    }
    
    //MARK: - Methods
    private func updateList(_ recentSummaries: [SummarizeResult]) {
        snapshot.deleteAllItems()
        
        snapshot.appendSections([.recentSummary])
        snapshot.appendItems(recentSummaries)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    //MARK: - Setup
    private func setupCollectionView() {
        collectionView.delegate = self

        collectionView.collectionViewLayout = createCollectionViewLayout()
        collectionView.keyboardDismissMode = .onDrag

        collectionView.register(UINib(nibName: DefaultCollectionViewCell.identifier, bundle: nil),
                                forCellWithReuseIdentifier: DefaultCollectionViewCell.identifier)
        collectionView.register(UINib(nibName: RecentSummaryCollectionViewCell.identifier, bundle: nil),
                                forCellWithReuseIdentifier: RecentSummaryCollectionViewCell.identifier)
        
        setupDataSource()
    }
    
    private func setupDataSource() {
        let cellProvider = { [weak self] (collectionView: UICollectionView, indexPath: IndexPath, product: SummarizeResult) -> UICollectionViewCell? in
            let defaultCell = collectionView.dequeueReusableCell(withReuseIdentifier: DefaultCollectionViewCell.identifier, for: indexPath)
            guard let self = self,
                  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentSummaryCollectionViewCell.identifier, for: indexPath) as? RecentSummaryCollectionViewCell else {
                return defaultCell
            }
            
            cell.configuration(summarizeResult: product)
            
            return cell
        }
         
        dataSource = DataSource(collectionView: collectionView, cellProvider: cellProvider)
    }

    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection in
            
            //아이템 비율 => 1.0(전체)
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            //그룹 설정
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .absolute(120))
            let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            group.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

            //세션 설정
            let section = NSCollectionLayoutSection(group: group)
            
            return section
        }
        
        return layout
    }
}

extension RecentSummaryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dismiss(animated: true)
        if let data = dataSource.itemIdentifier(for: indexPath) {
            delegate?.didSelectRecentSummaryCell(data)
        }
    }
}

extension RecentSummaryViewController {
    enum Section: Int, CaseIterable {
        case recentSummary
    }
}
