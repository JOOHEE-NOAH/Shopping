package com.metanet.shopping.model;

import lombok.Data;

@Data
public class MemberDto {
	 /* 아이디 */
	 private String memberId;
	 /* 비밀번호 */
	 private String memberPw;
	 /* 이름 */
	 private String memberName; 
	 /* 이메일 */
	 private String  memberEmail;
	 /* 우편번호 */
	 private String  address1;
	 /* 주소 */
	 private String  address2;
	 /* 상세주소 */
	 private String  address3;
	 /* 전화번호 */
	 private String  phoneNumber;
	 /* 탈퇴여부 */
	 private int memberStatus;
	 /* 적립금 */
	 private int point; 
	 /* 등록일 */
	 private String regDate;
	 
}
