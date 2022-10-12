package com.metanet.shopping.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.metanet.shopping.model.MemberDto;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class MemberMapperTest {
	@Autowired
	private MemberMapper membermapper;
	
//	@Test
//	public void memberJoin() {
//		MemberVo member = new MemberVo();
//		
//		member.setMemberId("test1");
//		member.setMemberPw("test1");
//		member.setMemberName("test1");
//		member.setMemberEmail("test1");
//		member.setAddress1("test1");
//		member.setAddress2("test1");
//		member.setAddress3("test1");
//		member.setPhoneNumber("test1");
//		
//		membermapper.memberJoin(member);
//	}
	
//	@Test
//	public void idCheck() throws Exception{
//		String id = "test1";	// 존재하는 아이디
//		String id2 = "test123";	// 존재하지 않는 아이디
//		membermapper.idCheck(id);
//		membermapper.idCheck(id2);
//	}
	
	@Test
    public void login() throws Exception{
        
        MemberDto member = new MemberDto();    // MemberVO 변수 선언 및 초기화
        
        /* 올바른 아이디 비번 입력경우 */
        member.setMemberId("test1");
        member.setMemberPw("test1");
        
        /* 올바른 않은 아이디 비번 입력경우 */
//        member.setMemberId("test1123");
//        member.setMemberPw("test1321321");
        
        membermapper.login(member);
        System.out.println("결과 값 : " + membermapper.login(member));
        
    }
}
