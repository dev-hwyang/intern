package soft.euclid.intern.service.impl;

import java.io.File;
import java.io.IOError;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;
import soft.euclid.intern.ServiceResult;
import soft.euclid.intern.mapper.BoardMapper;
import soft.euclid.intern.service.IBoardService;
import soft.euclid.intern.vo.BoardVO;
import soft.euclid.intern.vo.CommentVO;
import soft.euclid.intern.vo.FileVO;
import soft.euclid.intern.vo.SearchVO;

@Slf4j
@Repository
public class BoardServiceImpl implements IBoardService {

	@Inject
	private BoardMapper mapper;
	

	/**
	 * 게시글 등록 서비스
	 */
	@Override
	public ServiceResult register(HttpServletRequest req, BoardVO boardVO) {
		
//		log.info("레지스터 설뷔스");
		
		ServiceResult res = null;
		int stat = mapper.insert(boardVO);
		if (stat > 0) {
			//게시글등록 성공시 파일을 리스트로 받음
			List<FileVO> fileList = boardVO.getFileList();
			try {
				//컨트롤 눌러서 찾아가렴... 댓글 등록 메소드 위에 있단다..
				fileUpload(fileList, boardVO.getBoNo(), req);

//				log.info("레지스터 서비스안에있는퍼일업로드 아래애");
				
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
			res = ServiceResult.OK;
		}else {
			res = ServiceResult.FAILED;
		}
		
		return res;
	}

	/**
	 * 게시글 상세보기 서비스
	 */
	@Override
	public BoardVO select(int boNo) {
//		log.info("나눈 셀렉트야 안녕 제발 제대로좀 나왔으면 좋겠다." + boNo);
		
		//파라미터에 해당하는 게시판 상세 / 파일들도 함께 불러오기
		BoardVO boardVO = mapper.selectBoard(boNo);
		boardVO.setFileList(mapper.selectFile(boNo));
//		boardVO.setFileList(mapper.selectFile(boardVO.getBoNo()));	//가 좀더 정확함
		
		//첨부파일이 총 몇개인지
		int howManyFile = mapper.howManyFile(boNo);
		boardVO.setHowManyFile(howManyFile);
		
		//댓글 리스트로 받아옴
		List<CommentVO> commentVO = mapper.selectComment(boNo);
		boardVO.setCommentList(commentVO);
		
		//조회수 증가
		mapper.increamentHit(boNo);
		
		return boardVO;
	}

	/**
	 * 게시글 수정하기 서비스
	 */
	@Override
	public ServiceResult update(HttpServletRequest req, BoardVO boardVO) {
		ServiceResult res = null;
		int stat = mapper.update(boardVO);
		if (stat > 0) {
			//파일이 첨부되지 않은상태로 등록되었다면 파일 첨부 가능
			List<FileVO> fileList = boardVO.getFileList();
//			log.info("업데이트 서비스안에있는 fileList" + fileList);
			try {
				fileUpload(fileList, boardVO.getBoNo(), req);
				
				//삭제할 파일번호를 가져와서 숫자배열에 담아주기
				Integer[] delFileNo = boardVO.getDelFileNo();
//				log.info("나눈 파일삭제! delFileNo " + delFileNo);
				
				//삭제할 파일번호가 존재한다면 실행
				if(delFileNo != null) {
					for (int i=0; i < delFileNo.length; i++) {
						FileVO fileVO = mapper.selectFileDelete(delFileNo[i]);
//						화면단에서 삭제하며 넘어온 fileNo 삭제 (여러개일수 있으니 배열에 담아서 반복문)
						
//						log.info("나눈 파일삭제! 딜리트지 " + delFileNo.length);
						mapper.fileDelete(delFileNo[i]);
						
						File file = new File(fileVO.getFilePath());	//파일경로에 남아있는 파일 삭제
						file.delete();
					}
				}
				
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
			res = ServiceResult.OK;
		}else {
			res = ServiceResult.FAILED;
		}
		return res;
	}

	/**
	 * 게시글 삭제 서비스
	 */
	@Override
	public ServiceResult delete(int boNo) {
		ServiceResult res = null;
		
		//파라미터에 해당하는 게시글 조회 후
		BoardVO boardVO = mapper.selectBoard(boNo);
		//파라미터에 해당하는 파일들도 모두 삭제
		mapper.deleteFilesWithBoard(boNo);
		//파라미터에 해당하는 댓글들도 모두 삭제
		mapper.deleteCommentsWithBoard(boNo);
		//마지막으로 파라미터에 해당하는 게시글 자체를 삭제
		int stat = mapper.delete(boNo);
		if (stat > 0) {
			res = ServiceResult.OK;
		}else {
			res = ServiceResult.FAILED;
		}
		
		return res;
	}

	/**
	 * 게시물 검색 리스트
	 */
	@Override
	public List<BoardVO> searchlist(SearchVO<BoardVO> sVO) {
		return mapper.searchlist(sVO);
	}
	

	/**
	 * 게시판 파일 다운로드
	 */
	@Override
	public FileVO fileDownload(int fileNo) {
		return mapper.fileDownload(fileNo);
	}

	/**
	 * 내가 작성한 게시글 
	 */
	@Override
	public List<BoardVO> mylist(SearchVO<BoardVO> sVO) {
		return mapper.myList(sVO);
	}

	/**
	 * 파일 업로드 서비스
	 * 
	 * @param fileList
	 * @param boNo
	 * @param req
	 * @throws IllegalStateException
	 * @throws IOException
	 */
	public void fileUpload (List<FileVO> fileList, int boNo, HttpServletRequest req) throws IllegalStateException, IOException {
//		log.info("맨아래에 구현된 솔로메소드");
		String path = "/resources/board/";
		
		if(fileList != null && fileList.size() > 0) {
			for (FileVO fileVO : fileList) {
//				log.info("맨아래에 구현된 솔로메소드안의 포문" + fileVO);
				
				//저장될 랜덤 파일명 생성
				String saveName = UUID.randomUUID().toString();
//				log.info("파일업로드 서비스임플.. 세이브네임" + saveName);
				
				//파일명에 공백이 있을 경우 오류가 날 수 있으므로 언더바로 대체
				saveName = saveName + "_" + fileVO.getFileName().replace(" ", "_");
//				log.info("파일업로드 서비스임플.. _로 바꾼 세이브네임" + saveName);
				
				//저장될 경로
				String saveLocate = req.getServletContext().getRealPath(path+boNo);
//				log.info("파일업로드 서비스임플.. 세이브 로케이트" + saveLocate);
				File file = new File(saveLocate);
				if(!file.exists()) {//업로드를 하기 위한 폴더 구조가 존재하지 않을 때
					file.mkdirs();//폴더 생성
				}
				
				//저장될 경로에 슬래시(/)와 파일명까지 결합
				saveLocate += "/" + saveName;
//				log.info("파일업로드 서비스임플.. /추가한 세이브 로케이트" + saveLocate);
				fileVO.setBoNo(boNo);//게시글 번호 설정
				fileVO.setFilePath(saveLocate);//파일 업로드 경로 설정
				mapper.insertFile(fileVO);//게시글 파일 데이터 추가
//				log.info("파일업로드 서비스임플.. 파일브이오" + fileVO);
				
				File saveFile = new File(saveLocate);
				fileVO.getFile().transferTo(saveFile);//파일 복사
//				log.info("파일업로드 서비스임플.. 세이브 로케이트" + saveLocate);
//				log.info("파일업로드 서비스임플.. 세이브 파일" + saveFile);
//				log.info("파일업로드 서비스임플.. 파일브이오" + fileVO);
			}
		}
	}

	/**
	 * 댓글 작성(등록)
	 */
	@Override
	public ServiceResult registerComment(HttpServletRequest req, CommentVO commentVO) {
		ServiceResult res = null;

		int stat = mapper.registerComment(commentVO);
//		log.info("commentVO ->-> " + commentVO);
		if (stat > 0) {
			res = ServiceResult.OK;
		}else {
			res = ServiceResult.FAILED;
		}
		
		return res;
	}

	/**
	 * 댓글 삭제
	 */
	@Override
	public ServiceResult deleteComment(int coNo) {
		ServiceResult res = null;
		
		int stat = mapper.deleteComment(coNo);
		if (stat > 0) {
			res = ServiceResult.OK;
		}else {
			res = ServiceResult.FAILED;
		}
		
		return res;
	}
	
}
