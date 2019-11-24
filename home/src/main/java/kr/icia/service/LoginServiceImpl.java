package kr.icia.service;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.icia.domain.OrderListVO;
import kr.icia.domain.OrderVO;
import kr.icia.domain.StoreVO;
import kr.icia.domain.UserVO;
import kr.icia.mapper.MemberMapper;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
@Log4j
public class LoginServiceImpl implements LoginService {

	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;

	// 회원가입
	@Override
	public void insert(UserVO vo) throws Exception {

		log.info("insert.....");

		mapper.insert(vo);

	}

	// 아이디 확인
	@Override
	public UserVO idCheck(String user_id) throws Exception {
		return mapper.idCheck(user_id);
	}

	// 이메일 확인
	@Override
	public UserVO emailCheck(String user_email) throws Exception {
		return mapper.emailCheck(user_email);
	}

	// 로그인
	@Override
	public UserVO login(UserVO vo, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		// 등록된 아이디가 없으면
		if (mapper.idCheck(vo.getUser_id()) == null) {
			out.println("<script>");
			out.println("alert('등록된 아이디가 없습니다.');");
			out.println("history.go(-1);");
			out.println("</script>");
			out.close();
			return null;
		} else {
			return mapper.login(vo);
		}
	}

	// 로그아웃
	@Override
	public void logout(HttpSession session) throws Exception {

		session.invalidate();
	}

	// 회원목록
	@Override
	public List<UserVO> memberList() throws Exception {

		return mapper.memberList();
	}

	// 회원 정보 상세 조회
	@Override
	public UserVO viewMember(String user_id) throws Exception {

		return mapper.viewMember(user_id);
	}

	// 회원정보 삭제
	@Override
	public void deleteMember(String user_id) throws Exception {
		mapper.deleteMember(user_id);
	}

	// 회원정보 수정
	@Override
	public void updateMember(UserVO vo) throws Exception {
		mapper.updateMember(vo);
	}

	// 아이디 찾기
	@Override
	public String find_id(HttpServletResponse response, String email) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		String id = mapper.find_id(email);

		if (id == null) {
			out.println("<script>");
			out.println("alert('가입된 아이디가 없습니다.');");
			out.println("history.go(-1);");
			out.println("</script>");
			out.close();
			return null;
		} else {
			return id;
		}
	}

	// 마이페이지 수정
	@Override
	public UserVO update_mypage(UserVO vo) throws Exception {
		mapper.update_mypage(vo);
		return mapper.login(vo.getUser_id());
	}

	// 비밀번호 변경
	@Override
	public UserVO update_pw(UserVO vo, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=utf-8");

		mapper.update_pw(vo);
		return mapper.login(vo.getUser_id());

	}

	// 회원탈퇴
	@Override
	public boolean withdrawal(UserVO vo, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		if (mapper.withdrawal(vo) != 0) {
			out.println("<script>");
			out.println("alert('회원탈퇴 실패');");
			out.println("history.go(-1);");
			out.println("</script>");
			out.close();
			return false;
		} else {
			return true;
		}
	}

	// 비밀번호 찾기
	@Override
	public void changePw(String user_pw, String user_id) throws Exception {

		mapper.changePw(user_pw, user_id);

	}

	// 주문목록
	@Override
	public List<OrderVO> orderList() {

		return mapper.orderList();
	}

	// 특정 주문
	@Override
	public List<OrderListVO> orderView(OrderVO order) {

		return mapper.orderView(order);
	}

	// 배송상태
	public void delivery(OrderVO order) {
		mapper.delivery(order);
	}

	@Override
	public void changeStock(StoreVO goods) {
		mapper.changeStock(goods);

	}

}