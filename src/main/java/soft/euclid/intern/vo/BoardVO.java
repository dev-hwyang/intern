package soft.euclid.intern.vo;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Datapublic class BoardVO {
	
	/* board 칼럼 */
	public int boNo;
	public String boTitle;
	public String boContent;
	public String boHit;
	public String boRegDate;
	public String memId;
	public String memName;
		//목록으로 접속하게 되면 검색에서 회원 이름으로 검색해야 해서
		//memName이 필요함.
		//만약 VO를 건들면 안되는 상황이라면
		//sql문에서 as (알리아스)사용해서 지정해주면 됨
	public String test;
	public int howManyFile;
	public Integer[] delFileNo;
	
	public List<FileVO> fileList;	//상세보기 - 파일리스트
	public MultipartFile[] boFile;
	
	public List<CommentVO> commentList;
//    public void setTest(String test) {
//    	System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
//    }
	
	public void setBoFile(MultipartFile[] boFile) {
		this.boFile = boFile;
		if(boFile != null) {
			 List<FileVO> fileList  = new ArrayList<FileVO>();
			 for(MultipartFile file : boFile) {
				 if(StringUtils.isBlank(file.getOriginalFilename())) {
					 continue;
				 }
				 FileVO fileVO =  new FileVO(file);
				 fileList.add(fileVO);
//				 log.info("셋보파이리이이이이 -> " + fileList);
			 }
			 this.fileList = fileList;
		}
	}
	
}
