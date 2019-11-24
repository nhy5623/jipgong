package kr.icia.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {
	private int pageNum; // 현재 페이지 번호.
	private int amount; // 페이지당 게시물수

	private String type;
	private String keyword;

	public Criteria() {
		this(1, 10); // 아래쪽 전달값 2개 생성자 호출.
	}

	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}

	public String[] getTypeArr() {
		return type == null ? new String[] {} : type.split("");
	}

	public String getListLink() {
		UriComponentsBuilder builder
		=UriComponentsBuilder.fromPath("")
		.queryParam("pageNum", this.pageNum)
		.queryParam("amount", this.getAmount())
		.queryParam("type", this.getType())
		.queryParam("keyword", this.getKeyword());
		return builder.toUriString();
		// 기존의 get 방식으로 전달하던 page,amount,type,keyword
		// 즉, 현재 페이지, 페이지당 게시물수, 검색타입, 검색어
		// 를 주소창에 get 방식으로 붙여서 보냈는데,
		// 일일이 값을 호출해서 처리하는 것이 아니라,
		// getListLink 메소드에 한꺼번에 처리하도록 변경.
	
	}
}