package soft.euclid.intern.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import soft.euclid.intern.ServiceResult;
import soft.euclid.intern.vo.MemberVO;
import soft.euclid.intern.vo.PaginationVO;
import soft.euclid.intern.vo.SearchVO;

public interface IMemberService {

	ServiceResult signup(HttpServletRequest req, MemberVO memberVO);

	MemberVO login(MemberVO memberVO);

	ServiceResult idCheck(String memId);

	List<MemberVO> searchlist(SearchVO<MemberVO> mVO);

	MemberVO myPage(String memId);

	ServiceResult update(HttpServletRequest req, MemberVO memberVO);

	ServiceResult withdraw(String memId);

	ServiceResult delete();

	int memberCnt(PaginationVO<MemberVO> paginationVO);

	List<MemberVO> pageList(PaginationVO<MemberVO> paginationVO);

}
