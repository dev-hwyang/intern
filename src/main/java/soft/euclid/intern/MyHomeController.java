package soft.euclid.intern;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MyHomeController {
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String success_questionmark() {
		
		return "redirect:/intern/list";
	}
//	
//	@RequestMapping(value = "/index", method = RequestMethod.GET)
//	public String board() {
//		
//		return "index";
//	}
	
	
//	@RequestMapping("/index")
//	public void mainIndex(HttpServletRequest request, HttpServletResponse response, ModelMap model) {
//		Connection connection = null;
//		String databaseConn = "jdbc:mariadb://127.0.0.1:3306/intern";
//		
//		try {
//			connection =  DriverManager.getConnection(databaseConn, "root", "java");
//			System.out.println("마리아디비에 연결됨");
//		} catch (SQLException e) {
//			e.printStackTrace();
//			System.out.println("마리아디비에 연결하지 못함");
//		} finally {
//			if (null != connection) {
//				try {
//					connection.close();
//					System.out.println("마리아디비에서 연결을 종료함");
//				} catch (SQLException e) {
//					e.printStackTrace();
//					System.out.println("마리아디비에서 연결을 종료하지 못함");
//				}
//			}
//		}
//	}
	
}
