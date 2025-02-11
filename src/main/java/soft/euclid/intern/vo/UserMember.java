package soft.euclid.intern.vo;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class UserMember extends User {
	
	private MemberVO vo;
	
	public UserMember(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
//		log.info("멤아이디ㅣㅣㅣㅣ -> " + vo.getMemId() + "비밀번호?? -> " + vo.getMemPassword() + "권한 리스트으으으으 -> " + vo.getAuthList());
	}
	
	public UserMember(MemberVO vo) {
		
		//map : 컬렉션(List, Map, Set 등) 배열 등에 설정되어있는 각 타입의 값들을 하나씩 참조하여 람다식으로 반복처리 할 수 있게 해준다.
		//collect : Stream()을 돌려 발생하는 데이터를 가공처리 하고, 원하는 형태의 자료형으로 변환을 돕는다.
		super(vo.getMemId(), vo.getMemPassword(), convertAuthList(vo).stream().map(auth -> new SimpleGrantedAuthority(auth.getAuth())).collect(Collectors.toList()));
		//람다 표현식에는 전처리와 후처리가 존재한다.
		//전처리에 해당하는 로직 -> .map이 컬렉션데이터를 활용하고
		//후처리에 해당하는 로직 -> .collect가 돌아 마지막으로 데이터를 가공 처리 후 마무리 되어야 하는 데이터 타입으로 변환을 마무리한다.
		
		//User를 extends 해서 요구되는 파라미터가 String 아이디, String 비밀번호, Collection 타입이라 컬렉션 타입으로 지정을 해준 것.
		//super 위에 쓰려니까 super 위로는 아무것도 없어야 한다고 해서 그 전에 위에 선언했던 authList를 아래에서 함수로 선언해주고, 위에서는 함수 명만 지정해준 것.
		//선언해준 자리가 컬렉션이다 보니 리스트 형식이어야하는데 그래서 아래에 아이디, 권한을 넣어준 것. 
		
		this.vo = vo;
	}
	
	private static List<MemAuth> convertAuthList(MemberVO vo) {
		
		List<MemAuth> authList = new ArrayList<MemAuth>();
		
		authList.add(new MemAuth(vo.getMemId(), vo.getAuth()));
		
		return authList;
	}
	
	public MemberVO getVo() {
		return vo;
	}
	
	public void setVo(MemberVO vo) {
		this.vo = vo;
	}
}
