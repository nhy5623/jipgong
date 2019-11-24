package kr.icia.domain;

import java.util.Date;

import lombok.Data;

@Data
public class CommunityReplyVO {
	private Long community_bno;
	private String user_id;
	private int repNum;
	private String repCon;
	private Date repDate;
	
	private String user_name;
}
