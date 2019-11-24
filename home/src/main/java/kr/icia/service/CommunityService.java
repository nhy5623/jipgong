package kr.icia.service;

import java.util.List;

import kr.icia.domain.CommunityLikeVO;
import kr.icia.domain.CommunityReplyVO;
import kr.icia.domain.CommunityTableVO;
import kr.icia.domain.myCommunityVO;

public interface CommunityService {
	public List<CommunityTableVO> getCommunityList();

	public void register(CommunityTableVO community_bno);

	public CommunityTableVO getCommunityViewList(Long community_bno);

	public void communityModify(CommunityTableVO community_bno);

	public void communityDelete(Long community_bno);

	void updateViewCnt(Long community_bno);

	// 커뮤니티 소감(댓글) 작성
	public void registReply(CommunityReplyVO reply);

	// 커뮤니티 소감(댓글) 불러오기
	public List<CommunityReplyVO> replyList(Long community_bno);

	// 댓글 삭제
	public void deleteReply(CommunityReplyVO reply);

	// 아이디 체크
	public String replyUserIdCheck(int repNum);

	// 댓글 수정
	public void modifyReply(CommunityReplyVO reply);

	// 커뮤 전체 삭제
	public int deleteAll(Long community_bno);

	//좋아요
	public void createBoardLike(CommunityLikeVO vo);
		
	public int getBoardLike(Long community_bno);
		
	public void deleteBoardLike(CommunityLikeVO vo);
		
	public void updateBoardLike(Long community_bno);
	
	//좋아요 삭제
	public int deleteLike(Long community_bno);
	//마이페이지 커뮤리스트
		public List<myCommunityVO> myUserIdCheck(String user_name);


	
}
