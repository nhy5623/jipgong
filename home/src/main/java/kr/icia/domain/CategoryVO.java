package kr.icia.domain;

import lombok.Data;

@Data
public class CategoryVO {
//	catename varchar2(20) not null,
//	catecode varchar2(30) not null,
//	catecoderef varchar2(30) null,
	private String cateName;
	private String cateCode;
	private String cateCodeRef;
	private int level;
}
