package kr.icia.controller;

import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.icia.domain.CartListVO;
import kr.icia.domain.CartVO;
import kr.icia.domain.Criteria;
import kr.icia.domain.OrderDetailVO;
import kr.icia.domain.OrderListVO;
import kr.icia.domain.OrderVO;
import kr.icia.domain.PageDTO;
import kr.icia.domain.StoreVO;
import kr.icia.domain.UserVO;
import kr.icia.service.StoreService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/store/*")
@AllArgsConstructor
public class StoreController {

	private StoreService service;

	@GetMapping("/storeMain")
	public void getList(Criteria cri, Model model) {
		log.info("list : " + cri);
		model.addAttribute("StoreList", service.getList(cri));
//		model.addAttribute("pageMaker", new PageDTO(cri, 123));
		int total = service.getTotal(cri);
		log.info("total : " + total);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}

	@GetMapping({ "/storeDetail" })
	public void get(@RequestParam("proNo") Long proNo, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr,
			Model model) {
		// @RequestParam : 요청 전달값으로 글번호 이용.
		log.info("get......");
		model.addAttribute("store", service.get(proNo));

		// jsp에서 request.setAttribute 하던 것과 비슷.
		// 전달값으로 명시만 하면 스프링이 자동 처리.
		// 사용하는 부분만 추가 구현.
	}
	@GetMapping("/table")
	public void getTable(Criteria cri, Model model) {
		log.info("list : " + cri);
		model.addAttribute("StoreList", service.getTable(cri));
//		model.addAttribute("pageMaker", new PageDTO(cri, 123));
		int total = service.getTotal(cri);
		log.info("total : " + total);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}


	// 카트 기능@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

	// 카트담기
	@ResponseBody
	@RequestMapping(value = "/addCart", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public int addCart(CartVO cart, HttpSession session) throws Exception {

		int result = 0;

		UserVO member = (UserVO) session.getAttribute("member");
		if (member != null) {
			cart.setUser_id(member.getUser_id());
			service.addCart(cart);
			result = 1;
		}
		return result;
	}

	// 카트 리스트
	@RequestMapping(value = "/cartList", method = RequestMethod.GET)
	public void getCartList(HttpSession session, Model model) throws Exception {

		UserVO member = (UserVO) session.getAttribute("member");
		String user_id = member.getUser_id();

		List<CartListVO> cartList = service.cartList(user_id);

		model.addAttribute("cartList", cartList);

	}

	// 카트 삭제
	@ResponseBody
	@RequestMapping(value = "/deleteCart", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public int deleteCart(HttpSession session, @RequestParam(value = "chbox[]") List<String> chArr, CartVO cart)
			throws Exception {

		UserVO member = (UserVO) session.getAttribute("member");
		String user_id = member.getUser_id();

		int result = 0;
		int cartNum = 0;

		if (member != null) {
			cart.setUser_id(user_id);

			for (String i : chArr) {
				cartNum = Integer.parseInt(i);
				cart.setCartNum(cartNum);
				service.deleteCart(cart);
			}
			result = 1;
		}
		log.info(result);
		return result;

	}

	// 주문
	@RequestMapping(value = "/cartList", method = RequestMethod.POST)
	public String order(HttpSession session, OrderVO order, OrderDetailVO orderDetail) throws Exception {
		log.info("order");

		UserVO member = (UserVO) session.getAttribute("member");
		String user_id = member.getUser_id();

		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		String ym = year + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);
		String ymd = ym + new DecimalFormat("00").format(cal.get(Calendar.DATE));
		String subNum = "";

		for (int i = 1; i <= 6; i++) {
			subNum += (int) (Math.random() * 10);
		}

		String orderId = ymd + "_" + subNum;

		order.setOrderId(orderId);
		order.setUser_id(user_id);

		log.info(order);
		service.orderInfo(order);

		orderDetail.setOrderId(orderId);
		orderDetail.setUser_id(user_id);
		service.orderInfo_Details(orderDetail);

		service.cartAllDelete(user_id);

		return "redirect:/store/orderList";
	}

	// 주문 목록
	@RequestMapping(value = "/orderList", method = RequestMethod.GET)
	public void getOrderList(HttpSession session, OrderVO order, Model model) throws Exception {
		log.info("get order list");

		UserVO member = (UserVO) session.getAttribute("member");
		String user_id = member.getUser_id();

		order.setUser_id(user_id);

		List<OrderVO> orderList = service.orderList(order);

		model.addAttribute("orderList", orderList);
	}

	// 주문 상세 목록
	@RequestMapping(value = "/orderView", method = RequestMethod.GET)
	public void getOrderList(HttpSession session, @RequestParam("n") String orderId, OrderVO order, Model model)
			throws Exception {
//		log.info("get order view");

		UserVO member = (UserVO) session.getAttribute("member");
		String user_id = member.getUser_id();

		order.setUser_id(user_id);
		order.setOrderId(orderId);
		log.info(order);
		List<OrderListVO> orderView = service.orderView(order);
		log.info(orderView);
		model.addAttribute("orderView", orderView);
	}


}// end class
