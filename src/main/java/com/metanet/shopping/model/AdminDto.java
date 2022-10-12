package com.metanet.shopping.model;

import lombok.Data;

@Data
public class AdminDto {
	/* 아이디 */
	private String adminId;
	/* 비밀번호*/
	private String adminPw;
	/* 이름 */
	private String adminName;
	/* 전화번호 */
	private String aPhoneNumber;

}
