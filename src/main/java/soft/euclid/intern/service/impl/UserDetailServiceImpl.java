package soft.euclid.intern.service.impl;

import javax.inject.Inject;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import lombok.extern.slf4j.Slf4j;
import soft.euclid.intern.mapper.BoardMapper;
import soft.euclid.intern.mapper.MemberMapper;
import soft.euclid.intern.vo.MemberVO;
import soft.euclid.intern.vo.UserMember;

@Slf4j
public class UserDetailServiceImpl implements UserDetailsService {

	@Inject
	private BoardMapper mapper;
	
	public UserDetailServiceImpl (BoardMapper mapper) {
		this.mapper = mapper;
	}
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
//		log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@ loadUserByUsername 실행입니당");
		MemberVO vo;
		try {	
			vo = mapper.readByUserId(username);
//			log.info("#################### vo 가 안나와여 왜..? 이제 나와요 -> " + vo);
//			log.info("#################### userName -> " + username);
			return vo == null ? null : (UserDetails) new UserMember(vo);
			//캐스팅을 안하면 어떻게 되는지..?
			//오류남 ㅎㅎ... 당연한얘기지만..
			//vo가 null일때 null을 반환, null이  아니면 새 userMember를 반환
		} catch (Exception e) {
			e.printStackTrace();
//			log.info("#################### loadUserByUsername 오류!");
		}
		
		return null;
		
	}

}
