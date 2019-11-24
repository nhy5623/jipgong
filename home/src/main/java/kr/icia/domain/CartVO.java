package kr.icia.domain;

import java.util.Date;

import lombok.Data;

@Data
public class CartVO {
	private int cartNum;
	private String user_id;
	private int proNo;
	private int cartStock;
	private Date addDate;
		
}
//cartNum     number          not null,
//user_id      varchar2(50)    not null,
//proNo      number          not null,
//stock   number          not null,
//addDate     date            default sysdate,