package kr.icia.service;

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

public interface StoreService {

	public void register(StoreVO store);

	public StoreViewVO get(Long proNo);
	
	public List<StoreVO> getTable(Criteria cri);
	
	public boolean modify(StoreViewVO store);

	public boolean remove(Long proNo);

	public List<StoreVO> getList(Criteria cri);

	public int getTotal(Criteria cri);

	public List<CategoryVO> category();

	// 카드에 담기
	public void addCart(CartVO cart);

	// 카트 리스트 출력
	public List<CartListVO> cartList(String user_id);

	// 카트삭제
	public void deleteCart(CartVO cart);

	// 주문
	public void orderInfo(OrderVO order);

	// 주문 상세정보
	public void orderInfo_Details(OrderDetailVO orderDetail);

	// 카트비우기
	public void cartAllDelete(String user_id);

	// 주문목록
	public List<OrderVO> orderList(OrderVO order);

	// 특정 주문목록
	public List<OrderListVO> orderView(OrderVO order);
	
	// 상품 수량 조절
	public void changeStock(StoreVO store);
}
