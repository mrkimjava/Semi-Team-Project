package com.mvc.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mvc.dao.UserPicDao;
import com.mvc.dto.UserDto;


@WebServlet("/userimg")
public class UserImg extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		HttpSession session = request.getSession();
		UserPicDao dao = new UserPicDao();
		
		//로그인 임시처리
		UserDto dto = new UserDto();
		dto.setUser_id("ADMIN");
		session.setAttribute("login_id", dto);
		
		String picName = randomPic();
		
		boolean flag = dao.updatetPic(dto.getUser_id(), picName);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	public String randomPic() {
		int rNum = (int)(Math.random()*10 + 1);
		StringBuilder name = new StringBuilder("user");
		
		name.append(rNum);
		
		return name.toString();
	}
}