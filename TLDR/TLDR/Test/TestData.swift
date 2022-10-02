//
//  TestData.swift
//  TLDR
//
//  Created by 유정주 on 2022/09/22.
//

import Foundation

struct TestData {
    var text: String = """
        코로나19 등 여파로 중단됐던 한중 경제장관회의가 2년 만에 다시 열렸다.
        한중 양국은 이번 회의에서 공급망 협력 강화에 처음 합의하고 탄소중립 정책 교류를 확대하는 등 경제 협력을 추진하기로 했다.
        27일 기획재정부에 따르면 추경호 부총리 겸 기재부 장관은 이날 허리펑(何立峰) 국가발전개혁위원회 주임과 제17차 한중 경제장관회의를 화상으로 개최했다.
        한중 경제장관회의가 열린 것은 지난 2020년 10월 이후 약 1년 11개월 만이다.
        이날 양국은 향후 경제협력 방향을 담은 양해각서(MOU) 3건을 체결하고 합의 의사록을 작성했다.
        우선 공급망 협력 강화를 위한 양해각서(MOU)가 한중 간 처음으로 체결됐다.
        양국은 공급망 이슈를 논의할 국장급 조정 협의체 신설에도 합의했다.
        정부는 이를 통해 공급망 불안이 발생할 경우 논의 채널을 확보하는 한편, 양측 간 정책 소통을 더욱 강화하기로 했다.
        경제 분야 실질 협력 강화를 위한 양해각서도 이번 회의를 계기로 체결됐다.
        기업이나 지방 도시, 연구소 등 민간 교류를 포함한 "한중 경제협력 교류회"를 올해 하반기부터 매년 개최하고, 중국 소재 기업의 애로사항 해소를 추진한다는 구상이다.
        이외 제3국 공동진출 협력 중점 프로젝트 양해각서를 통해 양국 기업이 공동으로 진행 중인 사업 5건에 대한 협력도 강화한다.
        양국은 이와 함께 탄소중립 목표 달성을 위한 정책 교류를 확대하기로 했다.
        종전까지 미세먼지를 중심으로 이뤄졌던 정책 협력을 친환경 저탄소 발전 분야로 확장하고, 국제사회에서 기후·환경 분야 공조를 이어나가겠다는 것이다.
        아울러 양국은 문화 산업 등 서비스산업 발전 관련 경험을 공유하고, 문화산업 심포지엄 등 교류·협력도 함께 강화하기로 했다.
        특히 우리 정부는 게임·영상·방송·콘텐츠 등 문화 분야 발전의 중요성을 강조했으며, 중국 측은 건강·노인 요양 등 생활 서비스 분야에서 한국과 협력을 제의했다.
        양측 수석대표는 한중 수교 30주년을 기념하면서 그간 이뤄진 경제 교류의 성장과 발전을 평가하고, 코로나 등으로 정체된 경제협력 관계를 기존의 양국 간 상호 존중 기조하에 활성화하는 방향에 공감했다.
        특히 약 2년 만에 이뤄진 이번 회의는 실질적 경제협력 대화의 물꼬를 트는데 큰 의미가 있다고 양측은 평가했다.
        """
    var summarize: String = "한중 양국은 이번 회의에서 공급망 협력 강화에 처음 합의하고 탄소중립 정책 교류를 확대하는 등 경제 협력을 추진하기로 했다.👍\\n이날 양국은 향후 경제협력 방향을 담은 양해각서(MOU) 3건을 체결하고 합의 의사록을 작성했다.\\n우선 공급망 협력 강화를 위한 양해각서(MOU)가 한중 간 처음으로 체결됐다.\\n양국은 이와 함께 탄소중립 목표 달성을 위한 정책 교류를 확대하기로 했다.\\n양측 수석대표는 한중 수교 30주년을 기념하면서 그간 이뤄진 경제 교류의 성장과 발전을 평가하고, 코로나 등으로 정체된 경제협력 관계를 기존의 양국 간 상호 존중 기조하에 활성화하는 방향에 공감했다.\\n추 부총리는 \\\"지난 30년 한중간 성장과 발전을 바탕으로 급변하는 국제환경 변화에 맞춰 과거 코로나 등으로 정체된 교류를 정상화하고, 현재 공동으로 직면한 글로벌 불확실성에 대응해 나가자\\\"고 제의했다"
    var textKeywords: Set<String> = ["코로나", "한중", "공급망", "협력", "강화에", "탄소중립", "교류를", "MOU"]
    var summarizeKeywords: Set<String> = ["코로나", "한중", "공급망"]
}
