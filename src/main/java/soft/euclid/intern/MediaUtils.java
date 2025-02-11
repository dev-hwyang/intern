package soft.euclid.intern;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.MediaType;

public class MediaUtils {
	
	//해당 클래스의 경우 이미지 파일로드시 (JPG, GIF, PNG)의 데이터형식을 맵에 넣어주는 클래스를 만든다.
	private static Map<String, MediaType> mediaMap;

	static{

		mediaMap = new HashMap<String, MediaType>();		
		mediaMap.put("JPG", MediaType.IMAGE_JPEG);
		mediaMap.put("GIF", MediaType.IMAGE_GIF);
		mediaMap.put("PNG", MediaType.IMAGE_PNG);
	}

	public static MediaType getMediaType(String type){

		return mediaMap.get(type.toUpperCase());
	}
}
