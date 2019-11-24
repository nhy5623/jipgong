package kr.icia.domain;

import lombok.Data;

@Data
public class OrderDetailVO {

	private int orderDetailsNum;
	private String orderId;
	private int proNo;
	private int cartStock;
	private String user_id;
	
}
