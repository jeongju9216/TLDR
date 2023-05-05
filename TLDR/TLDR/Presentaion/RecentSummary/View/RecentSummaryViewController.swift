//
//  RecentSummaryViewController.swift
//  TLDR
//
//  Created by 유정주 on 2023/05/05.
//

import UIKit

final class RecentSummaryViewController: UIViewController {

    private typealias DataSource = UICollectionViewDiffableDataSource<Section, SummarizeResult>
    private typealias SnapShot = NSDiffableDataSourceSnapshot<Section, SummarizeResult>

    //MARK: - Views
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Properties
    private var dataSource: DataSource!
    private var snapshot: SnapShot = SnapShot()
    
    private let viewModel: RecentSummaryViewModel = RecentSummaryViewModel()
    private lazy var recentSummaries: [SummarizeResult] = {
        do {
            return try viewModel.action(.recentSummary).value() as! [SummarizeResult]
        } catch {
            return []
        }
    }()
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - Setup
    private func setupCollectionView() {
        collectionView.delegate = self

        collectionView.collectionViewLayout = createCollectionViewLayout()
        collectionView.keyboardDismissMode = .onDrag

//        collectionView.register(UINib(nibName: DefaultCollectionViewCell.identifier, bundle: nil),
//                                forCellWithReuseIdentifier: DefaultCollectionViewCell.identifier)
        
//        setupDataSource()
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection in
            
            //아이템 비율 => 1.0(전체)
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            //그룹 설정
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .absolute(40))
            let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            
            //세션 설정
            let section = NSCollectionLayoutSection(group: group)
            
            return section
        }
        
        return layout
    }
}

extension RecentSummaryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
}


extension RecentSummaryViewController {
    enum Section: Int, CaseIterable {
        case recentSummary
    }
}
