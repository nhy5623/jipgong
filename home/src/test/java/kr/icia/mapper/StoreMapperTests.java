package kr.icia.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.icia.domain.StoreVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j

public class StoreMapperTests {
	@Setter(onMethod_ = @Autowired)
	private StoreMapper mapper;
//	@Test
//	public void testGetList() {
//	mapper.getList().forEach(Store -> log.info(Store));
//	// 향상된 for : 배열과 배열 1개를 담을 변수
//	// 람다식 : -> 를 기준으로 좌항은 전달값 , 우항은 처리
//	// 목록은 게시물 여러개(배열), 그중 1개를 board 에 담은 다음에
//	// 해당 내용을 로그로 출력. 배열 원소가 끝날때 까지 반복.
//	}
//	 @Test
//	 public void testInsert() {
//	 StoreVO store = new StoreVO();
//	 
//	 store.setProname("새책상");
//	 store.setPrice(15000);
//	 store.setOption1("새로");
//	 store.setOption2("새로");
//	 store.setUpload_year(93);
//	 store.setUpload_month(12);
//	 store.setUpload_day(23);
//	 store.setTotal(50);
//	
//	 mapper.TableInsert(store);
//	 log.info(store);
//	 }
//	 @Test
//	 public void testInsertSelectKey() {
//	 StoreVO store = new StoreVO();
//	 store.setProname("새로 작성하는 글");
//	 store.setPrice(15000);
//	 store.setOption1("새로운 작성자");
//	 store.setOption2("새로운 작성자");
//	 store.setUpload_year(93);
//	 store.setUpload_month(12);
//	 store.setUpload_day(23);
//	 store.setTotal(50);
//	 mapper.TableInsertSelectKey(store);
//	 log.info(store);
//	 }
	 @Test
	 public void testDelete() {
	 log.info("delete cnt: "+mapper.delete(1000002L));
	 }
//	 @Test
//	 public void testRead() {
//	 StoreVO store = mapper.read(1000002L);
//	 // L 은 bno 가 long 타입이라는 것을 알림.
//	
//	 log.info(store);
//	 }
}
