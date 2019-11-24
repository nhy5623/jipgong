package kr.icia.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.icia.domain.CartListVO;
import kr.icia.domain.CartVO;
import kr.icia.domain.CategoryVO;
import kr.icia.domain.Criteria;
import kr.icia.domain.OrderDetailVO;
import kr.icia.domain.OrderListVO;
import kr.icia.domain.OrderVO;
import kr.icia.domain.StoreVO;
import kr.icia.domain.StoreViewVO;
import kr.icia.mapper.StoreMapper;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class StoreServiceImpl implements StoreService {
	@Setter(onMethod_ = @Autowired)
	private StoreMapper mapper;
	
	@Override
	public List<StoreVO> getList(Criteria cri) {
		log.info("getList......");
		return mapper.getListWithPaging(cri);
	}
	@Override
	public List<CategoryVO> category(){
		log.info("categoryservice.........");
		return mapper.category();
	}
	@Override
	public void register(StoreVO store) {
		log.info("register......" + store);
		mapper.insertSelectKey(store);
	}

	@Override
	public StoreViewVO get(Long prono) {
		log.info("get......" + prono);
		return mapper.read(prono);

	}

	@Override
	public boolean modify(StoreViewVO store) {
		log.info("modify......" + store);
		return mapper.update(store) == 1;

	}
	@Override
	public void changeStock(StoreVO store) {
		log.info("modify......" + store);
		mapper.changeStock(store);
		
	}

	@Override
	public boolean remove(Long proNo) {
		log.info("remove......" + proNo);
		return (mapper.delete(proNo)) == 1;
	}



	@Override
	public int getTotal(Criteria cri) {
		log.info("get total count");
		return mapper.getTotalCount(cri);
	}
	//카트에 담기	
		@Override
		public void addCart(CartVO cart) {
			mapper.addCart(cart);
			
		}
		
		@Override
		public List<CartListVO> cartList(String user_id) {
			
			return mapper.cartList(user_id);
		}

		@Override
		public void deleteCart(CartVO cart) {
			mapper.deleteCart(cart);
			
		}
		@Override
		public void orderInfo(OrderVO order) {
			mapper.orderInfo(order);
			
		}

		@Override
		public void orderInfo_Details(OrderDetailVO orderDetail) {
			mapper.orderInfo_Details(orderDetail);
			
		}

		@Override
		public void cartAllDelete(String user_id) {
			mapper.cartAllDelete(user_id);
			
		}

		@Override
		public List<OrderVO> orderList(OrderVO order) {
			
			return mapper.orderList(order);
		}

		@Override
		public List<OrderListVO> orderView(OrderVO order) {
			
			return mapper.orderView(order);
		}
		@Override
		public List<StoreVO> getTable(Criteria cri) {
			log.info(cri);
			return mapper.getTableWithPaging(cri);
		}
		

}
