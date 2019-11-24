package kr.icia.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.icia.domain.UserVO;
import kr.icia.service.FindUtil;
import kr.icia.service.LoginService;
import kr.icia.service.MailUtil;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/login/*")
public class LoginController {

	// 암호화
	@Autowired
	private BCryptPasswordEncoder pwencoder;

	@Autowired
	private LoginService lservice;

	// 로그인  get
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public void getlogin() throws Exception {

	}

	// 로그인 post
		@RequestMapping(value = "/login", method = RequestMethod.POST)
		public String postlogin(UserVO vo, HttpServletRequest req, RedirectAttributes rttr, HttpServletResponse response)
				throws Exception {

			UserVO login = lservice.login(vo, response);

			HttpSession session = req.getSession();

			boolean passMatch = pwencoder.matches(vo.getUser_pw(), login.getUser_pw());

			// 등록된 아이디와 비밀번호를 잘못 작성하였을때
			if (login != null && passMatch) {
				session.setAttribute("member", login);
			} else {
				session.setAttribute("member", null);
				rttr.addFlashAttribute("msg", "비밀번호를 확인해주세요");
				return "redirect:/login/login";
			}

			return "redirect:/";
		}


	// 로그아웃
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String signout(HttpSession session) throws Exception {

		lservice.logout(session);

		return "redirect:/";
	}

	// 회원가입get
	@RequestMapping(value = "/signup", method = RequestMethod.GET)
	public void getsignup(HttpServletRequest request) {

	}

	// 회원가입post
	@RequestMapping(value = "/signup", method = RequestMethod.POST)
	public String postsignup(HttpServletRequest request, UserVO vo, RedirectAttributes rttr, Model model)
			throws Exception {

		String pass = pwencoder.encode(vo.getUser_pw());
		vo.setUser_pw(pass);
		lservice.insert(vo);

		rttr.addFlashAttribute("request", vo.getUser_id());
		rttr.addFlashAttribute("msg", "회원가입이 완료되었습니다.");

		return "redirect:/login/login";
	}

	// 회원확인
	@ResponseBody
	@RequestMapping(value = "/signup/idCheck", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public int postIdCheck(HttpServletRequest req) throws Exception {

		String user_id = req.getParameter("user_id");
		UserVO idCheck = lservice.idCheck(user_id);

		int result = 0;
		if (idCheck != null) {
			result = 1;
			log.info("result :" + result);
		}
		log.info("result :" + result);

		return result;

	}

	// 이메일 확인
	@ResponseBody
	@RequestMapping(value = "/signup/emailCheck", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public int postemailCheck(HttpServletRequest req) throws Exception {

		String user_email = req.getParameter("user_email");
		UserVO emailCheck = lservice.emailCheck(user_email);

		int result2 = 0;
		if (emailCheck != null) {
			result2 = 1;
			log.info("result2 :" + result2);
		}
		log.info("result2 :" + result2);

		return result2;

	}

	// 마이페이지
	@RequestMapping(value = "/mypage1", method = RequestMethod.GET)
	public String mypage() throws Exception {
		return "/login/mypage1";
	}
	
	

	// 내 정보
	@RequestMapping(value = "/member", method = RequestMethod.GET)
	public String member() throws Exception {
		return "/login/member";
	}

	// mypage 수정
	@RequestMapping(value = "/update_mypage", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String update_mypage(@ModelAttribute UserVO vo, HttpSession session, RedirectAttributes rttr)
			throws Exception {
		session.setAttribute("vo", lservice.update_mypage(vo));
		rttr.addFlashAttribute("msg", "회원정보 수정 완료. 다시 로그인 해주십시오.");

		// 로그아웃
		lservice.logout(session);

		return "redirect:/login/login";
	}

	// 비밀번호 변경
	@RequestMapping(value = "/update_pw", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String update_pw(@ModelAttribute UserVO vo, HttpSession session, HttpServletResponse response,
			RedirectAttributes rttr) throws Exception {

		String pass = pwencoder.encode(vo.getUser_pw());
		vo.setUser_pw(pass);

		session.setAttribute("vo", lservice.update_pw(vo, response));
		rttr.addFlashAttribute("msg", "비밀번호 수정 완료");

		return "redirect:/login/mypage1";
	}

	// 회원탈퇴
	@RequestMapping(value = "/withdrawal", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String withdrawal_form(@ModelAttribute UserVO vo, HttpSession session, HttpServletResponse response)
			throws Exception {

		String pass = pwencoder.encode(vo.getUser_pw());
		vo.setUser_pw(pass);

		if (lservice.withdrawal(vo, response)) {
			session.invalidate();
		}
		return "redirect:/";
	}

// 아이디 찾기get
	@RequestMapping(value = "/find_id_Form", method = RequestMethod.GET)
	public String find_id_Form() throws Exception {
		return "/login/find_id_Form";
	}

// 아이디 찾기post
	@RequestMapping(value = "/find_id", method = RequestMethod.POST)
	public String find_id(HttpServletResponse response, @RequestParam("user_email") String user_email, Model md)
			throws Exception {
		md.addAttribute("user_id", lservice.find_id(response, user_email));
		return "/login/find_id";
	}

	// 비밀번호찾기get
	@RequestMapping(value = "/find_pw_Form", method = RequestMethod.GET)
	public String find_pw_Form() throws Exception {

		return "/login/find_pw_Form";
	}

	// 비밀번호찾기get
	@RequestMapping(value = "/changePw", method = RequestMethod.GET)
	public String changPw() throws Exception {

		return "/login/login";
	}

	// 비밀번호찾기post
	@RequestMapping(value = "/changePw", method = RequestMethod.POST)
	@ResponseBody
	public String changePw(UserVO vo, @Param("email") String email, @Param("id") String id, String inputCode,
			HttpSession session) throws Exception {

		log.info("user id= " + id);
		log.info("user_email " + email);
		String newPw = FindUtil.getNewPw();

		String user_pw = pwencoder.encode(newPw);
		log.info(newPw);
		log.info(user_pw);
		log.info(id);

		vo.setUser_pw(user_pw);

		log.info("user id= " + id);
		log.info("user_email " + email);
		session.removeAttribute("keyCode");

		lservice.changePw(user_pw, id);

		String subject = "[집공] 임시 비밀번호 발급 안내";

		String msg = "";
		msg += "<div align='center' style='border:1px solid black; font-family:verdana'>";
		msg += "<h3 style='color:blue;'><strong>" + id;
		msg += "님</strong>의 임시 비밀번호 입니다. 로그인 후 비밀번호를 변경하세요</h3>";
		msg += "<p>임시 비밀번호:<strong>" + newPw + "</strong></p></div>";

		MailUtil.sendMail(email, subject, msg);

		return "/login/lgoin";

	}

}