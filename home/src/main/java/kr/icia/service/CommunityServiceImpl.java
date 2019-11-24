package kr.icia.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.icia.domain.CommunityLikeVO;
import kr.icia.domain.CommunityReplyVO;
import kr.icia.domain.CommunityTableVO;
import kr.icia.domain.myCommunityVO;
import kr.icia.mapper.CommunityMapper;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class CommunityServiceImpl implements CommunityService {

	@Setter(onMethod_ = @Autowired)
	private CommunityMapper Comapper;
	

	@Override
	public List<CommunityTableVO> getCommunityList() {
		log.info("getCommunityList......");
		return Comapper.getCommunityList();
	}

	@Override
	public void register(CommunityTableVO community_bno) {
		log.info("register......" + community_bno);
		Comapper.insertSelectKey(community_bno);

	}
	//커뮤 글 상세 불러오기
	@Override
	public CommunityTableVO getCommunityViewList(Long community_bno) {
		Comapper.updateViewCnt(community_bno);		
		return Comapper.getCommunityViewList(community_bno);
	}

	
	

	@Override
	public void communityModify(CommunityTableVO community_bno) {
		Comapper.communityModify(community_bno);

	}

	@Override
	public void communityDelete(Long community_bno) {
		Comapper.communityDelete(community_bno);

	}

	@Override
	public void updateViewCnt(Long community_bno) {

		Comapper.updateViewCnt(community_bno);
	}

	@Override
	public void registReply(CommunityReplyVO reply) {

		Comapper.registReply(reply);
	}

	@Override
	public List<CommunityReplyVO> replyList(Long community_bno) {

		return Comapper.replyList(community_bno);

	}

	// 댓글 삭제
	@Override
	public void deleteReply(CommunityReplyVO reply) {

		Comapper.deleteReply(reply);
	}

	// 아이디 체크
	@Override
	public String replyUserIdCheck(int repNum) {
		return Comapper.replyUserIdCheck(repNum);
	}
	
	//댓글 수정
	@Override
	public void modifyReply(CommunityReplyVO reply) {
		Comapper.modifyReply(reply);
	}
	
	//커뮤니티 댓글까지 삭제
	@Override
	public int deleteAll(Long community_bno) {
		
		return Comapper.deleteAll(community_bno);
	}
	
	
	
	
	
	
	//좋아요 
	@Override
	public void createBoardLike(CommunityLikeVO vo) {
		
		Comapper.createBoardLike(vo);
		updateBoardLike(vo.getCommunity_bno());
	}

	@Override
	public int getBoardLike(Long community_bno) {
		
		return Comapper.getBoardLike(community_bno);
	}

	@Override
	public void deleteBoardLike(CommunityLikeVO vo) {
		Comapper.deleteBoardLike(vo);
		updateBoardLike(vo.getCommunity_bno());
		
	}

	@Override
	public void updateBoardLike(Long community_bno) {
		
		Comapper.updateBoardLike(community_bno);
	}

	@Override
	public int deleteLike(Long community_bno) {
		
		return Comapper.deleteLike(community_bno);
	}
	
	//마이페이지 커뮤리스트
	
		@Override
		public List<myCommunityVO> myUserIdCheck(String user_name) {
			log.info(user_name);
			return Comapper.myUserIdCheck(user_name);
			
		}
		


	

}
