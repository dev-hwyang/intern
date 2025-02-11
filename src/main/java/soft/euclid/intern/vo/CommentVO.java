package soft.euclid.intern.vo;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Datapublic class CommentVO {
	
	public int boNo;
	public int coNo;
	public String coContent;
	public String coDate;
	public String memId;
	
}
