package soft.euclid.intern.service.impl;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;
import soft.euclid.intern.ServiceResult;
import soft.euclid.intern.mapper.MemberMapper;
import soft.euclid.intern.service.IMemberService;
import soft.euclid.intern.vo.MemberVO;
import soft.euclid.intern.vo.PaginationVO;
import soft.euclid.intern.vo.SearchVO;

@Slf4j
@Repository
public class MemberServiceImpl implements IMemberService {

	@Inject
	private MemberMapper mapper;

	/**
	 * 회원가입 서비스
	 */
	@Override
	public ServiceResult signup(HttpServletRequest req, MemberVO memberVO) {
		
		ServiceResult res  = null;
		
		String memPassword = memberVO.getMemPassword();
		
		BCryptPasswordEncoder pe = new BCryptPasswordEncoder();
		
		String secPw = pe.encode(memPassword);
		
		log.info(memPassword + "<- 입력받은 \n 암호화된 ->" + secPw);
		
		memberVO.setMemPassword(secPw);
		if(memberVO.getMemAgr() == null) {
			memberVO.setMemAgr("N");
		}
		
		int status = mapper.signup(memberVO);
		
		if(status > 0) {
			res = ServiceResult.OK;
		}else {
			res = ServiceResult.FAILED;
		}
//		log.info(status + " 상태 ");
		
		mapper.insertAuth(memberVO);
		
		return res;
	}

	/**
	 * 로그인 서비스
	 */
	@Override
	public MemberVO login(MemberVO memberVO) {
		return mapper.login(memberVO);
	}

	/**
	 * 아이디 중복확인 체크용 서비스
	 */
	@Override
	public ServiceResult idCheck(String memId) {
		ServiceResult res = null;
		
		MemberVO vo = mapper.idCheck(memId);
		
		if(vo != null) {
			res = ServiceResult.EXIST;
		}else {
			res = ServiceResult.NOTEXIST;
		}
		return res;
	}

	/**
	 * 검색된 회원 목록
	 */
	@Override
	public List<MemberVO> searchlist(SearchVO<MemberVO> mVO) {
		return mapper.searchlist(mVO);
	}

	/**
	 * 마이페이지
	 */
	@Override
	public MemberVO myPage(String memId) {
		return mapper.myPage(memId);
	}

	/**
	 * 회원 정보수정 서비스
	 */
	@Override
	public ServiceResult update(HttpServletRequest req, MemberVO memberVO) {
		
		ServiceResult res  = null;
		
		String memPassword = memberVO.getMemPassword();
		
		BCryptPasswordEncoder pe = new BCryptPasswordEncoder();
		
		String secPw = pe.encode(memPassword);
		
		log.info(memPassword + "<- 입력받은 \n 암호화된 ->" + secPw);
		
		memberVO.setMemPassword(secPw);
		
		int status = mapper.update(memberVO);
		
		if(status > 0) {
			res = ServiceResult.OK;
		}else {
			res = ServiceResult.FAILED;
		}
		
		return res;
	}

	/**
	 * 회원 탈퇴 신청 서비스
	 */
	@Override
	public ServiceResult withdraw(String memId) {
		ServiceResult res = null;

		int stat = mapper.withdraw(memId);
		if (stat > 0) {
			res = ServiceResult.OK;
		}else {
			res = ServiceResult.FAILED;
		}
		
		return res;
	}

	/**
	 * 7일 후 실제로 탈퇴와 회원권한 삭제가 이루어지는 서비스 (배치스케쥴러 실행)
	 */
	@Override
	public ServiceResult delete() {
		
		ServiceResult res  = null;
		int status = 0;
		
		List<MemberVO> memberVO = mapper.selectMember();
//		log.info("배치! 멤버브이오 리스트 : " + memberVO);
		for(MemberVO vo : memberVO) {
//			log.info("배치! 포문안에있는 그냥브이오 (하나씩 돌아가는거 : " + vo);
			mapper.deleteAuth(vo.getMemId());
//			log.info("배치! 포문안에있는 deleteAuth(vo.getMemId() : " + vo);
			status = mapper.delete(vo.getMemId());
//			log.info("배치! 포문안에있는 delete(vo.getMemId() : " + vo);
		}
		
		if(status > 0) {
			res = ServiceResult.OK;
		}else {
			res = ServiceResult.FAILED;
		}
		
		return res;
	}

	/**
	 * 검색된 회원 수
	 */
	@Override
	public int memberCnt(PaginationVO<MemberVO> paginationVO) {
		return mapper.memberCnt(paginationVO);
	}

	/**
	 * 전체조회에 담긴 회원목록
	 */
	@Override
	public List<MemberVO> pageList(PaginationVO<MemberVO> paginationVO) {
		return mapper.pageList(paginationVO);
	}

}
