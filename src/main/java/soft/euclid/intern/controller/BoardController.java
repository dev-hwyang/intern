package soft.euclid.intern.controller;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.security.Principal;
import org.springframework.security.core.context.SecurityContextHolder;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.slf4j.Slf4j;
import soft.euclid.intern.MediaUtils;
import soft.euclid.intern.ServiceResult;
import soft.euclid.intern.service.IBoardService;
import soft.euclid.intern.vo.BoardVO;
import soft.euclid.intern.vo.CommentVO;
import soft.euclid.intern.vo.FileVO;
import soft.euclid.intern.vo.SearchVO;
import soft.euclid.intern.vo.UserMember;

@MultipartConfig
@Controller
@Slf4j
@RequestMapping(value = "/intern")
public class BoardController {

	@Inject
	private IBoardService bService;
	
	/**
	 * 게시글 전체를 불러오는 컨트롤러
	 * (검색단어가 빈칸이면 전체조회, 비어있지 않으면 검색단어 넣어서 조회) 
	 * 
	 * @param model
	 * @param req
	 * @param searchType
	 * @param searchWord
	 * @return
	 */
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String boardList(Model model, HttpServletRequest req, @RequestParam(required = false, defaultValue = "title") String searchType, @RequestParam(required = false) String searchWord) {
		
		BoardVO vo = new BoardVO();
		SearchVO<BoardVO> sVO = new SearchVO<BoardVO>();
		
		if(StringUtils.isNotBlank(searchWord)) {
			sVO.setSearchType(searchType);
			sVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
//			log.info(searchWord + " #### " + searchType);
			sVO.setSearchType(searchType);
			sVO.setSearchWord(searchWord);
			
		}
		
		List<BoardVO> list = bService.searchlist(sVO);
		sVO.setSearhList(list);
		
		model.addAttribute("list", list);
		
		
		return "MyHome";
	}
	
	/**
	 * 내가 작성한 게시글 조회하는 컨트롤러
	 * (검색단어가 빈칸이면 전체조회, 비어있지 않으면 검색단어 넣어서 조회) 
	 * 
	 * @param model
	 * @param req
	 * @param searchWord
	 * @return
	 */
	@RequestMapping(value = "/myList", method = RequestMethod.GET)
	public String myList(Model model, HttpServletRequest req, @RequestParam(required = false) String searchWord) {
		
		UserMember user = (UserMember)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String memId = user.getUsername();
		
		BoardVO vo = new BoardVO();
		SearchVO<BoardVO> sVO = new SearchVO<BoardVO>();
		
		if(StringUtils.isNotBlank(searchWord)) {
			String searchType = "title";
			sVO.setSearchType(searchType);
			sVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
//			log.info(searchWord + " #### " + searchType);
			sVO.setSearchType(searchType);
			sVO.setSearchWord(searchWord);
			
		}
		sVO.setMemId(memId);
//		log.info("내리스트 memId" + memId);
		List<BoardVO> list = bService.mylist(sVO);
		sVO.setSearhList(list);
//		log.info("내리스트 list" + list);
		
		model.addAttribute("list", list);
		
		
		return "MyList";
	}
	
	/**
	 * 게시물 등록 컨트롤러 (get방식)
	 * 
	 * @param principal
	 * @param model
	 * @param req
	 * @return
	 */
	@RequestMapping(value = "/register", method = RequestMethod.GET) public String boardRegister(Principal principal, Model model, HttpServletRequest req) {
		String user = principal.getName();
		
		model.addAttribute("user", user);
		
		return "register";
	}
	
