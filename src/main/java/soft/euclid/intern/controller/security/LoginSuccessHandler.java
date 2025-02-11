package soft.euclid.intern.controller.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class LoginSuccessHandler implements AuthenticationSuccessHandler {

	private RequestCache requestCache = new HttpSessionRequestCache();
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
		User user = (User) authentication.getPrincipal();
		
//		log.info("찍은 username : " + user.getUsername());
//		log.info("찍은 password : " + user.getPassword());
//		log.info("찍은 auth : " + user.getAuthorities());
		//잘 나오는 것 확인 완료
		
		clearAuth(request);
		SavedRequest savedRequest = requestCache.getRequest(request, response);
		
		String targetURL = request.getContextPath() + "/";
		if (savedRequest != null) {
			targetURL = savedRequest.getRedirectUrl();
		}
//		log.info("로그인 성공! 타겟 URL -> " + targetURL);
		response.sendRedirect(targetURL);
		
	}
	public void clearAuth(HttpServletRequest req) {
		HttpSession session = req.getSession();
		if(session == null) {
			return;
		}
		session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
	}

}
