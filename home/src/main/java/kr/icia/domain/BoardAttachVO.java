package kr.icia.domain;

import lombok.Data;

@Data
public class BoardAttachVO {

	private String uuid;
	private String uploadPath;
	private boolean fileType;
	private String fileName;
	private Long bno;
	

}
