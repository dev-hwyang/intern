package soft.euclid.intern.vo;

import org.apache.commons.io.FileUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Data 
public class FileVO {
	
	 private MultipartFile file;
	 private int boNo;
	 private int fileNo;
	 private String filePath;
	 private long fileSize;
	 private String fileName;
	 private String fileOriginname;
	 private String fileMime;
	 private String fileFancysize;
	 
	 public FileVO() {}
	 public FileVO(MultipartFile file) {
		 this.file = file;
//		 this.fileNo = getFileNo();
//		 this.filePath = getFilePath();
		 this.fileName = file.getName();
		 this.fileOriginname = file.getOriginalFilename();
		 this.fileMime = file.getContentType();
		 this.fileSize = file.getSize();
		 this.fileFancysize = FileUtils.byteCountToDisplaySize(fileSize);
		 
//		 log.info("파일브이오다아아아앙" + fileName);
//		 log.info(fileOriginname);
//		 log.info(fileMime);
//		 log.info(fileFancysize);
//		 log.info(filePath);
	 }
	 
}
