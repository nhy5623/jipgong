package kr.icia.controller;

import java.io.File;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.icia.domain.CommunityLikeVO;
import kr.icia.domain.CommunityReplyVO;
import kr.icia.domain.CommunityTableVO;
import kr.icia.domain.UserVO;
import kr.icia.domain.myCommunityVO;
import kr.icia.service.CommunityService;
import kr.icia.utils.UploadFileUtils;
import lombok.AllArgsConstructor;

@AllArgsConstructor
@RequestMapping("/community/*")
@Controller
public class CommunityController {

	private CommunityService Coservice;

	@Resource(name = "uploadPath")
	private String uploadPath;

	@RequestMapping("/communityList")
	public String communityList(Model model) {
		
		
		model.addAttribute("communityList", Coservice.getCommunityList());
		
		return "/community/communityList";
	}

	@GetMapping("/registerCommunity")
	public void register() {

	}
	

	

//	관리자 커뮤니티 글쓰기
	@RequestMapping(value = "/registerCommunity", method = RequestMethod.POST)
	public String register(CommunityTableVO community_bno, MultipartFile file)
			throws Exception {

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
		return "redirect:/community/communityList";
	}
	

	
	// 상품 소감(댓글) 작성
	@ResponseBody
	@RequestMapping(value = "/getCommunityViewList/registReply", method = RequestMethod.POST)
	public void registReply(CommunityReplyVO reply, HttpSession session) throws Exception {
		 
	 UserVO member = (UserVO)session.getAttribute("member");
	 reply.setUser_id(member.getUser_id());
	 
	 Coservice.registReply(reply);
	} 
	
	
	

	//커뮤니티 상세 목록	
		@GetMapping({"/getCommunityViewList" })
		public void getCommunityViewList(@RequestParam("community_bno") Long community_bno,
				Model model,HttpServletRequest httpRequest) {
			
			
	        model.addAttribute("CommunityViewList", Coservice.getCommunityViewList(community_bno));
	        model.addAttribute("heart",Coservice.getBoardLike(community_bno));
		}
		
	//좋아요 if문
		 @ResponseBody
		    @RequestMapping(value = "/getCommunityViewList/heart", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
		    public int heart(CommunityLikeVO like,HttpServletRequest httpRequest,HttpSession session,Model model) {

					 	
			 	int heart = Integer.parseInt(httpRequest.getParameter("heart"));
			 	long community_bno = Integer.parseInt(httpRequest.getParameter("community_bno"));
			 	String user_id = ((UserVO) httpRequest.getSession().getAttribute("member")).getUser_id();
		 	
			 	
		        CommunityLikeVO VO = new CommunityLikeVO(); 
		        VO.setCommunity_bno(community_bno);
		        VO.setUser_id(user_id);

		        System.out.println(heart);
		        if(heart >= 1) {
		            Coservice.deleteBoardLike(VO);
		            heart=0;
		        } else {
		            Coservice.createBoardLike(VO);
		            heart=1;
		        }
		        return heart;
				 
		    }	
		
		
		
	
	
	
	
	// 상품 소감(댓글) 목록
	@ResponseBody
	@RequestMapping(value = "/getCommunityViewList/replyList", method = RequestMethod.GET)
	public List<CommunityReplyVO> getReplyList(@RequestParam("community_bno") Long community_bno) throws Exception {
	 
	   
	 List<CommunityReplyVO> reply = Coservice.replyList(community_bno);
	 
	 
	 return reply;
	} 
	
	// 상품 소감(댓글) 삭제
	@ResponseBody
	@RequestMapping(value = "/getCommunityViewList/deleteReply", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public int getReplyList(CommunityReplyVO reply, HttpSession session) throws Exception {
	 
	 int result = 0;
	 UserVO member = (UserVO)session.getAttribute("member");
	 String user_id = Coservice.replyUserIdCheck(reply.getRepNum());
	   
	 if(member.getUser_id().equals(user_id)) {
	  
	  reply.setUser_id(member.getUser_id());
	  Coservice.deleteReply(reply);
	  
	  result = 1;
	 }
	
	 
	 return result; 
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/getCommunityViewList/modifyReply", method = RequestMethod.POST,produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public int modifyReply(CommunityReplyVO reply, HttpSession session) throws Exception {
	 	 
	 int result = 0;
	 
	 UserVO member = (UserVO)session.getAttribute("member");
	 String user_id = Coservice.replyUserIdCheck(reply.getRepNum());
	 
	 if(member.getUser_id().equals(user_id)) {
	  
	  reply.setUser_id(member.getUser_id());
	  Coservice.modifyReply(reply);
	  result = 1;
	 }
	 
	 return result;
	} 
	
	
	
	
	
	
	//커뮤니티 수정창 겟방식(modify)
	@GetMapping("/communityModify")
	public void getCommunityModify(@RequestParam("community_bno") Long community_bno, Model model) {

		
		model.addAttribute("CommunityViewList", Coservice.getCommunityViewList(community_bno));
	}
	
	
	// 커뮤니티 수정 요청(post방식)
	@RequestMapping(value = "/communityModify", method = RequestMethod.POST)
	public String CommunityModify(CommunityTableVO community_bno,MultipartFile file, HttpServletRequest req) throws Exception {
		 // 새로운 파일이 등록되었는지 확인
		 if(file.getOriginalFilename() != null && file.getOriginalFilename() != "") {
		  // 기존 파일을 삭제
		  new File(uploadPath + req.getParameter("gdsImg")).delete();
		  new File(uploadPath + req.getParameter("gdsThumbImg")).delete();
		  
		  // 새로 첨부한 파일을 등록
		  String imgUploadPath = uploadPath + File.separator + "imgUpload";
		  String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		  String fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);
		  
		  community_bno.setGdsImg(File.separator + "imgUpload" + ymdPath + File.separator + fileName);
		  community_bno.setGdsThumbImg(File.separator + "imgUpload" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);
		  
		 } else {  // 새로운 파일이 등록되지 않았다면
		  // 기존 이미지를 그대로 사용
			 community_bno.setGdsImg(req.getParameter("gdsImg"));
			 community_bno.setGdsThumbImg(req.getParameter("gdsThumbImg"));
		  
		 }

	  Coservice.communityModify(community_bno);
	 
	 return "redirect:/community/communityList";
	}
	
	// 상품 삭제
	@RequestMapping(value = "/communityDelete", method = RequestMethod.POST)
	public String postGoodsDelete(@RequestParam("community_bno") Long community_bno,MultipartFile file, HttpServletRequest req) throws Exception {
		
		Coservice.deleteLike(community_bno);
		Coservice.deleteAll(community_bno); // 게시물의 덧글을 삭제하고,
		Coservice.communityDelete(community_bno);
		
	 
	 return "redirect:/community/communityList";
	}
	//마이페이지 커뮤니티 목록 
		@RequestMapping(value = "/getUserCommunityList", method = RequestMethod.GET)
		public void myCommunityPage(Model model,HttpServletRequest httpRequest ,HttpSession session,CommunityTableVO VO) {		
			
			UserVO member = (UserVO)session.getAttribute("member");
			
			List<myCommunityVO> user_id =  Coservice.myUserIdCheck(member.getUser_name());
			
			
			model.addAttribute("communityList",  Coservice.myUserIdCheck(member.getUser_name()));
		
			
			
		}

	
	
	


}// end
