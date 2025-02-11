package soft.euclid.intern.controller.security;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.slf4j.Slf4j;
import soft.euclid.intern.ServiceResult;
import soft.euclid.intern.service.IMemberService;
import soft.euclid.intern.vo.MemberVO;
import soft.euclid.intern.vo.PaginationVO;
import soft.euclid.intern.vo.SearchVO;
import soft.euclid.intern.vo.UserMember;

/**
 * @author user
 *
 */
@Controller
@Slf4j
public class LoginController {
	
	@Inject
	BCryptPasswordEncoder pe;
	
	@Inject
	private IMemberService service;
	
	/**
	 * 로그인 컨트롤러 (get방식)
	 * 
	 * @param model
	 * @param error
	 * @param logout
	 * @return
	 */
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(Model model, String error, String logout) {
		
		model.addAttribute("error", error);
		model.addAttribute("logout", logout);
		
		return "login";
	}
	
	/**
	 * 로그인 컨트롤러 (post방식)
	 * 
	 * @param memberVO
	 * @param ra
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String logIn(MemberVO memberVO, RedirectAttributes ra, Model model) {
		
//		log.info("\n 멤버password얌...." + memberVO.getMemPassword());
		
		BCryptPasswordEncoder pe = new BCryptPasswordEncoder();
		  
		String rawPassword = memberVO.getMemPassword();
		 
		memberVO.setMemPassword(pe.encode(rawPassword));
		String page = "";
		
//		log.info("\n 멤버VO얌...." + memberVO);
		MemberVO vo = service.login(memberVO);
		
//		log.info("\n 멤버VO얌...." + memberVO + "\n 그리구 그냥 vo..." + vo);
		
		if(vo != null) {
			page = "redirect:/intern/list";
		} else {
			page = "login";
		}
		
		return page;
	}
	
	/**
	 * 로그아웃 컨트롤러
	 * 
	 * @param model
	 * @param req
	 * @return
	 */
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(Model model, HttpServletRequest req) {
		
		return "redirect:/intern/list";
	}
	
	/**
	 * 로그인 에러시에 작동되는 컨트롤러
	 * 
	 * @param model
	 * @param req
	 * @return
	 */
	@RequestMapping(value = "/error", method = RequestMethod.GET)
	public String error(Model model, HttpServletRequest req) {
		
		return "error";
	}
	
	/**
	 * 회원가입 컨트롤러)
	 * 
	 * @param model
	 * @param req
	 * @return
	 */
	@RequestMapping(value = "/signup", method = RequestMethod.GET)
	public String signup(Model model, HttpServletRequest req) {
		
		return "signup";
	}
	
	/**
	 * 회원가입 컨트롤러 (get방식)
	 * 
	 * @param model
	 * @param req
	 * @param ra
	 * @param memberVO
	 * @return
	 */
	@RequestMapping(value = "/signup", method = RequestMethod.POST)
	public String signUp(Model model, HttpServletRequest req, RedirectAttributes ra, MemberVO memberVO) {
		
		log.info("signup POST 방식 : 이야야양나아아아앙 -> " + memberVO);
		
		ServiceResult res = service.signup(req, memberVO);
		
		String page = "";
				
		if(res.equals(ServiceResult.OK)) {
			page = "redirect:/intern/list";
		} else {
			page = "redirect:/intern/cheers";
		}
		
		return page;
	}
	
