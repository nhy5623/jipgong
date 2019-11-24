package kr.icia.domain;

import java.util.Date;

import lombok.Data;

@Data
public class UserVO {

	private String user_id;
	private String user_pw;
	private String user_name;
	private String user_birth;
	private String user_email;
	private String user_phone;
	private String addr1;
	private String addr2;
	private String addr3;
	private Date regdate;
	private Date updatedate;
	private int verify;
	private boolean enabled;

}
