package kr.icia.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.icia.domain.BoardAttachVO;
import kr.icia.domain.BoardVO;
import kr.icia.domain.Criteria;
import kr.icia.domain.PageDTO;
import kr.icia.domain.UserVO;
import kr.icia.service.BoardService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/board/*")
@Controller
@AllArgsConstructor
public class QnAController {

	private BoardService service;
	/*
	 * @RequestMapping("/QnA") public String QnA(Model model) {
	 * 
	 * model.addAttribute("list", service.getList());
	 * 
	 * return "/board/QnA"; }
	 */

	@GetMapping("/QnA")
	public void list(Criteria cri, Model model) {
		log.info("list : " + cri);
		model.addAttribute("list", service.getList(cri));
		/* model.addAttribute("pageMaker", new PageDTO(cri, 123)); */
		int total = service.getTotal(cri);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		// 과거 jsp에서는 request.setAttribut;e로 ArrayList를 전달했지만, 같은

	}

	@GetMapping("/register")
	public void register() {

	}

	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String register(BoardVO board, RedirectAttributes rttr) {
		// @Controller 어노테이션이 붙고,
		// 컴포넌트 스캔에 패키지가 지정되어 있다면,
		// 매개변수 인자들은 스프링이 자동으로 생성 할당 함.
		log.info("register : " + board);
		if (board.getAttachList() != null) {
			board.getAttachList().forEach(attach -> log.info(attach));
		}

		service.register(board);
		rttr.addFlashAttribute("result", board.getBno());

		// 리다이렉트 시키면서 1회용 값을 전달.
		return "redirect:/board/QnA";
	}

	// 제목 링크를 클릭하여 글 상세보기 - get 방식.
	@GetMapping({ "/get", "/modify" })
	public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model) {
		// @RequestParam : 요청 전달값으로 글번호 이용.
		log.info("/get");
		model.addAttribute("board", service.get(bno));
		// jsp에서 request.setAttribute 하던 것과 비슷.
		// 전달값으로 명시만 하면 스프링이 자동 처리.
		// 사용하는 부분만 추가 구현.
	}

	// post 요청으로 /modify 가 온다면, 아래 메소드 수행.
	@PostMapping("/modify")
	public String modify(BoardVO board, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("modify:" + board);
		if (service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}
		// 수정이 성공하면 success 메세지가 포함되어 이동.
		// 실패해도 메세지 빼고 이동.
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());

		return "redirect:/board/QnA";
	}

	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("remove..." + bno);
		
		List<BoardAttachVO> attachList
		= service.getAttachList(bno);

		
		if (service.remove(bno)) {
			
			deleteFiles(attachList);
			rttr.addFlashAttribute("result", "success");
		}

		/*
		 * rttr.addAttribute("pageNum", cri.getPageNum()); rttr.addAttribute("amount",
		 * cri.getAmount()); rttr.addAttribute("type", cri.getType());
		 * rttr.addAttribute("keyword", cri.getKeyword());
		 */
		return "redirect:/board/QnA"+cri.getListLink();
	}

	@GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno) {
		log.info("getAttachList: " + bno);
		return new ResponseEntity<>(service.getAttachList(bno), HttpStatus.OK);
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
						"c:\\upload\\" + attach.getUploadPath() + "\\" + attach.getUuid() + "_" + attach.getFileName());Files.deleteIfExists(file);
			} catch (Exception e) {
				e.printStackTrace();
			}
		});
	}
	
	@RequestMapping(value = "/mypage", method = RequestMethod.GET)
	public void myCommunityPage(Model model,HttpServletRequest httpRequest ,HttpSession session,BoardVO VO) {		
		
		UserVO member = (UserVO)session.getAttribute("member");
		 
		List<BoardVO> user_name =  service.myUserIdCheck(member.getUser_name());
		log.info("mypage:"  + user_name);
		
		model.addAttribute("QnA", user_name);
	
		
		
	}

}// end _class