	/**
	 * 게시물 등록 컨트롤러 (post방식)
	 * 
	 * @param principal
	 * @param model
	 * @param req
	 * @param ra
	 * @param boardVO
	 * @return
	 */
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String register(Principal principal, Model model, HttpServletRequest req, RedirectAttributes ra, BoardVO boardVO) {
		
//		log.info("레지스터 컨트롤러어");
		
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		String user = principal.getName();
		//principal을 넣고, 이렇게 해주는 방법이 있고
		//UserMember user = (UserMember)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		//를 사용하는 방법이 있다.
		boardVO.setMemId(user);
		boardVO.setBoTitle(title);
		boardVO.setBoContent(content);
		ServiceResult res = bService.register(req, boardVO);
//		log.info("보드프이오오오오" + boardVO);
		
		return "redirect:/intern/list";
	}
	
	/**
	 * 파라미터에 해당하는 게시글을 조회하는 컨트롤러
	 * 
	 * @param model
	 * @param boNo
	 * @return
	 */
	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	public String boardDetail(Model model, int boNo) {
		
//		log.info("보노 -> " + boNo);
//		FileVO  fileVO = new FileVO();
//		fileVO.setBoNo(boNo);
//		log.info("보노 -> " + fileVO);
	
		BoardVO boardVO = bService.select(boNo);
		
//		log.info("그뭐지 그 첨부파일 리스트 -> " + fileVO);
//		log.info("그뭐지 그 첨부파일 리스트 -> " + boardVO);
//		log.info("그뭐지 그 첨부파일 리스트 -> " + boardVO.fileList);
		
		UserMember user = (UserMember)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if(boardVO.getMemId().equals(user.getUsername())) {
			model.addAttribute("status", "me");
		}
		
//		for (CommentVO cVO : boardVO.commentList) {
//			log.info("댓글 글쓴이다 임마ㅏㅏㅏㅏ 제발.. -> " + cVO.getMemId());
//			log.info("여기는 게시판 글쓴이다 임마ㅏㅏㅏㅏ 제발.. -> " + boardVO.getMemId());
//			model.addAttribute("commentWriter", cVO.getMemId().equals(boardVO.getMemId()));
//			if(cVO.getMemId().equals(boardVO.getMemId())) {
//			}
//		}
		
		model.addAttribute("boardVO" , boardVO);
		model.addAttribute("file", boardVO.fileList);
		model.addAttribute("comment", boardVO.commentList);
		model.addAttribute("commentWriter", boardVO.getMemId());
		model.addAttribute("user", user.getUsername());
		
		return "detail";
	}
	
