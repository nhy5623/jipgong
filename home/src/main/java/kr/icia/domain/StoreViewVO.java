package kr.icia.domain;

import java.util.Date;

import lombok.Data;

@Data
public class StoreViewVO {
	private int proNo;
	private String proName;
	private String cateCode;
	private int price;
	private int stock;
	private String des;
	private String img;
	private String ThumbImg;
	private Date upload_date;
	private String cateCodeRef;
	private String cateName;
	
}
