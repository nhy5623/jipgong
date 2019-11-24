package kr.icia.mapper;

import java.util.List;

import kr.icia.domain.CartListVO;
import kr.icia.domain.CartVO;
import kr.icia.domain.CategoryVO;
import kr.icia.domain.Criteria;
import kr.icia.domain.OrderDetailVO;
import kr.icia.domain.OrderListVO;
import kr.icia.domain.OrderVO;
import kr.icia.domain.StoreVO;
import kr.icia.domain.StoreViewVO;

public interface StoreMapper {

	public List<StoreVO> getList();

	public List<StoreVO> getListWithPaging(Criteria cri);
	public List<StoreVO> getTableWithPaging(Criteria cri);

	public List<CategoryVO> category();

	public void insert(StoreVO store);

	// bno 는 시퀀스 자동 생성으로 나머지 값만 입력.
	public void insertSelectKey(StoreVO store);

	// 생성되는 시퀀스 값을 확인하고 나머지 값 입력.
	public StoreViewVO read(Long proNo);

	

	public StoreVO chairRead(String catecode);

	public StoreVO closetRead(String catecode);

	public StoreVO lightRead(String catecode);

	public StoreVO itemRead(String catecode);

	public StoreVO beddingRead(String catecode);

	public int delete(Long proNo);

	public int update(StoreViewVO store);
	
	public int changeStock(StoreVO store);

	public int getTotalCount(Criteria cri);

	// 카트에 담기
	public void addCart(CartVO cart);

	// 카트 리스트 출력
	public List<CartListVO> cartList(String user_id);

	// 카트삭제
	public void deleteCart(CartVO cart);

	// 주문
	public void orderInfo(OrderVO order);

	// 주문상세정보
	public void orderInfo_Details(OrderDetailVO orderDetail);

	// 카트비우기
	public void cartAllDelete(String user_id);

	// 주문목록
	public List<OrderVO> orderList(OrderVO order);

	// 특정 주문목록
	public List<OrderListVO> orderView(OrderVO order);
}
