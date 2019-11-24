package kr.icia.domain;

import java.util.Date;

import lombok.Data;

@Data
public class OrderListVO {
	private String orderId;
	private String user_id;
	private String orderRec;
	private String userAddr1;
	private String userAddr2;
	private String userAddr3;
	private String orderPhon;
	private int amount;
	private Date orderDate;
	
	private int orderDetailsNum;
	private int proNo;
	private int cartStock;
	
	private String proName;
	private String img;
	private int price;
	private String delivery;
}
