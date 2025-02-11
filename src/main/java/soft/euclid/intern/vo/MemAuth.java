package soft.euclid.intern.vo;

import lombok.Data;

@Data
public class MemAuth {
	private String memId;
	private String auth;
	
	public MemAuth(String memId, String auth) {
		this.memId = memId;
		this.auth = auth;
	}
}
