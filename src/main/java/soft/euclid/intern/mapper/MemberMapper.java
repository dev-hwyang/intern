package soft.euclid.intern.mapper;

import java.util.List;

import soft.euclid.intern.ServiceResult;
import soft.euclid.intern.vo.MemberVO;
import soft.euclid.intern.vo.PaginationVO;
import soft.euclid.intern.vo.SearchVO;

public interface MemberMapper {

	int signup(MemberVO memberVO);

	int insertAuth(MemberVO memberVO);

	MemberVO login(MemberVO memberVO);

	public MemberVO idCheck(String memId);

	List<MemberVO> searchlist(SearchVO<MemberVO> mVO);

	int howManyMember();

	MemberVO myPage(String memId);

	int update(MemberVO memberVO);

	int withdraw(String memId);

	void deleteAuth(String memId);

	int delete(String memId);

	List<MemberVO> selectMember();

	int memberCnt(PaginationVO<MemberVO> paginationVO);

	List<MemberVO> pageList(PaginationVO<MemberVO> paginationVO);

}