	/**
	 * 회원가입시 아이디 중복 체크 여부 컨트롤러
	 * 
	 * @param map
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/idCheck", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
	public ResponseEntity<ServiceResult> idCheck(@RequestBody Map<String, String> map) {
		
		String memId = map.get("memId").toString();
//		log.info("넘어온 아이디: " +  memId);
		ServiceResult res =  service.idCheck(memId);
		
		return new ResponseEntity<ServiceResult> (res, HttpStatus.OK);
	}
	
	/**
	 *  관리자로 로그인 했을 때에 접근가능한 회원 조회 화면
	 *  
	 * @param model
	 * @param req
	 * @param searchType
	 * @param searchWord
	 * @return
	 */
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@RequestMapping(value = "/memberListForAdmin", method = RequestMethod.GET)
	public String memberListForAdmin(Model model, HttpServletRequest req, @RequestParam(required = false, defaultValue = "1", name = "currentPage") int currentPage, @RequestParam(required = false, defaultValue = "name") String searchType, @RequestParam(required = false) String searchWord) {
		
		MemberVO vo = new MemberVO();
		PaginationVO<MemberVO> paginationVO = new PaginationVO<MemberVO>();
		
		if(StringUtils.isNotBlank(searchWord)) {
			paginationVO.setSearchType(searchType);
			paginationVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
//			log.info(searchWord + " #### " + searchType);
			
		}
		
		paginationVO.setCurrentPage(currentPage);
		if (currentPage > 1) {
			paginationVO.setCurrentPage(currentPage);
		}
//		log.info("paginationVO.currentPage : " + paginationVO.currentPage);
		
		int cnt = service.memberCnt(paginationVO);
		paginationVO.setTotalRecord(cnt);
		
		List<MemberVO> pageList = service.pageList(paginationVO);
		paginationVO.setList(pageList);
		
		model.addAttribute("paginationVO", paginationVO);
		model.addAttribute("list", pageList);
//		log.info(" paginationVO.list = pageList" + paginationVO.list);
//		log.info(" paginationVO " + paginationVO);
//		log.info(" #### .html " + paginationVO.getHtml());
		
		
		return "memberListForAdmin";
	}
	
	/**
	 * memId가 로그인한 아이디와 다를 때의 마이페이지
	 * 
	 * @param model
	 * @param req
	 * @param memId
	 * @return
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@RequestMapping(value = "/myPage", method = RequestMethod.GET)
	public String myPage(Model model, HttpServletRequest req, String memId) {
		
		UserMember user = (UserMember)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		MemberVO vo = service.myPage(memId);
		
		if(vo.getMemId().equals(user.getUsername())) {
			model.addAttribute("status", "me");
		}
		
		model.addAttribute("vo", vo);
		
		return "myPage";
	}
	
	/**
	 * memId가 로그인한 아이디와 동일할 때의 마이페이지
	 * 
	 * @param model
	 * @param req
	 * @return
	 */
	@RequestMapping(value = "/intern/myPage", method = RequestMethod.GET)
	public String myPage(Model model, HttpServletRequest req) {
		
		UserMember user = (UserMember)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		String memId = user.getUsername();
		
		MemberVO vo = service.myPage(memId);
		
		if(vo.getMemId().equals(user.getUsername())) {
			model.addAttribute("status", "me");
		}
		
		model.addAttribute("vo", vo);
		
		return "myPage";
	}
	
	/**
	 * 회원정보 수정하는 컨트롤러
	 * 
	 * @param model
	 * @param req
	 * @param ra
	 * @param memberVO
	 * @return
	 */
	@RequestMapping(value = "/intern/modifyMember", method = RequestMethod.POST)
	public String modify(Model model, HttpServletRequest req, RedirectAttributes ra, MemberVO memberVO) {
		
		UserMember user = (UserMember)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
//		log.info("수정시넘어온 VO" + memberVO);
		String memId = user.getUsername();
		memberVO.setMemId(memId);
//		
		ServiceResult res = service.update(req, memberVO);
		
		return "redirect:/intern/myPage";
	}
	
	/**
	 * 회원 탈퇴신청 컨트롤러
	 * 
	 * @param model
	 * @param memId
	 * @return
	 */
	@RequestMapping(value = "/intern/withdrawMember", method = RequestMethod.POST)
	public String withdrawMember(Model model, String memId) {
		
		UserMember user = (UserMember)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		memId = user.getUsername();
		
//		log.info("아이디이이이이 : " + memId);
//		Date time = new Date();
//		log.info("배치 아님 탈퇴시간임 지금이야" + time);
		
		ServiceResult res = service.withdraw(memId);
		
		return "redirect:/intern/myPage";
	}
	
	/**
	 * 매일 도는 스케쥴러 (탈퇴 신청일로부터 7일이 지난 회원들은 모두 삭제한다.
	 * 
	 */
	@Scheduled(cron = "0 0 0 * * *")	//초 분 시 일 월 요일
	@RequestMapping(value = "/intern/deleteMember", method = RequestMethod.POST)
	public void deleteMember() {
		
		ServiceResult res = service.delete();
		
//		Date time = new Date();
//		log.info("삭제스케쥴러가 실행된시간! 지금이야" + time);
	}
	
}
