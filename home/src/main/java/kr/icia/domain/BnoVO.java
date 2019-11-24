package kr.icia.domain;

import java.util.Date;

import lombok.Data;

@Data
public class BnoVO {

	private String username;
	private String userid;
	private String userpw;
	private String address;
	private String email;
	private Date joindate;
	private String gender;

}