	/**
	 * 게시글에 등록된 첨부파일을 다운로드 하는 컨트롤러
	 * 
	 * @param fileNo
	 * @return
	 */
	@RequestMapping(value = "/download", method = RequestMethod.GET)
	public ResponseEntity<byte[]> boardFileDownload(int fileNo) {
		//ResponseEntity<byte[]> (@null T body, headers, status) 셋 다 널 가능
		
//		log.info("나눈 다운로드 " + fileNo);
		//다운로드에서의 핵심은 octet_stream (내 생각)
		
		InputStream in = null;
		ResponseEntity<byte[]> entity = null;
		
		String fileName = null;
		FileVO fileVO = bService.fileDownload(fileNo);
//		log.info("fileVO에는 뭐가 담기나용 다 담기나용?" + fileVO);
		
		fileName = fileVO.getFileOriginname();
//		log.info("fileOriginname에는 뭐가 담기나용 다 담기나용?" + fileName);
		
		String formatType = fileName.substring(fileName.lastIndexOf(".") + 1);
//		log.info("formatType에는 뭐가 담기나용 다 담기나용?" + formatType);
//		MediaType mediaType = MediaUtils.getMediaType(formatType);
	 	
		HttpHeaders header = new HttpHeaders();
		//header를 왜 만들어야 하는지..? 아래 new 리스폰스엔티티에 담아야해서..?
		//아 octet스트림 거기에 담아야 하는구나 다운받을이름도 이걸로 정해 주는거 오키오키
		
		try {
			in = new FileInputStream(fileVO.getFilePath());
//			log.info("in 성공");
			
			fileName = fileName.substring(fileName.indexOf("___") + 1);
//			log.info("fileOriginname 성공");
			
			header.setContentType(MediaType.APPLICATION_OCTET_STREAM);
//			log.info("헤더 셋 성공");
			header.add("Content-Disposition", "attachment; filename=\"" + new String(fileName.getBytes("UTF-8"), "ISO-8859-1") + "\"");
//			log.info("헤더 에드 성공");
			
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), header, HttpStatus.CREATED);
			//근데 여기선 왜 created가 되야하는건지..?
//			log.info("엔티티 뉴생성");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				in.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		return entity;
	}
	
	/**
	 * 파라미터에 해당하는 게시글을 수정하는 컨트롤러 (get방식)
	 * 
	 * @param model
	 * @param boNo
	 * @return
	 */
	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public String boardUpdate(Model model, int boNo) {
		
		BoardVO boardVO = bService.select(boNo);
		model.addAttribute("boardVO", boardVO);
		model.addAttribute("file", boardVO.fileList);
		
		return "update";
	}
	
	/**
	 * 파라미터에 해당하는 게시글을 수정하는 컨트롤러 (post방식)
	 * 
	 * @param model
	 * @param req
	 * @param ra
	 * @param boardVO
	 * @return
	 */
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(Model model, HttpServletRequest req, RedirectAttributes ra, BoardVO boardVO) {
		
		String bono = req.getParameter("boNo");
		int boNo = Integer.parseInt(bono);
		
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		
		boardVO.setBoNo(boNo);
		boardVO.setBoTitle(title);
		boardVO.setBoContent(content);
		
		ServiceResult res = bService.update(req, boardVO);
		
		return "redirect:/intern/detail?boNo="+boNo;
	}
	
	/**
	 * 파라미터에 해당하는 게시글을 삭제하는 컨트롤러
	 * 
	 * @param model
	 * @param boNo
	 * @return
	 */
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public String delete(Model model, int boNo) {

		ServiceResult res =  bService.delete(boNo);
		
		return "redirect:/intern/list";
	}
	
	/**
	 * 댓글 등록 컨트롤러
	 * 
	 * @param map
	 * @param req
	 * @param commentVO
	 * @return
	 */
	@RequestMapping(value = "/registerComment", method = RequestMethod.POST)
	public ResponseEntity<ServiceResult> registerComment(@RequestBody Map<String, String> map, HttpServletRequest req, CommentVO commentVO) {
		
		UserMember user = (UserMember)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String memId = user.getUsername();
		String boNo = map.get("boNo");
		int bono = Integer.parseInt(boNo);
		String content = map.get("coContent");
		
//		log.info("댓글 등록! VO -> " + commentVO);
		
		commentVO.setMemId(memId);
		commentVO.setBoNo(bono);
		commentVO.setCoContent(content);
		
//		log.info("댓글 등록! VO -> " + commentVO);
		
		ServiceResult res = bService.registerComment(req, commentVO);
		
		return new ResponseEntity<ServiceResult> (res, HttpStatus.OK);
	}
	
	/**
	 * 댓글 삭제 컨트롤러
	 * 
	 * @param map
	 * @param req
	 * @return
	 */
	@RequestMapping(value = "/deleteComment", method = RequestMethod.POST)
	public ResponseEntity<ServiceResult> deleteComment(@RequestBody Map<String, String> map,  HttpServletRequest req) {
		
		int coNo = Integer.parseInt(map.get("coNo"));
		//재사용성이 없으면 그냥 이렇게 냅다 선언이 더 효율적
		
		ServiceResult res =  bService.deleteComment(coNo);
		
		
		return new ResponseEntity<ServiceResult> (res, HttpStatus.OK);
	}
	
	
	/**
	 * 이스터에그 컨트롤러
	 * 
	 * @param model
	 * @param req
	 * @return
	 */
	@RequestMapping(value = "/cheers", method = RequestMethod.GET)
	public String boardCheers(Model model, HttpServletRequest req) {
		
		return "cheers";
	}
	
}
