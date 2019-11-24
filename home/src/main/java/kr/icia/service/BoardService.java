package kr.icia.service;

import java.util.List;

import kr.icia.domain.BoardAttachVO;
import kr.icia.domain.BoardVO;
import kr.icia.domain.Criteria;

public interface BoardService {
	
	public void register(BoardVO board);
	
	public BoardVO get(Long bno);
	
	public boolean modify(BoardVO board);
	
	public boolean remove(Long bno);
	
	public List<BoardVO> getList();
	
	public List<BoardVO> getList(Criteria cri);
	
	public int getTotal(Criteria cri);

	public List<BoardAttachVO> getAttachList(Long bno);
	// 게시물의 정보를 가지고 오면서, 첨부파일의 정보도 포함.
	
	public List<BoardVO> myUserIdCheck(String user_name);
	//마이페이지 아이디 비교	
}
