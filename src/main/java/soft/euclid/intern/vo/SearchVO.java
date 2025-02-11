package soft.euclid.intern.vo;

import java.util.List;

import lombok.Data;

@Data
public class SearchVO<T> {

	public String memId;
	public String searchType;	//검색유형
	public String searchWord;	//검색단어
	public List<T> searhList;	//검색된 데이터를 담을 리스트
	

}
