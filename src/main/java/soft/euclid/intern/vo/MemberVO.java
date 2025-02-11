package soft.euclid.intern.vo;

import lombok.Data;

@Data
public class MemberVO {
	
	/* member 칼럼 */
	public String memId;
	public String memName;
	public String memPassword;
	public String memReg1;
	public String memEmail;
	public String memTel;
	public String memAddr;
	public String memAgr;
	public String memWd;
	public String memWdDate;
	public String auth;	//멤버 권한

}
