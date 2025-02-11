package soft.euclid.intern.vo;

import java.util.List;

import lombok.Data;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Data
public class PaginationVO<T> {

	
	public String memId;
	public String searchType;	//검색유형
	public String searchWord;	//검색단어
	public List<T> searhList;	//검색된 데이터를 담을 리스트
	
	
	
	public int totalRecord; // 전체 데이터 개수
	public int totalPage; // 전체 페이지 (블록) 개수
	public int currentPage; // 현재 페이지
	public int cntPerPage = 10; // 한페이지당 게시글 개수 (10개로 설정)
	public int block = 5; // 페이지 블록수 (한 화면에 보여지는 페이지 블록 수
	public int startRow;	//시작행 (1, 11, 21, ... )
	public int endRow;		//끝행 (10, 20, 30, ... ) 데이터 개수에 따라 0단위로 안끝날수도... 
	public int startPage; //시작페이지
	public int endPage; //끝페이지
	public List<MemberVO> list; // 페이징 후 데이터가 담길 리스트들

	public PaginationVO() {
	}

	public PaginationVO(int totalRecord, int currentPage, int cntPerPage, int totalPage, List<MemberVO> list) {
//		super();
		this.totalRecord = totalRecord;
		this.currentPage = currentPage;
		this.cntPerPage = cntPerPage;
 		this.totalPage = totalPage;
		this.list = list;
		
		//전체 페이지 개수 = 전체 글의 수 / 한 화면에 보여질 행의 수
		//ceil 사용 / 올림해주어서 int형태로 결과가 나올 수 있도록
//		totalPage = (int) Math.ceil(totalRecord/cntPerPage);
		
		//startRow : 현재페이지 / 페이징의 개수 * 페이징의 개수 + 1
		//floor 사용 / 내림함수
		//현재페이지가 5라고 가정 했을때 5/5*5+1 = 6 현재페이지는 1~5가 나와야 하므로
//		totalPage = (int) Math.ceil(totalRecord/cntPerPage);
//		startRow = (int) Math.floor(currentPage / totalPage * totalPage + 1);
//		
//		endRow = startRow + totalPage -1;
//		
//		if (endPage > totalPage) {
//			endPage = totalPage;
//		}
//		log.info("VO얌" + totalPage + currentPage + cntPerPage + startRow + endRow);
	}

	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;

		// 총 페이지 수
		totalPage = (int) Math.ceil(totalRecord / (double)cntPerPage);
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
		endRow = currentPage * cntPerPage;
		startRow = endRow - (cntPerPage - 1);

		// 마지막 페이지 = (현재 페이지 + (페이지 블록 사이즈 - 1)) / 페이지 블록 사이즈 * 페이지 블록 사이즈
		endPage = (currentPage + (block - 1)) / block * block;
		startPage = endPage - (block - 1);

		// 총 페이지 수
//		int totalPage = (int) Math.ceil(totalRecord/cntPerPage);
//		if(endPage > totalPage) {
//			endPage = totalPage;
//		}
	}

	public String getHtml() {
		String html;
		log.info("VO얌" + totalPage + "<- totalPage " + currentPage + "<- currentPage " + cntPerPage  + "<- cntPerPage " + startRow + "<- startRow " + endRow + "<- endRow");

		html = "<ul class='pagination pagination-sm justify-content-center'>";
		
		if(startPage > 1) {
			html += "<li class='page-item prev'>";
			html += "<a class='page-link' href='' data-page='"+ (startPage - block) +"'><i class='tf-icon bx bx-chevrons-left'></i></a>";
			html += "</li>";
			
		}
		if (endPage > totalPage) {
			endPage = totalPage;
		}
		
		for(int i = startPage; i<=endPage; i++) {
			if(i == currentPage) {
				html += "<li class='page-item active'> ";
				html += "<a class='page-link' href='/memberListForAdmin?currentPage="+i+"' data-page='"+i+"' name='currentPage' >"+i+"</a>";
				html += "</li>";
				log.info("VO의 조건에 부합할때 -> " + i);
			}else {
				html += "<li class='page-item'>";
				html += "<a class='page-link' href='/memberListForAdmin?currentPage="+i+"' data-page='"+i+"' name='currentPage' >"+i+"</a>";
				html += "</li>";
				log.info("VO의 else일때 -> " + i);
			}
		}
		
		if (endPage <= totalPage) {
			html += "<li class='page-item next'>";
			html += "<a class='page-link' href='' data-page='"+ endPage + "'><i class='tf-icon bx bx-chevrons-right'></i></a>";
//			html += "<a class='page-link' href='' data-page='"+ (endPage + 1) +"'><i class='tf-icon bx bx-chevrons-right'></i></a>";
			html += "</li>";
		}
		
		html += "</ul>";

		return html;
	}

}
