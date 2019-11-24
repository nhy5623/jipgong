package kr.icia.domain;

import java.util.Date;

import lombok.Data;

@Data
public class CartListVO {

	private int cartNum;
	private String user_id;
	private int proNo;
	private int cartStock;
	private Date addDate;
	private int num;
	private String proName;
	private int price;
	private String img;
}
