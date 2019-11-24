package kr.icia.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.icia.domain.BoardAttachVO;
import kr.icia.domain.BoardVO;
import kr.icia.domain.CategoryVO;
import kr.icia.domain.CommunityLikeVO;
import kr.icia.domain.CommunityReplyVO;
import kr.icia.domain.CommunityTableVO;
import kr.icia.domain.Criteria;
import kr.icia.domain.OrderListVO;
import kr.icia.domain.OrderVO;
import kr.icia.domain.PageDTO;
import kr.icia.domain.StoreVO;
import kr.icia.domain.StoreViewVO;
import kr.icia.domain.UserVO;
import kr.icia.service.BoardService;
import kr.icia.service.CommunityService;
import kr.icia.service.LoginService;
import kr.icia.service.StoreService;
import kr.icia.utils.UploadFileUtils;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import net.sf.json.JSONArray;

@AllArgsConstructor
@Controller
@Log4j
@RequestMapping("/admin/*")
public class AdminController {

	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public void getIndex() throws Exception {
		log.info("get index");
	}

	// 관리자 커뮤니티 매핑
	// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	// 관리자 커뮤니티 글쓰기
	private CommunityService Coservice;

	@Resource(name = "uploadPath")
	private String uploadPath;

	@RequestMapping("/community/communityList")
	public String communityList(Model model) {

		model.addAttribute("communityList", Coservice.getCommunityList());

		return "/admin/community/communityList";
	}

	@GetMapping("/community/registerCommunity")
	public void register() {

	}

//	관리자 커뮤니티 글쓰기
	@RequestMapping(value = "/community/registerCommunity", method = RequestMethod.POST)
	public String register(CommunityTableVO community_bno, MultipartFile file) throws Exception {

		String imgUploadPath = uploadPath + File.separator + "imgUpload";
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		String fileName = null;

		if (file != null) {
			fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);
		} else {
			fileName = uploadPath + File.separator + "images" + File.separator + "none.png";
		}

		community_bno.setGdsImg(File.separator + "imgUpload" + ymdPath + File.separator + fileName);
		community_bno.setGdsThumbImg(
				File.separator + "imgUpload" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);

		Coservice.register(community_bno);

