//
//  TermsOfUseDetailViewController.swift
//  CityAdventure
//
//  Created by Jiyong on 2018. 4. 18..
//  Copyright © 2018년 bubu. All rights reserved.
//

import UIKit

class TermsOfUseDetailViewController: UIViewController {
    
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var titleText: UILabel! {
        didSet {
            titleText.text = titleString
        }
    }
    @IBOutlet weak var descText: UITextView! {
        didSet {
            descText.layer.cornerRadius = 8.0
            descText.clipsToBounds = true
            
            let contentHeight = descText.contentSize.height
            let offSet = descText.contentOffset.y
            let contentOffset = contentHeight - offSet
            descText.contentOffset = CGPoint(x: 0,y: -contentOffset)
        }
    }
    
    
    var titleString: String?
    var index: Int?
    
    let descs = ["""
    제 1 장 총 칙
    
    제1조 [목적]
    본 이용약관(이하 “약관”)은 주식회사 비유비유(이하 “회사”)가 제공하는 도시탐험대 어플리케이션 서비스(이하 “서비스”) 이용과 관련하여 회사와 회원 간의 권리, 의무 및 책임사항, 기타 필요한 사항을 규정함을 목적으로 합니다.
    
    제2조 [용어의 정의]
    약관에서 사용하는 용어의 정의는 다음과 같습니다. 본 약관에서 사용하는 용어의 정의는 다음 각호에서 정하는 것을 제외하고는 관계법령에서 정하는 바에 의합니다. 관계법령에서 정하지 않는 것은 일반적인 상관례에 따릅니다.
    ① 서비스 : 구현되는 모바일 단말기를 통하여 이용할 수 있는 도시탐험대 어플리케이션 서비스를 의미합니다.
    ② 도시카드 : 온 오프라인 매장을 통해 판매중인 “도시탐험대” 실물 카드를 의미합니다.
    ③ 링키 : 온 오프라인 매장을 통해 판매중인 “도시탐험대” 실물 카드의 구성품으로 도시카드와 “서비스”를 연결하는 중간 장치를 의미합니다.
    ④ 회원 : 회사의 “서비스”에 접속하여 약관에 동의하고 이용계약을 체결하고 서비스를 이용하는 모든 고객을 의미합니다.
    ⑤ 인증회원 : “도시탐험대” 실물카드와 링키를 구입하고 “서비스”에 접속하여 QR코드를 통한 구입인증을 진행한 회원을 의미합니다.
    ⑥ 대원 : “서비스”에 접속하여 회원에 가입하고, 추가한 유저를 의미합니다.
    ⑦ 계정 : 회원이 회원가입 시에 등록한 이메일 주소를 의미합니다.
    ⑧ 포인트 : 서비스의 효율적 이용을 위해 회사가 임으로 책정 또는 지급, 조정할 수 있는 재산적 가치가 없는 서비스 상의 가상 데이터를 의미합니다.
    ⑨ 게시물 : 회원이 작성하여 서비스 상에 게시한 부호, 문자, 음성, 음향, 화상, 동영상 등의 정보형태의 글, 사진, 동영상 및 각종 파일과 링크 등 모든 게시글을 통틀어 게시물이라 합니다.
    ⑩ 온라인 구매 : 본 서비스의 구매 메뉴를 통해 구입할 수 있는 온라인 쇼핑몰의 구매 서비스를 의미 합니다.
    
    제3조 [약관의 게시와 개정]
    ① 회사는 약관을 이용자가 알 수 있도록 서비스의 상설 메뉴에 게시합니다.
    ② 회사는 관련 법령의 변경이나 이용자의 권리 및 의무사항을 개선하기 위해 관련법령을 위배하지 않는 범위에서 약관을 개정할 수 있습니다. 개정된 약관은 적용일자 및 변경내용, 변경사유 등을 명시하여 그 적용일 7일 이전부터 공지합니다. 다만, 회원에게 불리하게 약관을 개정하는 경우에는 그 적용일 30일 이전을 두고 공지하며, 전자우편 발송을 통해 별도 통지 합니다.
    ③ 회원은 개정된 약관에 동의하지 않을 권리가 있으며, 그 경우 서비스 이용을 중지하고 탈퇴할 수 있습니다. 다반, 2항의 방법으로 변경되는 약관 공지시 약관의 적용일 전일까지도 회사에 명시적으로 의사표시를 하지 아니하는 경우 이용자가 변경되는 약관에 동의하는 것으로 봅니다.
    ④ 회사는 본 서비스 이외의 추가 서비스를 출시할 경우 별도의 약관이 필요하다고 판단되는 경우 별도의 약관을 둘 수 있습니다.
    ⑤ 본 약관에서 정하지 아니한 사항이나 해석에 대해서는 관계법령 또는 상관례에 따릅니다.
    
    제2장 이용계약
    
    제4조 [이용계약의 체결]
    ① 이용계약은 “회원”이 되고자하는 자(이하 “가입신청자”)가 약관의 내용에 대해 동의를 한 다음 회원가입 신청을 하고 “회사”가 이러한 신청에 대하여 승낙함으로써 체결됩니다.
    ② “회사”는 “가입신청자”의 신청에 대하여 “서비스”이용을 승낙함을 원칙으로 합니다. 다만  회사는 다음 각 호에 해당하는 신청에 대하여는 승낙을 하지 않거나 사후에 이용계약을 해지할 수 있습니다.
    1) 다른 사람의 명의를 도용하여 신청한 경우
    2) 회원가입 신청 시 정보를 허위로 기재하여 신청한 경우
    3) 사회의 안녕, 질서 또는 미풍양속을 저해할 목적으로 신청한 경우
    4) 14세 미만 아동이 법정대리인(부모)의 동의를 얻지 아니한 경우
    5) 이전에 회원 자격을 상실한 적이 있는 경우
    6) 이용자의 귀책사유로 인하여 승인이 불가능하거나 기타 규정한 제반사항을 위반하여 신청한 경우
    7) 기타, 회사가 정한 이용신청 요건이 미비된 경우
    ③ “회사”는 서비스 관련 설비의 여유가 없거나, 기술상 또는 업무상 문제가 있는 경우에는 승낙을 유보할 수 있습니다.
    ④ “회사”는 “회원”에 대해 회사정책에 따라 등급별로 구분하여 이용시간, 횟수, 서비스 메뉴 등을 세분하여 이용에 차등을 둘 수 있습니다.
    
    제5조 [회원정보의 변경과 관리]
    ① “회원”은 계정관리 화면을 통해 언제든지 본인의 계정정보를 열람하고 비밀번호를 수정할 수 있습니다.
    ② “회원”의 계정과 비밀번호의 관리책임은 “회원”에게 있으며 이를 제3자가 이용하도록 하여서는 안 됩니다.
    ③ “회사”는 “회원”의 계정이 개인정보 유출 우려가 있거나 반사회적 미풍약속에 어긋나거나, “회사” 및 “회사”의 운영자로 오인한 우려가 있는 경우 해당 계정의 이용을 제한할 수 있습니다.
    ④ “회원”은 계정 및 비밀번호가 도용되거나 제3자가 사용하고 있음을 인지한 경우에는 이를 즉시 “회사”에 통지하고 “회사”의 안내에 따라야 합니다.
    ⑤ “회원”은 자신의 계정을 선량한 관리자로서 주의 의무를 다하여야 합니다. 회사는 이용자가 자신의 계정을 소홀히 하거나 제3자에게 이용을 승낙함으로써 발생하는 손해에 대해 어떠한 책임도 부담하지 않습니다.
    
    제6조 [개인정보 보호 의무]
    ① “회사”는 관련 법령이 정하는 바에 따라 회원 계정을 포함한 “회원”의 개인정보를 보호하기 위해 노력합니다. 개인정보의 보호 및 사용에 대해서는 관련법 및 “회사”의 개인정보취급방침이 적용됩니다.
    ② “회사”의 웹사이트 또는 서비스에서 단순히 링크된 제3자 제공의 서비스에 대하여는 회사는 개인정보취급방침이 적용되지 않습니다.
    ③ “회사”는 “회원”의 귀책사유로 인하여 노출된 회원계정을 포함한 “회원”의 개인정보에 대해서는 책임을 지지 않습니다.
    
    제3장 의무
    
    제7조 [“회사”의 의무]
    ① “회사”는 관련법과 본 약관이 금지하거나 미풍양속에 반하는 행위를 하지 않으며, 계속적이고 안정적으로 “서비스”를 제공하기 위하여 최선을 다하여 노력합니다.
    ② “회사”는 구매하기 메뉴를 통해 판매되는 상품을 지속적이고 안정적으로 제공하기 위하여 최선을 다하여 노력합니다.
    ③ “회사”는 판매하는 상품에 대하여 「정보통신망 이용촉진 및 정보보호 등에 관한 법률」 제3조의 규정에 위반하는 표시. 광고행위를 함으로써 “회사”가 손해를 입은 때에는 이를 배상할 책임을 부담합니다.
    ③ “회사”는 “회원”이 안전하게 “서비스”를 이용할 수 있도록 개인정보(신용정보 포함)보호를 위해 보안시스템을 갖추어야 하며 개인정보처리방침을 공시하고 준수합니다.
    ④ “회사”는 서비스 이용과 관련하여 “회원”으로부터 제기된 의견이나 불만이 정당하다고 인정할 경우에는 이를 처리하여야 합니다. “회원”이 제기한 의견이나 불만사항에 대해서는 전자우편을 통하여 “회원”에게 처리과정 및 결과를 전달합니다.
    
    제8조 [“회원”의 의무]
    ① “회원”은 다음의 행위를 하여서는 안 됩니다.
    1) 신청 또는 변경 시 허위 내용의 등록
    2) 타인의 정보도용
    3) “회사”가 게시한 정보의 변경
    4) “회사”가 정한 정보 이외의 정보 등의 송신 또는 게시
    5) “회사”와 기타 제3자의 저작권 등 지적재산권에 대한 침해
    6) “회사”와 기타 제3자의 명예를 손상시키거나 업무를 방해하는 행위
    7) 외설 또는 폭력적인 게시글, 사진, 기타 미풍양속에 반하는 정보를 “서비스”에 공개 또는 게시하는 행위
    8) “회사”의 동의 없이 영리를 목적으로 “서비스”를 사용하는 행위
    9) 기타 불법적이거나 부당한 행위
    ② “회원”은 “회사” 혹은 게시자 본인의 사전 승낙 없이는 “서비스”를 이용하여 얻은 정보를 복사, 복제, 변경, 번역, 출판, 방송, 광고, 영업, 전송, 기타의 방법으로 사용하거나 이를 타인에게 제공하는 행위를 할 수 없습니다.
    
    제4장 서비스의 이용
    
    제9조 [서비스의 이용]
    ① “회사”는 “회원”의 이용신청을 승낙한 때부터 즉시 서비스를 개시합니다. 단, “회사”의 업무상 또는 기술상의 장애로 인하여 서비스를 게시하지 못하는 경우, 서비스 상에 공지하거나 회원에게 즉시 이를 통지합니다.
    ② 서비스의 이용은 “회사”의 업무상 또는 기술상 특별한 지장이 없는 한 연중무휴 1일 24시간을 원칙으로 합니다. 시스템 정기점검, 증설 및 교체 등 운영상의 목적으로 “회사”가 정한 기간에는 서비스의 전부 또는 일부가 일시 중지될 수 있습니다. 이러한 경우 “회사”는 이와 같은 내용을 사전 공지 합니다.
    ③ “회사”는 긴급한 시스템 점검, 증설 및 교체, 국가 비상상태, 정전, 서비스 설비의 장애, 또는 서비스 이용의 폭주 등으로 정산적인 서비스가 불가능할 경우 사전 공지나 예고 없이 서비스를 일시 중단할 수 있습니다.
    ④ “회사”는 서비스의 이용가능 시간을 별도로 정할 수 있으나 이 경우 그 내용을 사전에 공지합니다. 단, 회사가 통제할 수 없는 사유로 발생한 서비스 중단에 대하여 사전 공지가 불가능한 경우에는 예외로 합니다.
    ⑤ “회사”는 “서비스”를 모바일 단말기를 통해 무료로 제공합니다. 단, 별도의 유로서비스의 경우 해당 서비스에 명시된 요금을 지불하여야 합니다.
    ⑥ “회원”은 모바일 단말기 제작사 및 통신사에서 제공하는 애플리케이션 마켓 혹은 “서비스”내 다운로드 페이지를 통해 애플리케이션을 설치하여 서비스를 이용할 수 있습니다. 단, 단말의 종류 및 통신사에 따라 애플리케이션의 구성과 기능에는 차이가 있을 수 있습니다.
    ⑦ “회원” 이 “서비스”의 일부 또는 이용규칙을 적용하는데 사용되는 보안기술이나 소프트웨어를 회피 또는 변경하려 시도를 하거나 부정사용 및 타인이 그렇게 하는 것을 조장하는 행위 등은 금지되어 있으며, 만약 “회원”이 위와 같은 행위를 하는 경우 이에 대한 모든 책임은 “회원” 본인에게 있습니다.
    
    제10조 [서비스의 내용]
    ① 회원가입 이후 서비스를 이용할 수 있으며 이메일당 1개의 계정만 인정합니다.
    ② “회원”은 실물 도시카드의 구매인증 여부에 따라 “구입인증 회원”과 “구입 미인증 회원”으로 구분됩니다. 구입 미인증 회원은 구입인증 회원에 비해 서비스의 범위가 한정됩니다. 구입인증은 애플리케이션을 설치하고, 서비스내의 메뉴에서 이루어지며, 실물 도시카드 패키지 내에 포함된 암호화된 QR코드를 통해 확정 됩니다.
    ③ “회원”은 서비스를 통해 도시의 정보들을 탐색하고, 간단한 게임을 즐기며, 도시에 관련된 사진, 영상, 글을 게시할 수 있습니다.
    ④ “회사”는 위치정보서비스를 활용하여 푸쉬알람을 보내고, “회원” 탐험인증 서비스를 이용할 수 있습니다.
    ⑤ “회원”이 공개한 게시글은 서비스를 통해 전체 회원과 공유될 수 있으며, 공개여부는 “회원”이 설정할 수 있습니다.
    
    제11조 [서비스의 변경]
    ① “회사”는 상당한 이유가 있는 경우에 운영상, 기술상의 필요에 따라 제공하고 있는 전부 또는 일부 “서비스”를 변경할 수 있습니다.
    ② 서비스의 내용, 이용방법, 이용시간에 대하여 변경이 있는 경우 변경사유, 변경될 서비스의 내용 및 제공일자 등은 그 변경 전에 공지하여야 합니다.
    ③ “회사”는 무료로 제공되는 서비스의 일부 또는 전부를 회사의 정책 및 운영의 필요상 수정, 중단, 변경할 수 있으며, 이에 대하여 관련법에 특별한 규정이 없는 한 “회원”에게 별도의 보상을 하지 않습니다.
    
    제12조 [정보의 제공 및 광고의 게재]
    ① “회사”는 “회원”이 서비스 이용 중 필요하다고 인정되는 다양한 정보를 공지사항이나 전자우편 등의 방법으로 “회원”에게 제공할 수 있습니다.
    ② “회사”는 서비스의 운영과 관련하여 서비스 화면, 홈페이지, 전자우편 등에 광고를 게재할 수 있으며 “회원”이 원하지 않는 경우에는 언제든지 수신을 거부할 수 있습니다.
    ③ “회사”는 단말기 알림(Push알림)등을 활용하여 이용자에게 광고를 발송할 수 있으며, “회원”이 원하지 않는 경우에는 언제든지 수신을 거부할 수 있습니다.
    ④ 이용자(회원, 비회원 포함)는 회사가 제공하는 서비스와 관련하여 게시물 또는 기타 정보를 변경, 수정, 제한하는 등의 조치를 취하지 않습니다.
    
    제13조 [게시물의 저작권]
    ① “회사”가 작성한 게시물 또는 저작물에 대한 저작권 기타 지적 재산권은 “회사”에 귀속합니다.
    ② “회원”이 서비스 내에 게시한 게시물의 저작권은 “회원”에게 귀속됩니다.
    ③ “회사”는 서비스 활성화를 목적으로 “회원”이 전체 공개한 게시물에 한하여 서비스 내에 게시하고 이를 포털 사이트나 타 서비스에 게시 및 기타 활용할 수 있는 권리를 가집니다.
    ④ “회원”이 서비스에 게시물을 게재하는 것은 다른 회원이 게시물을 서비스 내에서 사용하거나 “회사”가 서비스 활성화를 위한 목적으로 포털 사업자에게 콘텐츠 검색결과로 제공하는 것을 허락한 것으로 봅니다. 다만, 회원은 서비스내의 관리 기능을 통하여 게시물의 비공개 등의 조치를 취할 수 있습니다.
    ⑤ “회사”는 본 서비스를 홍보하기 위한 목적으로 미디어, 통신사 등에게 이용자의 게시물 내용을 보도, 방영하게 할 수 있으며, 해당 노출을 위해 필요한 범위 내에서는 일부 수정, 복제, 편집되어 게시될 수 있습니다. 이 경우 회사는 “저작권법”규정을 준수합니다.
    ⑥ “회사”는 “회원”이 서비스 내에 게시한 게시물의 타인의 저작권, 기타 권리를 침해하더라도 이에 대한 민.형사상의 책임을 부담하지 않습니다.
    ⑦ “회사”는 “회원”이 이용계약을 해지하거나 본 약관에 의한 적법한 사유로 이용계약이 해지된 경우 해당 회원이 게시하였던 게시물을 삭제할 수 있습니다.
    
    제14조 [게시물의 관리]
    ① “회원”의 게시물이 관련 법령에 위반되는 내용을 포함하고 있는 경우, 권리자는 관련법이 정한 절차에 따라 해당 “게시물”의 게시중단 및 삭제 등을 요청할 수 있습니다. “회사”는 관련법에 따라 조치를 취하여야 합니다.
    ② “회원”은 서비스를 이용하여 선량한 풍석, 기타 사회질서를 해하거나, 타인의 권리를 침해하는 행위를 하여서는 아니 되고, 바이러스, 애드웨어, 스파이웨어 등을 포함하고 있는 내용 또는 제3자의 저작권 등 지적재산권을 침해하는 내용의 게시물을 게시하거나 전송 또는 배포할 수 없으며 이에 대한 모든 책임은 “회원” 본인에게 있습니다.
    ③ “회사”는 “회원”이 서비스에 게시하거나 전달하는 서비스 내의 게시물이 다음 각호의 경우에 해당한다고 판단되는 경우 사전 통지 없이 삭제할 수 있으며, 이에 대해 회사는 어떠한 책임도 지지 않습니다.
    1) “회사”, 다른 회원 또는 제3자를 비방하거나 중상모략으로 명예를 손상시키는 내용인 경우
    2) 공공질서 및 미풍양속에 위반되는 내용의 게시물에 해당하는 경우
    3) 게시물의 내용이 범죄적 행위에 결부된다고 인정되는 내용인 경우
    4) “회사”의 저작권, 제3자의 저작권 등 기타 타인의 권리를 침해하는 내용인 경우
    5) “회사”에서 제공하는 서비스와 관련 없는 내용인 겨우
    6) 불필요하거나 승인되지 않은 광고, 판촉물을 게재하는 경우
    7) 타인의 계정, 명의 등을 무단으로 도용하여 작성한 내용이거나, 타인이 입력한 정보를 무단으로 위변조한 내용인 경우
    8) 동일한 내용을 중복하여 다수 게시하는 등 게시의 목적에 어긋나는 경우
    9) 기타 관계법령 및 회사의 지침 등에 위반된다고 판단되는 경우
    
    제15조 [권리의 귀속]
    ① 서비스에 대한 저작권 및 지적재산권은 “회사”에 귀속됩니다. 단 “회원”의 게시물 및 제휴 계약에 따라 제공된 저작물 등은 제외합니다.
    ② 이용자는 서비스를 이용함으로써 얻은 정보 중 “회사”에게 지적재산권이 귀속된 정보를 “회사”의 사전승낙 없이 복제, 변형, 송신, 출판, 배포, 방송, 프랜차이즈 등 기타 방법에 의하여 영리목적으로 이용하거나 제3자에게 이용하게 하여서는 안 됩니다.
    
    제16조 [포인트]
    ① “회사”는 서비스 내에 가상화폐인 포인트를 발부하며, 그 명칭은 변경될 수 있습니다.
    ② 포인트의 발부는 서비스의 정책에 따르며, “회사”는 서비스의 효율적인 운영을 위해 사전 공지 후 “포인트”의 일부 또는 전부를 조정할 수 있으며, “포인트”는 회사가 정한 기간에 따라 주기적으로 소멸할 수 있습니다.
    
    제5장 온라인 구매 서비스 이용
    
    제17조 [온라인 구매 서비스의 신청]
    ① “회원”은 서비스 내 “구매” 메뉴를 통해 실물카드 패키지와 연계상품을 구입할 수 있습니다.
    ② “회원”의 온라인상에서의 구매는 부득이한 경우를 제외하고 만 20세 이상의 성인 “회원”만 가능합니다.
    ③ “회원”은 온라인상의 구매서비스 이용 시 다음의 방법에 의하여 구매를 신청합니다.
    1) 회원 계정, 배송 받을 분의 성명, 배송지 주소, 배송지 전화번호 입력
    2) 재화의 선택
    3) 약관내용, 청약철회권, 배송료 등의 비용부담과 관련된 내용에 대한 확인
    3) 결재방법의 선택
    ④ “회사”는 제3자에게 구매자 개인정보를 제공, 위탁할 필요가 있는 경우 실제 구매신청 시 구매자의 동의를 받아야 하며, 회원가입 시 미리 포괄적으로 동의를 받지 않습니다. 이때 “회사”는 제공되는 개인정보 항목, 제공받는 자, 제공받는 자의 개인정보이용목적 및 보유, 이용기간 등을 구매자에게 명시하여야 합니다. 다만 「정보통신망이용촉진 및 정보보호 등에 관한 법률」 제 25조 1항에 의한 개인정보 처리위탁의 경우 등 관련법령에 달리 정함이 있는 경우에는 그에 따릅니다.
    
    제18조 [구매계약의 성립]
    ① “회사”는 제 17조와 같은 구매신청에 관하여 다음 각호에 해당하지 않는 한 승낙합니다.
    1) 신청 내용에 허위, 기재누락, 오기가 있는 경우
    2) 상행위(재판매)를 목적으로 구매하는 거래이거나, 거래 정황상 상행위(재판매)를 목적으로 한 구매로 판단되는 경우
    3) 기타 구매 신청을 승낙하는 것이 “회사” 기술상 현저히 지장이 있다고 판단하는 경우
    ② “회사”의 승낙이 제20조 1항의 수신확인 통지형태로 이용자에게 도달한 시점에 구매 계약이 성립한 것으로 봅니다.
    ③ “회사”의 승낙의 의사표시에는 이용자의 구매신청에 대한 확인 및 판매가능 여부, 구매 신청의 정정 취소 등에 관한 정보 등을 포함하여야 합니다.
    
    제19조 [대금 결제 방법]
    “회사”에서 구매한 상품의 대금 지급방법은 다음 각호의 방법 중 가용한 방법으로 할 수 있습니다. 단, “회사”는 이용자의 지급방법에 대하여 재화 등의 대금에 어떠한 명목의 수수료도 추가하여 징수할 수 없습니다.
    ① 폰뱅킹, 인터넷뱅킹, 메일 뱅킹 등의 각종 계좌이체
    ② 선불카드, 직불카드, 신용카드 등의 각종 카드 결제
    ③ 포인트 등 “회가”가 지급한 포인트에 의한 결제
    ④ “회사”와 계약을 맺었거나 “회사”가 인정한 상품권에 의한 결제
    ⑤ 기타 전자적 지급 방법에 의한 대금지급 등
    
    제20조 [수신확인통지, 구매신청 변경 및 취소]
    ① “회사”는 “회원”의 구매신청이 있는 경우 “회원”에게 수신확인 통지를 합니다.
    ② 수신확인 통지를 받은 “회원”은 의사표시의 불일치 등이 있는 경우에는 수신확인 통지를 받은 후 즉시 구매신청변경 및 취소를 요청할 수 있고, “회사”는 배송 전에 이용자의 요청이 있는 경우에는 지체 없이 그 요청에 따라 처리하여야 합니다. 다만 이미 대금을 지불한 경우에는 제22조의 청약철회 등에 관한 규정에 따릅니다.
    
    제21조 [재화 등의 공급]
    ① “회사”는 “회원”과 재화의 공급시기에 관하여 별도의 약정이 없는 이상 “회원”이 청약을 한 날로부터 7일 이내에 재화 등을 배송할 수 있도록 주문제작, 포장 등 기타의 필요한 조치를 취합니다. 다만, “회사”가 이미 재화 등의 대금의 전부 또는 일부를 받은 경우에 대금의 전부 또는 일부를 지급받은 날부터 3영업일 이내에 조치를 취합니다. 이때 “회사”는 이용자가 재화 등의 공급 절차 및 진행 사항을 확인할 수 있도록 적절한 조치를 취합니다.
    ② “회사”는 이용자가 구매한 상품에 대해 배송수단, 수단별 배송비용 부담자, 수단별 배송기간 등을 명시합니다. 만약 “회사”가 약정배송기간을 초과한 경우에는 그로 인한 이용자의 손해를 배상하여야 합니다. 다만 “회사”가 고의, 과실이 없음을 입증한 경우에는 그러하지 아니합니다.
    
    제22조 [환급]
    “회사”는 이용자가 구매 신청한 재화 등이 품절 등의 사유로 인도 또는 제공을 할 수 없을 때에는 지체 없이 그 사유를 이용자에게 통지하고 사전에 재화 등의 대금을 받은 경우에는 대금을 받은 날부터 3영업일 이내에 환급하거나 환급에 필요한 조치를 취합니다.
    
    제23조 [청약철회]
    ① “회사”와 재화 등의 구매에 관한 계약을 체결한 “회원”은 계약내용에 관한 서면을 받은 7일 이내에 청약철회를 할 수 있습니다. 다만, 청약철회에 관하여 「전자상거래 등에서의 소비자보호에 관한 법률」에 달리 정함이 있는 경우에는 동 법 규정에 따릅니다.
    ② “회원”은  재화 등을 배송 받은 경우 다음 각호의 어느 하나에 해당하는 경우에는 반품 및 교환을 할 수 없습니다.
    1) “회원”에게 책임 있는 사유로 재화 등이 멸실 또는 훼손된 경우. 다만, 재화 등의 내용 확인을 위하여 포장을 훼손한 경우에는 제외합니다.
    2) “회원”의 사용 또는 일부 소비에 의하여 재화 등의 가치가 현저히 감소한 경우
    3) 시간경과에 의하여 재판매가 곤란할 정도로 재화 등의 가치가 현저히 감소한 경우
    4) 같은 성능을 지닌 재화 등으로 복제가 가능한 경우 그 원본인 재화 등의 포장을 훼손한 경우
    ③ 제2항 2호 내지 제4호의 경우에 “회사”가 사전에 청약철회 등이 제한되는 사실을 이용자가 쉽게 알 수 있는 곳에 명기하거나 사용상품을 제공하는 등의 조치를 하지 않았다면 이용자의 청약철회 등이 제한되지 않습니다.
    ④ “회원”은 제1항 및 제2항의 규정에 불구하고 재화 등의 내용이 표시, 광고 내용과 다르거나 계약내용과 다르게 이행된 경우에는 당해 재화 등을 공급받은 날부터 3월 이내, 그 사실을 안날 또는 알 수 있었던 날부터 30일 이내에 청약철회 등을 할 수 있습니다.
    
    제24조 [청약철회 등의 효과]
    ① “회사”는 이용자로부터 재화 등을 반환받은 경우 3영업일 이내에 이미 지급받은 재화 등의 대금을 환급합니다. 이 경우 “회사”가 이용자에게 재화 등의 환급을 지연한 때에는 그 지연기간에 대하여 「전자상거래 등에서의 소비자보호에 관한 법류 시행령」제21조의 2항에서 정하는 지연이자율을 곱하여 산정한 지연이자를 지급합니다.
    ② “회사”는 위 대금을 환급함에 있어서 “회원”이 신용카드 또는 전자화폐 등의 결제수단으로 재화 등의 대금을 지급한 때에는 지체 없이 당해 결제수단을 제공한 사업자로 하여금 재화 등의 대금의 청구를 정지 또는 취소하도록 요청합니다.
    ③ 청약철회 등의 경우 공급받은 재화 등의 반환에 필요한 비용은 “회원”이 부담합니다. “회사”는 “회원”에게 청약철회를 이유로 위약금 또는 손해배상을 청구하지 않습니다. 다만, 재회 등의 내용이 표시. 광고 내용과 다르거나 예약내용과 다르게 이행되어 청약철회 등을 하는 경우 재화 등의 반환에 필요한 비용은 “회사”가 부담합니다.
    ④ “회원”이 재화 등을 공급받을 때 발송비를 부담한 경우에 “회사”는 청약철회 시 그 비용을 누가 부담하는 지를 “회원”이 알기 쉽도록 명확하게 표시합니다.
    
    제6장 계약해지 및 이용제한
    
    제25조 [계약해제, 해지 등]
    ① “회원”은 본인이 원하는 경우 서비스 설정메뉴의 고객센터를 통하여 이용계약 해지 신청을 할 수 있습니다.
    ② “회사”는 이용계약이 해지된 “회원”이 다시 이용신청을 하는 경우 30일 동안 승낙을 제한하거나 이용신청을 거절할 수 있습니다.
    ③ “회원”이 계약을 해지할 경우, 관련법 및 개인정보처리방침에 따라 “회사”가 회원정보를 보유하는 경우를 제외하고는 해지 즉시 “회원”의 모든 데이터는 소멸됩니다.
    ④ “회원”이 계약을 해지하는 경우 “회원”이 작성한 게시물 일체는 삭제되면, 서비스 이용을 통해 획득한 포인트 및 기타혜택등도 모두 소멸됩니다.
    
    제26조 [이용 제한 등]
    “회사”는 “회원이 본 약관의 의무를 위반하거나 서비스의 정상적인 운영을 방해한 경우, 방송통신심의위원회 등 관계기간의 요청이 있는 경우, 다음 각 항의 행위에 해당하는 경우, 사전통지 없이 ”회원“과의 이용계약을 해지하거나 또는 기간을 정하여 이용을 중지할 수 있으며, 해당 게시물을 사전 통지 없이 삭제할 수 있습니다.
    ① “회사”에서 제공하는 서비스의 저장공간에 음란물을 게재하거나 음란사이트를 링크하거나, 이를 배포하는 등 사회질서를 해치는 행위
    ② 공공질서 또는 미풍양속에 위배되는 내용의 정보, 문장, 도형, 음성 등을 유포하는 행위
    ③ 타인의 명예를 훼손 또는 모욕하는 행위
    ④ “회사”또는 제3자의 저작권, 지적재산권등 기타 권리를 침해하는 행위
    ⑤ 관계법령에 의하여 그 제조, 수입, 전송 또는 게시가 금지되는 기술, 제품, 정보의 제주, 수입, 전송 또는 게시 행위
    ⑥ 범죄와 결부된다고 판단되는 행위
    ⑦ 해킹 또는 컴퓨터 바이러스를 유포하거나 타인의 의사에 반하여 광고성 정보 등 일정한 내용을 지속적으로 전송하는 해위
    ⑧ 다른 회원 이메일을 부정 사용하는 행위
    ⑨ 다른 사용자의 개인정보를 수집, 도용, 저장하거나 이를 유포하는 행위
    ⑩ 타인을 사칭하는 행위
    ⑪ 서비스에 개재된 자료 및 저작물의 발신인을 위조하는 행위
    ⑫ 타인을 스톡(stalk)하거나 괴롭히는 행위
    ⑬ 정당한 사유 없이 회원 가입, 탈퇴를 수차례 반복하여 금전적 이득을 취하거나 “회사”의 서비스 운영에 지장을 초래하는 행위
    ⑭ 본인의 이메일을 타인에게 양도하거나 매매하는 행위
    ⑮ 서비스의 운영에 지장을 주거나 줄 우려가 있는 일체의 행위, 기타 관계 법령에 위배되는 행위
    
    제27조 [손해배상]
    ① “회사”는 “회원”이 서비스를 이용함에 있어 “회사”의 고의 또는 중대한 과실이 인정될 경우에는 손해배상을 부담할 수 있습니다.
    ② “회원”이 본 약관의 의무를 위반함으로 인하여 “회사”에 손해를 입힌 경우 또는 “회원”이 서비스를 이용함에 있어 “회사”에 손해를 입힌 경우에 “회원”은 “회사”에 대하여 그 손해를 배상하여야 합니다. 이 경우 “회원”은 고의, 과실이 없음을 입증하지 못하는 경우 책임을 면할 수 없습니다.
    ③ “회사”가 「위치정보의 보호 및 이용 등에 관한 법률」 제15조 내지 제26조의 규정을 위반한 행위로 “회원”에게 손해가 발생한 경우 “회원”은 “회사”에 손해배상을 청구할 수 있습니다. 이 경우 “회사”는 고의, 과실이 없음을 입증하지 못하는 경우 책임을 면할 수 없습니다.
    
    제28조 [면책조항]
    ① “회사”는 천재지변 또는 이에 준하는 불가항력으로 인하여 서비스를 제공할 수 없는 경우에는 서비스제공에 관한 책임이 면제됩니다.
    ② “회사”는 서비스용 설비의 보수, 교체, 정기점검, 공사 등 부득이한 사유로 발생한 손해에 대한 책임이 면제됩니다.
    ③ “회사”는 “회원”의 귀책사유 및 단말기 오류로 인한 서비스의 이용장애에 대하여는 책임을 지지 않습니다.
    ④ “회사”는 “회원”이 서비스와 관련하여 게재한 정보, 자료, 사실의 신뢰도, 정확성 등의 내용에 관하여는 책임을 지지 않습니다.
    ⑤ “회사”는 “회원”간 또는 “회원”과 제3자 상호간에 서비스를 매개로 하여 거래 등을 한 경우에는 책임이 면제됩니다.
    ⑥ “회사”는 무료로 제공되는 서비스 이용과 관련하여 관련법에 특별한 규정이 없는 한 책임을 지지 않습니다.
    
    제29조 [준거법 및 재판관할]
    ① “회사”와 “회원”간의 제기된 소송은 대한민국법을 준거법으로 합니다.
    ② “회사”와 “회원”간에 발생한 분쟁에 관한 소송은 제소 당시의 “회원”의 주소에 의하고 주소가 없는 경우 거소를 관할하는 지방법원의 전속 관할로 합니다. 간, 제소당시 “회원” 의 주소 또는 거소가 명확하지 아니한 경우의 관할법원은 민사소송법에 따라 정합니다.
    ③ 해외에 주소나 거소가 있는 “회원”의 경우 “회사”와 “회원”간의 분쟁에 관한 소송은 전항에도 불구하고 대한민국 서울지방법원을 관할 법원으로 합니다.
    ④ “회사”와 “회원”은 당사자간 협의가 이루어지지 아니하는 경우 방송통신위원회나 개인정보분쟁조정위원회, 콘텐츠 분쟁조정위원회 등에 조정을 신청할 수 있습니다.
    
    부칙
    1. 본 약관은 2017년 2월 1일부터 시행됩니다.
""", """
개인정보 취급방침

 제1조(의의)
㈜비유비유(이하  '회사')는 통신비밀보호법, 전기통신사업법, 정보통신망 이용촉진 및 정보보호 등에 관한 법률 등 정보통신서비스제공자가  준수하여야 할 관련 법령상의 개인정보보호 규정을 준수하며, 관련 법령에 의거한 개인정보취급방침을 정하여 이용자 권익 보호에 최선을 다하고  있습니다.
단, ‘회사’의  공식사이트 이외의 웹에서 링크된 사이트에서는 ‘회사’의 개인정보취급방침 정책이 적용되지 않습니다. 또한 ‘회사’는 ‘회원’의 귀책사유로  인해 노출된 정보에 대해서는 일체의 책임을 지지 않습니다.


제2조.  수집하는 개인정보 항목 및 수집방법
회사는 회원가입  및 원할한 고객상담, 물품 배송 등 각종서비스의 제공을 위해 도시탐험대 서비스의 아이디로 회원가입 당시 아래와 같은 개인정보를 수집하고  있습니다.
① '본  서비스'에서 회원의 개인정보는 서비스 가입시에 정보 수집 틀을 통한 수집을 통해 수집됩니다.
② 개인정보  수집 항목은 다음과 같습니다.
 - 도시탐험대 사용자 이름, 비밀번호, 생년월일, 성별, 이메일주소, 지역
③서비스  이용과정이나 기타 처리 과정에서 아래와 같은 정보들이 자동으로 생성되어 수집될 수 있습니다.
푸쉬발송을 위한  단말에서 제공하는 휴대폰 device번호, 서비스 이용기록, 접속 로그, 쿠키, 접속 IP 정보, 불량 이용 기록
④ 이벤트  응모과정에서 해당서비스의 이용자 선택에 의해 아래와 같은 정보들이 수집될 수 있습니다.
 - 프로필 정보 : 도시탐험대 사용자 이름, 생년월일, 성별, 이메일 주소 외에   기타 이벤트에 필요한 추가정보
 - 이벤트 당첨시 : 경품 제공 및 배송을 위해 필요한 정보

제3조.  개인정보의 수집 및 이용목적
회사는 수집한  개인정보를 다음의 목적을 위해 활용합니다. 이용자가 제공한 모든 정보는 아래목적에 필요한 용도 이외로는 사용되지 않으며 이용목적이 변경될  시에는 사전 동의를 구할 것입니다.
① 서비스  제공에 관한 계약
웹사이트 및  어플리케이션 서비스 이용을 위한 컨텐츠 제공, 본인인증
② 회원관리
회원제 서비스  이용에 따른 본인확인, 개인식별, 불량회원(도시탐험대 위치기반서비스 이용약관 제20조에 의해 도시탐험대 서비스이용이 금지된 회원)의 부정  이용 방지와 비인가 사용방지, 가입의사 확인, 가입 및 가입횟수 제한, 만14세 미만 아동 개인정보 수집 시 법정 대리인 동의여부 확인,  추후 법정 대리인 본인확인, 분쟁 조정을 위한 기록보존, 불만처리 등 민원처리, 고지사항 전달
③ 맞춤 서비스  개발 및 마케팅, 광고에의 활용
신규 서비스  개발과 이벤트 행사에 따른 정보 전달 및 맞춤 서비스 제공, 통계학적 특성에 따른 서비스 제공 및 광고 게재, 서비스의 유호성 확인,  이벤트 및 광고성 정보 제공 및 참여기회 제공 접속빈도 파악, 회원의 서비스이용에 대한 통계

제4조.  개인정보의 보유 및 이용기간
회사는  회원가입일로부터 서비스를 제공하는 기간에 한하여 이용자의 개인정보를 보유 및 이용하게 됩니다. 회원 탈퇴를 요청하거나 개인정보의 수집 및  이용에 대한 동의를 철회하는 경우, 수집 및 이용목적이 달성되거나 보유 및 이용기간이 종료한 경우 해당 개인정보를 지체없이 파기합니다.  단, 다음의 정보에 대해서는 아래의 이유로 명시한 기간동아 보존합니다.
- 부정이용기록
보존사유 :  부정이용방지
보존기간 :  1년
- 계약 또는  청약철회 등에 관한 기록
보존사유 :  전자상거래 등에서의 소비자보호에 관한 법률
보존기간 :  5년
- 대금결제 및  재화 등의 공급에 관한 기록
보존사유 :  전자상거래 등에서의 소비자보호에 관한 법률
보존기간 :  5년
- 소비자의  불만 또는 분쟁처리에 관한 기록
보존사유 :  전자상거래 등에서의 소비자보호에 관한 법률
보존기간 :  3년
- 본인확인에  관한 기록
보존사유 :  정보통신망 이용촉진 및 정보보호등에 관한 법률
보존기간 :  6개월
 -서비스 이용관련 개인정보(서비스 이용기록,접속로그, 접속IP정보)
보존이유:통신비밀보호법
보전  기간:6개월
- 어플리케이션  및 웹페이지 방문에 관한 기록
보존기간 :  3개월

제5조.수집한  개인정보의 위탁
'회사'는  다음의 각 호와 같은 경우에는 '회원'의 동의 하에 개인정보를 제3자에게 제공할 수 있습니다. 이러한 경우에도 개인정보의 제3자 제공은  '회원'의 동의 하에서만 이루어지며, '회원'은 특정 서비스를 이용하지 않거나 특정한 형태의 판촉이나 이벤트에 참여하지 않음으로 개인정보  제공에 동의하지 않을 수 있습니다.
① 물품구매,  유료 콘텐츠 이용 등의 배송 및 정산을 위해 '회원'의 이름, 주소, 전화번호 등이 해당 쇼핑몰 업체, 유료 콘텐츠 제공자, 배송업자에게  제공될 수 있습니다.
② 각종 이벤트  행사에 참여한 '회원'의 개인정보가 해당 이벤트의 주최자에게 제공될수 있습니다.
③ 회사'가  외부업체(이하 수탁업체)에 특정서비스의 제공을 위탁하는 경우 서비스 제공에 필요한 '회원'의 개인정보를 '회원'의 동의를 받아 수탁 업체에  제공할 수 있으며 서비스 위탁 사실을 명시합니다. 수탁업체는 제공받은 '회원'의 개인정보의 수집, 취급, 관리에 관하여 위탁 받은 목적  외의 용도로 이를 이용하거나 제3자에게 제공하지 않습니다.

제6조.  개인정보 파기절차 및 방법
이용자의  개인정보는 원칙적으로 개인정보의 수집 및 이용목적이 달성되면 지체없이 파기합니다. 회사의 개인정보 파기절차 및 방법은 다음과 같습니다.
① 파기절차
이용자가  회원가입 등을 위해 입력한 정보는 목적이 달성된 후 별도의 DB로 옮겨져(종이의 경우 별도의 서류함) 내부 방침 및 기타 관련 법령에 의한  정보보호 사유에 따라(보유 및 이용기간 참조)일정 기간 저장된 후 파기됩니다.
동 개인정보는  법률에 의한 경우가 아니고서는 보유되는 이외의 다른 목적으로 이용되지 않습니다.
②  파기방법
종이에 출력된  개인정보 및 접수된 서류는 분쇄하거나 소각을 통하여 파기합니다.
전자적 파일  형태로 저장된 개인정보는 복구할 수 없는 기술적 방법을 사용하여 삭제합니다.

제7조. 이용자  및 법정대리인의 개인정보에 대한 권리와 그 행사방법
① 이용자 및  법정대리인은 언제든지 등록되어 있는 자신 혹은 당해 만14세 미만 아동의 개인정보를 조회하거나 수정할 수 있으며 가입 해지를 요청할 수  있습니다.
② 이용자 혹은  만14세 미만 아동의 개인정보 조회와 수정을 위해서는 설정>고객센터>탈퇴하기를 클릭하여 요청하시면 정정 또는 탈퇴가 가능합니다.
혹은  개인정보관리책임자에게 서면, 전화 또는 이메일로 연락하시면 지체 없이 조치하겠습니다.
③ 회사는  이용자 혹은 법정대리인의 요청에 의해 해지 또는 삭제된 개인정보는 '제4조. 개인정보의 보유 및 이용기간'에 명시된 바에  따라 처리하고 그 외의 용도로 열람 또는 이용할 수 없도록 처리하고 있습니다.

제8조.  개인정보 자동 수집 장치의 설치/운영 및 거부에 관한 사항
회사는  이용자에게 개인화되고 맞춤화된 서비스를 제공하기 위해서 여러분의 정보를 저장하고 수시로 불러오는 '쿠키(cookie)를 사용합니다.
쿠키란  웹사이트를 운영하는데 이용되는 서버가 여러분의 브라우저에 보내는 작은 텍스트 파일로서 PC의 하드디스크에 저장됩니다. 여러분이 웹 사이트에  방문할 때 웹 사이트 서버는 쿠키의 내용을 읽어 환경 설정을 유지하도록 함으로써 여러분의 웹 사이트 접속과 편리한 사용을 돕게 됩니다.  아울러 쿠키는 여러분의 웹 사이트 방문 기록, 이용 형태나 관심 분야를 알게 해 줌으로써 이를 통한 최적화된 맞춤 서비스를 제공하는 것을  가능하도록 해 줍니다. 여러분은 쿠키 설치에 대한 선택권을 가지고 있으며, 웹브라우저의 옵션을 설정함으로써 모든 쿠키를 허용하거나, 쿠키가  저장될 때마다 확인을 거치거나, 아니면 모든 쿠키의 저장을 거부할 수도 있습니다. 다만, 쿠키 설치를 거부하였을 경우 로그인이 필요한 일부  서비스를 이용하는 것에는 어려움이 있을 수 있음을 미리 이해해 주시기 바랍니다.

제9조.  개인정보의 기술적/관리적 보호대책
회사는  이용자들의 개인정보를 취급함에 있어 개인정보가 분실, 도난, 누출, 변조 또는 훼손되지 않도록 안전성 확보를 위하여 다음과 같은  기술적/관리적 대책을 강구 하고 있습니다.
①개인정보  암호화
이용자의개인정보는비밀번호에의해보호되며,중요한데이터는파일및전송데이터를암호화하거나파일잠금기능을사용하는등의별도보안기능을통해보호하고있습니다.
② 기술적  보호대책
회사는 해킹이나  컴퓨터 바이러스 등에 의해 회원의 개인정보가 유출되거나 훼손되는 것을 막기 위해 최선을 다하고 있습니다.
회사는  개인정보의 훼손에 대비해서 자료를 수시로 백업하고 있고, 최신 백신프로그램을 이용하여 이용자들의 개인정보나 자료가 누출되거나 손상되지  않도록 방지하고 있습니다.
회사는 암호화  통신 등을 통하여 네트워크상에서 개인정보를 안전하게 송·수신할 수 있도록 하고 있습니다.
회사는  침입차단시스템을 이용하여 외부로부터의 무단 접근을 통제하고 있으며, 이외 시스템적인 보안성을 확보하기 위해 가능한 모든 기술적 장치를  갖추려 노력하고 있습니다.
③ 관리적  보호대책
회사는  개인정보관련 취급 직원을 담당자에 한정시키고 이를 위한 별도의 비밀번호를 부여하고, 정기적으로 갱신하고 있습니다.
회사는  주기적으로 담당자들을 교육하고 있으며, 이용자의 개인정보 취급·관리를 강조하고 있습니다.
회사는 사내  개인정보보호 관련부서 등을 통해서 회사의 개인정보취급방침 이행사항 및 담당자의 준수여부를 확인하여 문제가 발견될 경우 즉시 수정하고 바로  잡을 수 있도록 노력하고 있습니다.

9.  개인정보관리책임자 및 담당자의 연락처
이용자는 회사의  서비스를 이용하는 과정에서 발생하는 모든 개인정보보호 관련 민원을 개인정보관리책임자 혹은 담당부서로 신고할 수 있습니다. 회사는 이용자들의  신고사항에 대해 신속하게 답변을 드릴 것입니다.

개인정보  관리책임자 및 담당자
이름 :
부서 :
직위:
전화 :  02)304-3352
메일 :  info@bubuok.com

10. 고지의  의무
현  개인정보취급방침의 내용 추가, 삭제 및 수정 등의 변경이 있을 시에는 시행일의 7일 전부터 홈페이지의 공지사항을 통하여 고지할 것 입니다.
 -공고일자:2017년 2월 1일
 -시행일자:2017년 2월 1일
""", """
제 1 장 총  칙

제 1 조  (목적)
본  이용약관(이하 '약관'이라 함)은 주식회사 비유비유(이하 '회사'라 함)이 제공하는 도시탐험대 서비스(이하 '본  서비스'라 함)를 이용함에 있어 회사와 회원간의 권리, 의무 및 책임사항을 규정함을 목적으로 합니다.

제 2 조  (용어의 정의)
이 약관에서  사용하는 용어의 정의는 다음 각 호와 같으며, 정의되지 않은 용어에 대한 해석은 관계법령과 서비스의 이용약관 및 개인정보취급방침, 회사가  별도로 정한 지침 등에 상관례에 의합니다.
1.도시탐험대  서비스: 도시탐험대는 위치기반서비스로 여행지에서 글과 사진을 기록하고 공유하는 서비스입니다.
2.회원:  도시탐험대 회원으로 본 약관에 동의하여 이용계약을 체결하고 서비스를 이용하는 모든 회원을 의미합니다.
3.장소정보:  모바일 단말기의 WPS(Wifi Positioning System), GPS 기반으로 추출된 좌표를 이용하여 '회원'이 생성하는 지점들을  말합니다.
4.여행기 :  '위치정보이용'에 동의한 회원이 본인의 위치를 노출하고 자신의 여행기록을 작성하는 것을 의미합니다.
5.여행지점 :  ‘회사’가 미리 가공하여 도시탐험대 어플리케이션에 제공하는 여행지에 대한 장소정보이거나 회사가 제공한 것 이외에 사용자가 직접 카테고리를  선택하고 여행지의 명칭을 직접 시스템에 입력하여 생성한 장소정보
6.방문글 :  ‘본 서비스’를 활용하여 회원이 ‘탐험일기’를 작성할 때 각 지점별로 작성된 글(사진포함)을 의미합니다. 즉, 한 회원이 작성한  ‘여행기’는 그 회원이 각 ‘여행지점’에 작성한 ‘방문글’이 모여 하나의 ‘탐험일기’로 구성됩니다. ‘방문글’은 각 ‘여행지점’에  자동저장됩니다.
7.애플리케이션:  모바일 단말기에서 '본 서비스'를 설치하여 이용할 수 있도록 구성된 프로그램을 말합니다.
8.개인(회원)정보:  정보통신망 이용촉진 및 정보보호 등에 관한 법률에서 언급하는 '개인정보'를 말합니다.

제 3 조  (서비스 사업자의 개요)
1.이 약관에서  규정하는 서비스는 회사가 제공하는 서비스인 도시탐험대 서비스에 한하며 ‘상호 및 주소, 연락처는 다음의 각호와 같습니다.
2.상호 :  주식회사 비유비유
3.주소 :  서울시 마포구 성암로 330 DMC 첨단산업센터 C동 315호
4.연락처 :  02-304-3352

제 4 조  (약관의 효력 및 변경)
1.이 약관은  회사에서 제공하는 도시탐험대 서비스를 이용하고자 하는 모든 이용자에 대하여 그 효력을 발생합니다.
2.'회사'는  이 약관의 내용을 '회원'이 쉽게 알 수 있도록 '회사'의 웹 서비스 화면 좌측 설정메뉴에 게시합니다.
3.'회사'는  대한민국의 법령과 국제조약을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다.
4.'회사'가  약관을 개정할 경우에는 적용예정일 및 개정사유를 명시하여 현행약관과 함께 적용예정일 7일 전부터 공지합니다. 다만, '회원'에게 불리하게  약관내용을 변경하는 경우에는 최소한 30일 이상의 사전 유예기간을 두고 서비스 홈페이지에 공지하는 것 외에 전자우편발송 등 전자적 수단을  통해 별도로 통지합니다.
5.'회원'은  개정된 약관에 대해 동의하지 않을 권리가 있으며, 개정된 약관에 동의하지 않을 경우 이용계약을 해지할 수 있습니다. '회사'가 전항 단서에  따라 회원에게 통지하면서 상당한 기간(예:30일)을 정하여 거부의사를 표시하지 아니하면 승인한 것으로 본다는 뜻을 명확하게 고지하였음에도  '회원'의 의사표시가 없는 경우에는 변경된 약관을 승인한 것으로 봅니다.

제 5 조  (약관 외 준칙)
1.본 약관은  '회사'가 제공하는 제반 서비스에 관한 이용약관과 함께 적용합니다.


제 2 장  서비스 이용 계약 체결

제 6 조  (이용계약의 성립)
1.이용계약은  '회원'이 되고자 하는 자(이하 '가입신청자')가 약관의 내용에 대하여 동의 후 회원가입신청을 하고  '회사'가 신청을 승낙함으로써 수락됩니다.
2.이용계약은  서비스 이용 희망자가 이용약관에 동의한 후 이용신청에 대하여 회사가 승낙함으로써 성립합니다.

제 7 조  (서비스의 가입)
1.서비스 이용  신청은 서비스의 회원가입에서 '회원'이 본 약관에 동의하고 가입 양식에 요구하는 사항을 기재하여 신청합니다.
2.'회사'는  '가입신청자'의 신청에 대하여 '서비스' 이용을 승낙함을 원칙으로 합니다. 단, '회사'는 다음 각 호에 해당하는 신청에 대하여는 승낙을 하지 않거나 사후에 이용계약을 해지할 수 있습니다.
①서비스 관련  설비 용량이 부족한 경우
②기술상 문제가  있는 경우
③기타 회사의  사정상 필요하다고 인정되는 경우
④이용신청자가  다음 각 호의 사항을 위반하였을 경우 회사는 서비스 이용신청을 승낙하지 않을 수 있습니다.
⑤다른 사람의  명의를 도용하여 신청한 경우
⑥이용 신청 시  '회원정보'를 허위로 기재하여 신청한 경우
⑦사회의 안녕,  질서 또는 미풍양속을 저해할 목적으로 신청한 경우
⑧회사의  내부서비스 기준에 적합하지 않은 회원으로 판단되는 경우나 서비스 제공이 곤란한 경우
⑨14세 미만일  때 법정 대리인 동의를 얻지 않은 경우
⑩기타 회사가  정한 이용 신청 요건이 미비 된 경우

제 3 장  서비스 이용

제 8 조  (서비스 이용)
1.서비스의  이용은 연중무휴 1일 24시간을 원칙으로 합니다. 단, 회사의 업무 또는 기술상의 이유로 서비스가 일시 중지될 수 있으며, 운영상의  목적으로 회사가 정한 기간에도 서비스는 일시 중지 될 수 있습니다. 이때 회사는 사전 또는 사후에 이를 공지합니다.
2.'회사'는  모바일단말기( 안드로이드 OS 단말기 등) 전용 애플리케이션을 무료로 제공하며, '회원'은 '회사'에서 제공하는 범위 내의 단말기에서 전용  애플리케이션을 다운로드 및 설치하여 '본 서비스'를 이용할 수 있습니다. 단, 단말의 종류 및 통신사에 따라 애플리케이션의 구성과 기능에는  차이가 있을 수 있습니다.

제 9 조  (서비스 내용)
1.’본  서비스’는 휴대폰번호를 반드시 인증하여야만 서비스를 정상적으로 이용할 수 있으며 인증 받은 휴대폰 번호당 1개의 계정만 인정합니다.
2.'본  서비스'는 위치정보를 이용하여 회원 스스로 장소 정보를 생성하고, 장소정보와 자신의 탐험일기에 관련된 게시물, 이미지 등을  등록/관리/공유하는 서비스입니다.
3. ‘본  서비스’의 탐험일기는 회원 개인이 작성하는 것으로 타인과 공유하게 됩니다.
4'회사'는  '본 서비스'에 접속한 '회원'에게 위치정보를 활용한 장소를 등록하도록 하고 '회원'은 제공된 장소정보와 결합하여 글과 사진을 등록할 수  있으며, 등록 내용에 대한 공개 여부를 설정할 수 있습니다.
5.'회원'이  공개한 게시물은 본 서비스를 통해 친구들 혹은 전체 '회원'과 공유될 수 있습니다.
6.웹사이트에서는  본인이 작성한 정보를 활용하여 게시물을 제공할 수 있습니다.

제 10 조  (접속자의 위치 정보 이용)
1.모바일에서  '본 서비스'를 접속한 '회원'에게는 '위치정보이용'에 '동의'한 '회원'에 한하여 단말기를 통해 수집된 '위치정보'를 활용하여 장소정보  및 '회원'의 게시물을 제공할 수 있습니다.

제 11 조  (회원정보, 게시물에 대한 권리와 책임)
1.'회원'이  '본 서비스'에 게시한 '회원정보', 글 및 사진 등 모든 게시물에 대한 권리는 '회사'에게 있습니다.
2.'회사'가  작성한 저작물에 대한 저작권 기타 지적재산권은 '회사'에 귀속합니다.
3.'회원'은  '회사'가 정하는 방법에 의해 다른 '회원'의 '회원정보' 및 게시물을 열람할 수 있습니다. 다만, 정당한 권한 없이 다른 '회원'의  '회원정보' 및 게시물을 제거, 변경, 삭제하거나 게시, 전송, 링크, 배포하거나 저작자의 실명 또는 닉네임을 변경 또는 은닉하거나  '회원'의 '회원정보'나 게시물의 제호를 변경하여 당사자의 허락 없이 게시 및 게재할 수 없습니다.
4.'회원'은  '본 서비스'를 이용하여 선량한 풍속 기타 사회질서를 해하거나, 타인의 권리를 침해하는 행위를 하여서는 아니되고, 바이러스, 애드웨어,  스파이웨어 등을 포함하고 있는 내용 또는 제3자의 저작권 등 지적재산권을 침해하는 내용의 '회원정보'나 게시물을 게시하거나 전송 또는  배포할 수 없으며 이에 대한 모든 책임은 '회원' 본인에게 있습니다.
5.'회사'는  제4항에 해당하는 '회원정보'나 게시물의 경우 '회원'에 대한 사전 통지나 동의 확인 절차 없이 이를 삭제하거나 등록 거부할 수 있으며,  이에 대해 '회사'는 책임을 지지 않습니다.
6.'회원'은  자신이 게시한 '회원정보'나 게시물을 '회사' 또는 '회사'가 허락한 제3자가 아래의 목적으로 사용하는 것을 허락합니다.
7.'회원'이  서비스 내에 게시하는 '회원정보'나 게시물은 검색결과 내지 서비스 프로모션 등에 노출될 수 있으며, 해당 노출을 위해서 필요한 범위  내에서는 일부 수정, 편집되어 게시될 수 있습니다. 이 경우 '회원'은 언제든지 고객센터 또는 서비스 내 관리기능을 통해 해당 게시물에  대해 삭제, 비공개 등의 조치를 취할 수 있습니다.
8.'회사'는  '본 서비스'를 홍보하기 위한 목적으로 타 인터넷 포탈 사업자 등에게 '회원'의 '회원정보'나 게시물에 대한 검색목록 등의 정보를 제공할  수 있습니다. 단 '회원'이 공개한 범위에 한합니다.
9.'회사'는  '본 서비스'의 운영과 관련하여 서비스 화면, 홈페이지, 전자우편등에 광고를 게재할 수 있습니다. 광고가 게재된 전자우편 등을 수신한  '회원'은 수신거절을 '회사'에게 요청 할 수 있습니다.
10.'회사'는  이외의 방법으로 '회원'의 '회원정보'나 게시물을 이용하고자 하는 경우에는 전화, 팩스, 전자우편 등을 통해 사전에 '회원'의 동의를  얻어야 합니다.

제 12 조  (애플리케이션의 이용)
1.'회원'은  모바일단말기 제조사 및 통신사에서 제공하는 유무선 애플리케이션 마켓 혹은 '본 서비스' 내 다운로드 페이지를 통해 애플리케이션을 설치하여  서비스를 이용할 수 있습니다.
2.'회원'은  설치한 애플리케이션을 통해 등록한 게시물을 '본 서비스'의 '회원'들과 공유할 수 있습니다.
3.'회원'이  '본 서비스'의 일부 또는 이용규칙을 적용하는 데 사용되는 보안 기술이나 소프트웨어를 회피 또는 변경하려 시도를 하거나 부정 사용 및  타인이 그렇게 하는 것을 조장하는 행위 등은 금지되어 있으며, 만약 회원이 위와 같은 행위를 하는 경우 이에 대한 모든 책임은 '회원'  본인에게 있습니다.

제 13  조(서비스의 요금)
1.'회사'가  제공하는 서비스는 기본적으로 무료입니다. 단, 별도의 유료 서비스의 경우 해당 서비스에 명시된 요금을 지불하여야 사용  가능합니다.
2.'회사'는  유료 서비스 이용요금을 회사와 계약한 전자지불업체에서 정한 방법에 의하거나 회사가 정한 청구서에 합산하여 청구할 수 있습니다.
3.유료서비스  이용을 통하여 결제된 대금에 대한 취소 및 환불은 '회사'의 결제 이용약관에 따릅니다.
4.'회원'의  개인정보도용 및 결제사기로 인한 환불요청 또는 결제자의 개인정보 요구는 법률이 정한 경우 외에는 거절될 수 있습니다.
5.무선 서비스  이용 시 발생하는 데이터 통신료는 별도이며 가입한 각 이동통신사의 정책에 따릅니다.
6.MMS로  게시물을 등록할 경우 발생하는 요금은 이동통신사의 정책에 따릅니다.

제 14 조  (정보의 제공 및 광고의 게재)
1.'회사'는  광고를 포함하여 다양한 정보를 공지사항, 전자우편, 핸드폰 문자메시지(SMS), 우편 등의 방법으로 '회원'에게 제공할 수  있습니다.
2.'회사'는  불특정 다수 '회원'에 대한 통지를 하는 경우 7일 이상 '본 서비스' 초기화면에 동 통지를 게시함으로써 개별 통지에 갈음할 수 있습니다.  다만, '회원'에게 중대한 영향을 미치는 사항에 대하여는 전자우편, 쪽지 발송 등으로 통지합니다.
3.'회사'는  '본 서비스'의 운용과 관련하여 서비스 화면 등에 대하여 '회사'가 지정하는 위치에 광고 등을 게재할 수 있습니다.
4.'회원'은  '회사'에서 제공하는 사이트 광고에 대한 임의의 삭제, 비방 기타 사이트 광고 방해 행위 등을 할 수 없습니다.
5.'회사'는  '본 서비스'상에 게재되어 있거나 '본 서비스'를 통한 광고주의 판촉 활동에 '회원'이 참여하거나 교신 또는 거래함으로써 발생하는 손실과  손해에 대해 일체의 책임을 지지 않습니다.

제 15 조  (개인위치정보의 이용 또는 제공)
1.'회사'는  '회원'이 약관에 동의한 후 모바일단말기에서 '본 서비스'에 접속하여 최초 1회 '위치정보이용'에 동의하는 경우 해당 '회원'의 위치정보를  이용합니다.
2.위치정보이용  동의
①GPS가  탑재된 모바일단말기로 '본 서비스'에 접속하여 최초 1회 '위치정보이용'에 동의한 경우에만 위치정보를 이용하고 동의하지 않은 이용자의 경우  '본 서비스' 접속 시 마다 '위치정보이용' 동의 요청을 할 수 있습니다. 동의하지 않은 이용자의 경우 모바일 단말기에서 정상적인 서비스  이용이 어려울 수 있습니다.
②‘본  서비스’는 최초 로그인 후에는 자동로그인을 하며, '회원'은 모바일단말기에서 '본 서비스'에 로그인할 때마다 '위치정보이용' 동의 여부를  선택할 수 있습니다.
③모바일단말기로  무선 인터넷을 통해 '본 서비스'에 접속한 후 최초 1회 '위치정보이용'에 동의한 경우 GPS 또는 WPS(WiFi Positioning  System) 기술을 통해 수집된 위치정보를 이용합니다.
④'위치정보이용'에  동의를 한 '회원'은 서비스 이용시 본인의 위치를 자의적으로 노출하였다고 간주하며 '회사'는 이용자의 위치정보를 바탕으로 컨텐츠를  제공합니다.
⑤장소정보 및  컨텐츠 입력 등 서비스 이용시 회사는 '회원'이 생성한 컨텐츠에 대해서만 저장하며 '회원'의 위치에 대한 정보를 저장, 보존하지  않습니다.
⑥'회사'는  컨텐츠를 위치정보활용을 동의한 후 서비스에 가입 또는 로그인하고 어플리케이션을 구동하여 위치를 수신 받은 사용자를 위치를 기반으로 추천하기  위하여 '위치정보'를 이용합니다.
⑦'회원'은  원하는 경우 언제든지 서비스 탈퇴를 할 수 있으며, 서비스 탈퇴의 경우 위치정보 이용에 대한 회원의 동의를 철회하는 것으로 간주합니다.
3. ‘회원’  및 법정대리인의 권리와 그 행사방법은 제소 당시의 이용자의 주소에 의하며, 주소가 없는 경우에는 거소를 관할하는 지방법원의 전속관할로  합니다. 다만, 제소 당시 이용자의 주소 또는 거소가 분명하지 않거나 외국 거주자의 경우에는 민사소송법상의 관할법원에 제기합니다.
4. ‘회사’는  타사업자 또는 ‘회원‘과의 요금정산 및 민원처리를 위해 위치정보 이용·제공․사실 확인자료를 자동 기록·보존하며, 해당 자료는 1년간  보관합니다.
5. ‘회사’는  개인위치정보를 ‘회원’이 지정하는 제3자에게 제공하는 경우에는 개인위치정보를 수집한 당해 통신 단말장치로 매회 회원에게 제공받는 자,  제공일시 및 제공목적을 즉시 통보합니다. 단, 아래 각 호에 해당하는 경우에는 ‘회원’이 미리 특정하여 지정한 통신 단말장치 또는  전자우편주소로 통보합니다.
①개인위치정보를  수집한 당해 통신단말장치가 문자, 음성 또는 영상의 수신기능을 갖추지 아니한 경우
②‘회원’이  온라인 게시 등의 방법으로 통보할 것을 미리 요청한 경우

제 16 조  (개인위치정보주체의 권리)
1. ‘회원’은  ‘회사’에 대하여 언제든지 개인위치정보를 이용한 위치기반서비스 제공 및 개인위치정보의 제3자 제공에 대한 동의의 전부 또는 일부를 철회할  수 있습니다. 이 경우 회사는 수집한 개인위치정보 및 위치정보 이용, 제공사실 확인자료를 파기합니다.
2. ‘회원’은  ‘회사’에 대하여 언제든지 개인위치정보의 수집, 이용 또는 제공의 일시적인 중지를 요구할 수 있으며, ‘회사’는 이를 거절할 수 없고 이를  위한 기술적 수단을 갖추고 있습니다.
3. ‘회원’은  ‘회사’에 대하여 아래 각 호의 자료에 대한 열람 또는 고지를 요구할 수 있고, 당해 자료에 오류가 있는 경우에는 그 정정을 요구할 수  있습니다. 이 경우 ‘회사’는 정당한 사유 없이 ‘회원’의 요구를 거절할 수 없습니다.
① 본인에 대한  위치정보 수집, 이용, 제공사실 확인자료
② 본인의  개인위치정보가 위치정보의 보호 및 이용 등에 관한 법률 또는 다른 법률 규정에 의하여 제3자에게 제공된 이유 및 내용
4. ‘회원’은  제1호 내지 제3호의 권리행사를 위해 ‘회사’의 소정의 절차를 통해 요구할 수 있습니다.

제 17 조  (법정대리인의 권리)
1. ‘회사’는  14세 미만의 회원에 대해서는 개인위치정보를 이용한 위치기반서비스 제공 및 개인위치정보의 제3자 제공에 대한 동의를 당해 ‘회원’과 당해  회원의 법정대리인으로부터 동의를 받아야 합니다. 이 경우 법정대리인은 제16조에 의한 회원의 권리를 모두 가집니다.
2. ‘회사‘는  14세 미만의 아동의 개인위치정보 또는 위치정보 이용․제공사실 확인자료를 이용약관에 명시 또는 고지한 범위를 넘어 이용하거나 제3자에게  제공하고자 하는 경우에는 14세미만의 아동과 그 법정대리인의 동의를 받아야 합니다. 단, 아래의 경우는 제외합니다.
① 위치정보 및  위치기반서비스 제공에 따른 요금정산을 위하여 위치정보 이용, 제공사실 확인자료가 필요한 경우
② 통계작성,  학술연구 또는 시장조사를 위하여 특정 개인을 알아볼 수 없는 형태로 가공하여 제공하는 경우

제 18 조  (8세 이하의 아동 등의 보호의무자의 권리)
1. ‘회사’는  아래의 경우에 해당하는 자(이하 “8세 이하의 아동”등이라 한다)의 보호의무자가 8세 이하의 아동 등의 생명 또는 신체보호를 위하여  개인위치정보의 이용 또는 제공에 동의하는 경우에는 본인의 동의가 있는 것으로 봅니다.
① 8세 이하의  아동
② 금치산자
③  장애인복지법제2조제2항제2호의 규정에 의한 정신적 장애를 가진 자로서장애인고용촉진및직업재활법 제2조제2호의 규정에 의한 중증장애인에  해당하는 자(장애인복지법 제29조의 규정에 의하여 장애인등록을 한 자에 한한다)
2. 8세  이하의 아동 등의 생명 또는 신체의 보호를 위하여 개인위치정보의 이용 또는 제공에 동의를 하고자 하는 보호의무자는 서면동의서에  보호의무자임을 증명하는 서면을 첨부하여 회사에 제출하여야 합니다.
3.  보호의무자는 8세 이하의 아동 등의 개인위치정보 이용 또는 제공에 동의하는 경우 개인위치정보주체 권리의 전부를 행사할 수  있습니다.
제 19 조  (위치정보관리책임자의 지정)
1. ‘회사’는  위치정보를 적절히 관리․보호하고 개인위치정보주체의 불만을 원활히 처리할 수 있도록 실질적인 책임을 질 수 있는 지위에 있는 자를  위치정보관리책임자로 지정해 운영합니다.
2.  위치정보관리책임자는 위치기반서비스를 제공하는 부서의 부서장으로서 구체적인 사항은 본 약관의 부칙에 따릅니다.


제 4 장 계약  해지 및 이용제한

제 20 조  (계약해지 및 이용 중지)
1.'회원'이  다음 각 호의 행위에 해당하는 경우 또는 방송통신심의위원회 등 관계기관의 요청이 있는 경우 '회사'는 사전통지 없이 동 '회원'과의  이용계약을 해지 하거나 또는 기간을 정하여 동 '회원'의 '본 서비스' 이용을 중지할 수 있으며, 해당 게시물을 사전 통지 없이 삭제할 수  있습니다.
①'회사'에서  제공하는 서비스의 저장공간에 음란물을 게재하거나 음란사이트를 링크하거나, 이를 배포하는 등 사회질서를 해치는 행위
②공공질서 또는  미풍양속에 위배되는 내용의 정보, 문장, 도형, 음성 등을 유포하는 행위
③타인의 명예를  훼손 또는 모욕하는 행위
④'회사' 또는  제 3자의 저작권, 지적재산권 등 기타 권리를 침해하는 행위
⑤관계 법령에  의하여 그 제조, 수입, 전송 또는 게시가 금지되는 기술, 제품, 정보의 제조, 수입, 전송 또는 게시 행위
⑥범죄와  결부된다고 판단되는 행위
⑦해킹 또는  컴퓨터 바이러스를 유포하거나 타인의 의사에 반하여 광고성 정보 등 일정한 내용을 지속적으로 전송하는 행위
⑧다른 회원  이메일을 부정 사용하는 행위
⑨다른 사용자의  개인 정보를 수집, 도용, 저장하거나 이를 유포하는 행위
⑩타인을  사칭하는 행위
⑪서비스에  게재된 자료 및 저작물의 발신인을 위조하는 행위
⑫타인을  스톡(stalk)하거나, 괴롭히는 행위
⑬정당한 사유  없이 회원 가입, 탈퇴를 수 차례 반복하여 금전적 이득을 취하거나 '회사'의 서비스 운영에 지장을 초래하는 행위
⑭본인의  이메일을 타인에게 양도하거나 매매하는 행위
⑮서비스의  운영에 지장을 주거나 줄 우려가 있는 일체의 행위, 기타 관계 법령에 위배되는 행위
2.'회사'는  7조 2항에서 이용계약을 해지하거나 20조 제1항에 의해 해지된 '회원'이 다시 이용신청을 하는 경우 30일 동안 승낙을 제한하거나  이용신청을 거절할 수 있습니다.
3.'회원'은  본인이 원하는 경우 모바일 어플리케이션에서 탈퇴 신청을 할 수 있습니다.
4.'회원'이  '본 서비스'를 탈퇴하면 로그인 할 수 없으며 동 '회원'의 '본 서비스' 내의 '회원정보'는 개인정보 보호정책에 따라 자동으로  삭제됩니다.


제 5 장 계약  당사자의 의무와 책임

제 21 조  (회사의 의무)
1.'회사'는  법령과 본 약관에서 정하는 사항을 준수하고 지속적이고 안정적으로 '본 서비스'를 제공하기 위해서 노력합니다.
2.'회사'는  '본 서비스'와 관련한 '회원'의 불만사항이 접수되는 경우 이를 즉시 처리하여야 하며, 즉시 처리가 곤란한 경우 그 사유와 처리일정을 '본  서비스' 또는 전자우편을 통하여 동 '회원'에게 통지하여야 합니다.

제 22 조  (회원의 의무)
1.'회원'은  본인의 '회원정보'를 객관적이고 정확하게 기재해야 합니다.
2.'회원'은  관계법령, 본 약관의 규정, 이용안내 및 서비스상에 공지한 주의 사항, '회사'가 통지하는 사항을 준수하여야 하며, 기타 '회사' 업무에  방해되는 행위를 하여서는 아니 됩니다.
3.'회원'은  '회사'의 사전 동의 없이 '본 서비스'를 이용하여 어떠한 영리행위도 할 수 없으며, 법에 저촉되는 자료를 배포 또는 게재할 수  없습니다.
4.'회원'은  본인의 이메일과 비밀번호를 유지 관리할 책임이 있으며 이메일과 비밀 번호의 유출로 발생하는 결과에 대해 '회사'는 일체의 책임을 지지  않습니다. 다만, 회사의 고의 또는 중과실이 있는 경우에는 그러하지 않습니다.
5.'회원'은  '회사' 혹은 게시자 본인의 사전승낙 없이는 '본 서비스'를 이용하여 얻은 정보를 복사, 복제, 변경, 번역, 출판, 방송, 광고, 영업,  전송, 기타의 방법으로 사용하거나 이를 타인에게 제공하는 행위를 할 수 없습니다.
6.'회원'은  '회사'와 기타 제3자의 저작권 등 지적재산권에 대한 침해를 할 수 없습니다.
7.'회원'은  회사의 동의 없이 영리를 목적으로 '본 서비스'를 사용하는 행위를 할 수 없습니다.


제 6 장  손해배상 및 면책조항 등

제 23 조  (손해배상)
1.'회사'는  '회원'이 서비스를 이용함에 있어 '회사'의 고의 또는 중대한 과실이 인정될 경우 손해 배상을 부담 할 수 있습니다.
2.'회원'이  본 약관의 의무를 위반함으로 인하여 회사에 손해를 입힌 경우 또는 '회원'이 서비스를 이용함에 있어 회사에 손해를 입힌 경우에 '회원'은  '회사'에 대하여 그 손해를 배상하여야 합니다. 이 경우 ‘회원’은 고의, 과실이 없음을 입증하지 못하는 경우 책임을 면할 수 없습니다.
3. ‘회사’가  위치정보의 보호 및 이용 등에 관한 법률 제15조 내지 제26조의 규정을 위반한 행위로 ‘회원’에게 손해가 발생한 경우 ‘회원’은  ‘회사’에 대하여 손해배상 청구를 할 수 있습니다. 이 경우 ‘회사’는 고의, 과실이 없음을 입증하지 못하는 경우 책임을 면할 수  없습니다.

제 24 조  (면책조항)
1.'회사'는  천재지변 또는 이에 준하는 불가항력으로 인하여 '서비스'를 제공할 수 없는 경우에는 '서비스' 제공에 관한 책임이 면제됩니다.
2.'회사'는  '회원' 의 귀책사유로 인한 서비스 이용의 장애에 대하여는 책임이 면제됩니다. 단 '회원'에게 부득이하거나 정당한 사유가 있는 경우에는  그러하지 아니합니다.
3.'회사'는  '회원'이 '서비스'와 관련하여 게재한 정보, 자료, 사실의 신뢰도, 정확성 등의 내용에 관하여는 책임을 지지 않습니다.
4.'회사'는  '회원' 간 또는 '회원'과 제3자 상호간에 '서비스'를 매개로 하여 거래 등을 한 경우에는 책임이 면제됩니다.
5.'회사'는  무료로 제공되는 서비스 이용과 관련하여 관련법에 특별한 규정이 없는 한 책임을 지지 않습니다.

제 25 조  (분쟁의 해결)
1.본 약관에  관하여 분쟁이 발생할 경우 대한민국의 법률에 따릅니다.
2.서비스의  이용과 관련하여 분쟁이 발생할 경우 관할법원은 민사소송법상 관할법원으로 합니다.
3.‘회사’는  위치정보와 관련된 분쟁에 대해 당사자간 협의가 이루어지지 아니하거나 협의를 할 수 없는 경우에는 전기통신사업법 제45조의 규정에 의한  방송통신위원회에 재정을 신청할 수 있습니다.
4.‘회사’  또는 ‘회원’은 위치정보와 관련된 분쟁에 대해 당사자간 협의가 이루어지지 아니하거나 협의를 할 수 없는 경우에는 개인정보보호법 제40조의  규정에 의한 개인정보분쟁조정위원회에 조정을 신청할 수 있습니다.

•[부칙]
1.(시행일)  이 약관은 2017년 2월 1일부터 시행됩니다.
2.  위치정보관리책임자는 2017년 2월 1일을 기준으로 다음과 같이 지정합니다.
①이름:
② 소속 :  ㈜비유비유
③ 연락처 :  02-304-3352
"""]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        layoutCheck()
    }
    
    func setData() {
        if let index = index {
           descText.text = descs[index]
        }
    }
    

    func layoutCheck() {
        //iPhoneX 는 네비게이션,스테이터스바 가 다른형식임
        if Constants.DeviceType.IS_IPHONE_X {
            topViewHeight.constant = 88
            // iPhone X 일 때 레이아웃
        }
    }
    
    @IBAction func tappedBackButton(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
