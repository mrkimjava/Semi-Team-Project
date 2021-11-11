package com.mvc.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import com.mvc.biz.BizImpl;
import com.mvc.dto.HeartDto;
import com.mvc.dto.UserDto;

/**
 * Servlet implementation class search
 */
@WebServlet("/search.do")
public class search extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public search() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		HttpSession session = request.getSession();
		UserDto dto = (UserDto)session.getAttribute("dto");
		String command = request.getParameter("command");
		PrintWriter pw = response.getWriter();
		
		if(command.equals("confirmheart")) {
			if(dto != null) {
				boolean res = new BizImpl().confirmheart(dto.getUser_id(), request.getParameter("placeid"));
				pw.print(res);
			}else {
				pw.print("no_id");
			}
		}
		
		
		if(command.equals("addheart")) {
			if(dto != null) {
				HeartDto heartdto = new HeartDto();
				heartdto.setUserid(dto.getUser_id());
				heartdto.setPlace_id(request.getParameter("placeid"));
				heartdto.setThumbnail(request.getParameter("thumbnail"));
				heartdto.setPlace_name(request.getParameter("placename"));
				heartdto.setLatitude(request.getParameter("latitude"));
				heartdto.setLongtitude(request.getParameter("longtitude"));
				heartdto.setPlace_address(request.getParameter("address"));
				heartdto.setNation(request.getParameter("nation"));
				heartdto.setCity(request.getParameter("city"));

				int res = new BizImpl().addheart(heartdto);
					pw.print(res);
			}else {
				pw.print("no_id");
			}
		}
		
		else if(command.equals("rmheart")) {
			if(dto != null) {
				int res = new BizImpl().rmheart(dto.getUser_id(), request.getParameter("placeid"));
				pw.print(res);
			}else {
				pw.print("세션종료");
			}
			
		}
		
		else if(command.equals("heartcount")) {
			int res = new BizImpl().getheartCount(request.getParameter("placeid"));
			pw.print(res);
		}
	}

	public void dispatch(String url, HttpServletRequest request, HttpServletResponse reponse) throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher(url);
		dispatcher.forward(request, reponse);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
