package kr.icia.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.icia.domain.OrderListVO;
import kr.icia.domain.OrderVO;
import kr.icia.domain.StoreVO;
import kr.icia.domain.UserVO;

public interface MemberMapper {

	// 회원가입
	public void insert(UserVO vo);

	// 로그인
	public UserVO login(UserVO vo) throws Exception;

	// 내 정보 수정하기 위해 하나 더 설정
	public UserVO login(String user_id) throws Exception;

	// 회원목록
	public List<UserVO> memberList() throws Exception;

	// 회원 정보 상세보기
	public UserVO viewMember(String user_id) throws Exception;

	// 회원삭제
	public void deleteMember(String user_id) throws Exception;

	// 회원정보 수정
	public void updateMember(UserVO vo) throws Exception;

	// 아이디확인
	public UserVO idCheck(String user_id) throws Exception;

	// 아이디찾기
	public String find_id(String user_email) throws Exception;

	// 마이페이지 수정
	public void update_mypage(UserVO vo) throws Exception;

	// 비밀번호 변경
	public void update_pw(UserVO vo) throws Exception;

	// 회원탈퇴
	public int withdrawal(UserVO vo) throws Exception;

	// 임시비밀번호 찾기
	public void changePw(@Param("user_pw") String user_pw, @Param("user_id") String user_id) throws Exception;

	// 이메일확인
	public UserVO emailCheck(String user_email) throws Exception;

	// 주문목록
	public List<OrderVO> orderList();

	// 특정 주문목록
	public List<OrderListVO> orderView(OrderVO order);

	// 배송상태
	public void delivery(OrderVO order);

	// 상품 수량조절
	public void changeStock(StoreVO goods);

}