		// 리다이렉트 시키면서 1회용 값을 전달.
		return "redirect:/admin/community/communityList";
	}

	// 상품 소감(댓글) 작성
	@ResponseBody
	@RequestMapping(value = "/community/getCommunityViewList/registReply", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public void registReply(CommunityReplyVO reply, HttpSession session) throws Exception {

		UserVO member = (UserVO) session.getAttribute("member");
		reply.setUser_id(member.getUser_id());

		Coservice.registReply(reply);
	}

	// 커뮤니티 상세 목록
	@GetMapping({ "/community/getCommunityViewList" })
	public void getCommunityViewList(@RequestParam("community_bno") Long community_bno, Model model,
			HttpServletRequest httpRequest) {

		model.addAttribute("CommunityViewList", Coservice.getCommunityViewList(community_bno));
		model.addAttribute("heart", Coservice.getBoardLike(community_bno));
	}

	// 좋아요 if문
	@ResponseBody
	@RequestMapping(value = "/community/getCommunityViewList/heart", method = RequestMethod.POST, produces = "application/json")
	public int heart(CommunityLikeVO like, HttpServletRequest httpRequest, HttpSession session, Model model) {

		int heart = Integer.parseInt(httpRequest.getParameter("heart"));
		long community_bno = Integer.parseInt(httpRequest.getParameter("community_bno"));
		String user_id = ((UserVO) httpRequest.getSession().getAttribute("member")).getUser_id();

		CommunityLikeVO VO = new CommunityLikeVO();

		VO.setCommunity_bno(community_bno);
		VO.setUser_id(user_id);

		System.out.println(heart);
		if (heart >= 1) {
			Coservice.deleteBoardLike(VO);
			heart = 0;
		} else {
			Coservice.createBoardLike(VO);
			heart = 1;

		}

		return heart;

	}

	// 상품 소감(댓글) 목록
	@ResponseBody
	@RequestMapping(value = "/community/getCommunityViewList/replyList", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public List<CommunityReplyVO> getReplyList(@RequestParam("community_bno") Long community_bno) throws Exception {

		List<CommunityReplyVO> reply = Coservice.replyList(community_bno);

		return reply;
	}

	// 상품 소감(댓글) 삭제
	@ResponseBody
	@RequestMapping(value = "/community/getCommunityViewList/deleteReply", method = RequestMethod.POST)
	public int getReplyList(CommunityReplyVO reply, HttpSession session) throws Exception {

		int result = 0;
		UserVO member = (UserVO) session.getAttribute("member");
		String user_id = Coservice.replyUserIdCheck(reply.getRepNum());

		if (member.getUser_id().equals(user_id)) {

			reply.setUser_id(member.getUser_id());
			Coservice.deleteReply(reply);

			result = 1;
		}

		return result;
	}

	@ResponseBody
	@RequestMapping(value = "/community/getCommunityViewList/modifyReply", method = RequestMethod.POST)
	public int modifyReply(CommunityReplyVO reply, HttpSession session) throws Exception {

		int result = 0;

		UserVO member = (UserVO) session.getAttribute("member");
		String user_id = Coservice.replyUserIdCheck(reply.getRepNum());

		if (member.getUser_id().equals(user_id)) {

			reply.setUser_id(member.getUser_id());
			Coservice.modifyReply(reply);
			result = 1;
		}

		return result;
	}

	// 커뮤니티 수정창 겟방식(modify)
	@GetMapping("/community/communityModify")
	public void getCommunityModify(@RequestParam("community_bno") Long community_bno, Model model) {

		model.addAttribute("CommunityViewList", Coservice.getCommunityViewList(community_bno));
	}

	// 커뮤니티 수정 요청(post방식)
	@RequestMapping(value = "/community/communityModify", method = RequestMethod.POST)
	public String CommunityModify(CommunityTableVO community_bno, MultipartFile file, HttpServletRequest req)
			throws Exception {
		// 새로운 파일이 등록되었는지 확인
		if (file.getOriginalFilename() != null && file.getOriginalFilename() != "") {
			// 기존 파일을 삭제
			new File(uploadPath + req.getParameter("gdsImg")).delete();
			new File(uploadPath + req.getParameter("gdsThumbImg")).delete();

			// 새로 첨부한 파일을 등록
			String imgUploadPath = uploadPath + File.separator + "imgUpload";
			String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
			String fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(),
					ymdPath);

			community_bno.setGdsImg(File.separator + "imgUpload" + ymdPath + File.separator + fileName);
			community_bno.setGdsThumbImg(
					File.separator + "imgUpload" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);

		} else { // 새로운 파일이 등록되지 않았다면
			// 기존 이미지를 그대로 사용
			community_bno.setGdsImg(req.getParameter("gdsImg"));
			community_bno.setGdsThumbImg(req.getParameter("gdsThumbImg"));

		}

		Coservice.communityModify(community_bno);

		return "redirect:/admin/community/communityList";
	}

	// 상품 삭제
	@RequestMapping(value = "/community/communityDelete", method = RequestMethod.POST)
	public String postGoodsDelete(@RequestParam("community_bno") Long community_bno, MultipartFile file,
			HttpServletRequest req) throws Exception {

		Coservice.deleteLike(community_bno);
		Coservice.deleteAll(community_bno); // 게시물의 덧글을 삭제하고,
		Coservice.communityDelete(community_bno);

		return "redirect:/admin/community/communityList";
	}
	// 커뮤니티 관리자 매핑 끝
	// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

	// 관리자 회원목록(로그인)@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	@Autowired
	private LoginService lservice;

	// 암호화
	@Autowired
	private BCryptPasswordEncoder pwencoder;

	// 회원목록
	@RequestMapping("/login/memberList")
	public String memberList(Model model) throws Exception {
		List<UserVO> list = lservice.memberList();
		model.addAttribute("list", list);

		return "/admin/login/memberList";
	}

	// 회원 상세 정보조회
	@RequestMapping("/login/memberView")
	public String memberView(@RequestParam String user_id, Model model) throws Exception {
		model.addAttribute("vo", lservice.viewMember(user_id));
		log.info("클릭한 아이디 : " + user_id);
		return "/admin/login/memberView";
	}

	// 회원 정보 수정 처리
	@RequestMapping("/login/memberUpdate")
	public String memberUpdate(@ModelAttribute UserVO vo, Model model) throws Exception {

		/*
		 * String pass = pwencoder.encode(vo.getUser_pw()); vo.setUser_pw(pass);
		 */

		lservice.updateMember(vo);
		return "redirect:/admin/login/memberList";
	}

	// 회원정보 삭제처리
	@RequestMapping("/login/delete")
	public String memberDelete(@RequestParam String user_id) throws Exception {

		lservice.deleteMember(user_id);
		return "redirect:/admin/login/memberList";
	}

	// @@@@@@@@@@@@@@@@@@@@@@@@@@STORE@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	private StoreService service;

	@GetMapping("/store/storeList")
	public void getList(Criteria cri, Model model) {
		log.info("list : " + cri);
		model.addAttribute("StoreList", service.getList(cri));
//		model.addAttribute("pageMaker", new PageDTO(cri, 123));
		int total = service.getTotal(cri);
		log.info("total : " + total);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}

	// 상품 등록
	@GetMapping("/store/register")
	public void storeRegister(Model model) throws Exception {
		log.info("get category register.........");

		List<CategoryVO> category = null;
		category = service.category();
		model.addAttribute("category", JSONArray.fromObject(category));
	}

	@PostMapping("/store/register")
	public String storeRegister(StoreVO store, MultipartFile file, @ModelAttribute("cri") Criteria cri,
			RedirectAttributes rttr) throws IOException, Exception {
		// @Controller 어노테이션이 붙고,
		// 컴포넌트 스캔에 패키지가 지정되어 있다면,
		// 매개변수 인자들은 스프링이 자동으로 생성 할당 함.
		log.info("register : " + store);
		String imgUploadPath = uploadPath + File.separator + "imgUpload";
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		String fileName = null;
		System.out.println("aa:" + file);

		if (file != null) {
			fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);
		} else {
			fileName = uploadPath + File.separator + "images" + File.separator + "none.png";
		}

		store.setImg(File.separator + "imgUpload" + ymdPath + File.separator + fileName);
		store.setThumbImg(
				File.separator + "imgUpload" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);
		service.register(store);
		rttr.addFlashAttribute("result", store.getProNo());
		log.info("썸네일" + store.getThumbImg());
		// 리다이렉트 시키면서 1회용 값을 전달.
		return "redirect:/admin/store/storeList";
	}

	@GetMapping("/store/get")
	public void storeGet(@RequestParam("proNo") Long proNo, @ModelAttribute("cri") Criteria cri,
			RedirectAttributes rttr, Model model) {
		// @RequestParam : 요청 전달값으로 글번호 이용.
		log.info("get......");
		StoreViewVO store = service.get(proNo);
		model.addAttribute("store", store);

		// jsp에서 request.setAttribute 하던 것과 비슷.
		// 전달값으로 명시만 하면 스프링이 자동 처리.
		// 사용하는 부분만 추가 구현.
	}

	@GetMapping("/store/modify")
	public void storeGetModify(@RequestParam("proNo") Long proNo, @ModelAttribute("cri") Criteria cri,
			RedirectAttributes rttr, Model model) {
		// @RequestParam : 요청 전달값으로 글번호 이용.
		log.info("getModify......");
		StoreViewVO store = service.get(proNo);
		model.addAttribute("store", store);

		List<CategoryVO> category = null;
		category = service.category();
		model.addAttribute("category", JSONArray.fromObject(category));

		// jsp에서 request.setAttribute 하던 것과 비슷.
		// 전달값으로 명시만 하면 스프링이 자동 처리.
		// 사용하는 부분만 추가 구현.
	}

	// 상품 수정
	@RequestMapping(value = "/store/modify", method = RequestMethod.POST)
	public String postGoodsModify(StoreViewVO store, MultipartFile file, HttpServletRequest req) throws Exception {
		log.info("modify");

		// 새로운 파일이 등록되었는지 확인
		if (file.getOriginalFilename() != null && file.getOriginalFilename() != "") {
			// 기존 파일을 삭제
			new File(uploadPath + req.getParameter("img")).delete();
			new File(uploadPath + req.getParameter("ThumbImg")).delete();

			// 새로 첨부한 파일을 등록
			String imgUploadPath = uploadPath + File.separator + "imgUpload";
			String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
			String fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(),
					ymdPath);

			store.setImg(File.separator + "imgUpload" + ymdPath + File.separator + fileName);
			store.setThumbImg(
					File.separator + "imgUpload" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);

		} else {
			store.setImg(req.getParameter("img"));
			store.setThumbImg(req.getParameter("ThumbImg"));
		}
		service.modify(store);
		return "redirect:/admin/store/storeList";
	}

	@PostMapping("/store/remove")
	public String storeRemove(@RequestParam("proNo") Long proNo, @ModelAttribute("cri") Criteria cri,
			RedirectAttributes rttr) {
		log.info("remove..." + proNo);
		if (service.remove(proNo)) {
			rttr.addFlashAttribute("result", service.get(proNo));
		}
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		return "redirect:/admin/store/storeList";
	}

	// ck 에디터에서 파일 업로드
	@RequestMapping(value = "/store/ckUpload", method = RequestMethod.POST)
	public void postCKEditorImgUpload(HttpServletRequest req, HttpServletResponse res,
			@RequestParam MultipartFile upload) throws Exception {
		log.info("post CKEditor img upload");

		// 랜덤 문자 생성
		UUID uid = UUID.randomUUID();

		OutputStream out = null;
		PrintWriter printWriter = null;

		// 인코딩
		res.setCharacterEncoding("utf-8");
		res.setContentType("text/html;charset=utf-8");

		try {

			String fileName = upload.getOriginalFilename();
			// 파일 이름 가져오기
			byte[] bytes = upload.getBytes();

			// 업로드 경로
			String ckUploadPath = uploadPath + File.separator + "ckUpload" + File.separator + uid + "_" + fileName;

			out = new FileOutputStream(new File(ckUploadPath));
			out.write(bytes);
			out.flush();
			// out에 저장된 데이터를 전송하고 초기화

			String callback = req.getParameter("CKEditorFuncNum");
			printWriter = res.getWriter();
			String fileUrl = "/ckUpload/" + uid + "_" + fileName;
			// 작성화면

			// 업로드시 메시지 출력
			printWriter.println("<script type='text/javascript'>" + "window.parent.CKEDITOR.tools.callFunction("
					+ callback + ",'" + fileUrl + "','이미지를 업로드하였습니다.')" + "</script>");

			printWriter.flush();

		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (out != null) {
					out.close();
				}
				if (printWriter != null) {
					printWriter.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		return;
	}

	//////////////////////////////////// QnA컨트롤러////////////////////////////////////////////////////////////////////////////////////////////////
	private BoardService QnAservice;

	@GetMapping("/board/QnA")
	public void list(Criteria cri, Model model) {
		log.info("list : " + cri);
		model.addAttribute("list", QnAservice.getList(cri));
		/* model.addAttribute("pageMaker", new PageDTO(cri, 123)); */
		int total = QnAservice.getTotal(cri);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		// 과거 jsp에서는 request.setAttribut;e로 ArrayList를 전달했지만, 같은

	}

	@GetMapping("/board/register")
	public void QnAregister() {

	}

	@RequestMapping(value = "/board/register", method = RequestMethod.POST)
	public String register(BoardVO board, RedirectAttributes rttr) {
		// @Controller 어노테이션이 붙고,
		// 컴포넌트 스캔에 패키지가 지정되어 있다면,
		// 매개변수 인자들은 스프링이 자동으로 생성 할당 함.
		log.info("register : " + board);
		if (board.getAttachList() != null) {
			board.getAttachList().forEach(attach -> log.info(attach));
		}

		QnAservice.register(board);
		rttr.addFlashAttribute("result", board.getBno());

		// 리다이렉트 시키면서 1회용 값을 전달.
		return "redirect:/admin/board/QnA";
	}

	// 제목 링크를 클릭하여 글 상세보기 - get 방식.
	@GetMapping({ "/board/get", "/board/modify" })
	public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model) {
		// @RequestParam : 요청 전달값으로 글번호 이용.
		log.info("/board/get");
		model.addAttribute("board", QnAservice.get(bno));
		// jsp에서 request.setAttribute 하던 것과 비슷.
		// 전달값으로 명시만 하면 스프링이 자동 처리.
		// 사용하는 부분만 추가 구현.
	}

	// post 요청으로 /modify 가 온다면, 아래 메소드 수행.
	@PostMapping("/board/modify")
	public String modify(BoardVO board, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("modify:" + board);
		if (QnAservice.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}
		// 수정이 성공하면 success 메세지가 포함되어 이동.
		// 실패해도 메세지 빼고 이동.
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());

		return "redirect:/admin/board/QnA";
	}

	@PostMapping("/board/remove")
	public String remove(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("remove..." + bno);

		List<BoardAttachVO> attachList = QnAservice.getAttachList(bno);

		if (QnAservice.remove(bno)) {

			deleteFiles(attachList);
			rttr.addFlashAttribute("result", "success");
		}

		/*
		 * rttr.addAttribute("pageNum", cri.getPageNum()); rttr.addAttribute("amount",
		 * cri.getAmount()); rttr.addAttribute("type", cri.getType());
		 * rttr.addAttribute("keyword", cri.getKeyword());
		 */
		return "redirect:/admin/board/QnA" + cri.getListLink();
	}

	@GetMapping(value = "/board/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno) {
		log.info("getAttachList: " + bno);
		return new ResponseEntity<>(QnAservice.getAttachList(bno), HttpStatus.OK);
	}

	private void deleteFiles(List<BoardAttachVO> attachList) {
		// 게시물당 첨부된 파일을 찾아서 디스크에서 삭제.
		if (attachList == null || attachList.size() == 0) {
			return;
		}

		log.info("delete attach file......");
		log.info(attachList);

		attachList.forEach(attach -> {
			try {
				Path file = Paths.get(
						"c:\\upload\\" + attach.getUploadPath() + "\\" + attach.getUuid() + "_" + attach.getFileName());
				Files.deleteIfExists(file);
			} catch (Exception e) {
				e.printStackTrace();
			}
		});
	}
	////////////////////////// QnA게시판 컨트롤러
	////////////////////////// ////////////////////////////////////////////////////////////////////

	// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	// 주문 목록
	@RequestMapping(value = "/store/orderList", method = RequestMethod.GET)
	public void getOrderList(Model model) throws Exception {
		// logger.info("get order list");

		List<OrderVO> orderList = lservice.orderList();

		model.addAttribute("orderList", orderList);
	}

	// 주문 상세 목록
	@RequestMapping(value = "/store/orderView", method = RequestMethod.GET)
	public void getOrderList(@RequestParam("n") String orderId, OrderVO order, Model model) throws Exception {
		// logger.info("get order view");

		order.setOrderId(orderId);
		List<OrderListVO> orderView = lservice.orderView(order);

		model.addAttribute("orderView", orderView);
	}

	// 주목 상세 목록 - 상태 변경
	@RequestMapping(value = "/store/orderView", method = RequestMethod.POST)
	public String delivery(OrderVO order) throws Exception {
		// logger.info("post order view");

		lservice.delivery(order);

		List<OrderListVO> orderView = lservice.orderView(order);

		StoreVO goods = new StoreVO();
		// log.info("rrrrrrrr" + ((OrderListVO) orderView).getImg());
		for (OrderListVO i : orderView) {
			goods.setProNo(i.getProNo());
			goods.setStock(i.getCartStock());
			lservice.changeStock(goods);
		}

		return "redirect:/admin/store/storeList?n=" + order.getOrderId();
	}
}
