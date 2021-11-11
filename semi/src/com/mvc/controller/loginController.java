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


import com.mvc.dao.Dao;
import com.mvc.dao.DaoImpl;
import com.mvc.dto.UserDto;

@WebServlet("/loginController.do")
public class loginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		String command = request.getParameter("command");
		System.out.println("[command: "+command+"]");
		
		HttpSession session = request.getSession();
		Dao dao = new DaoImpl();
		
		if(command.equals("login")) {
			
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			
			UserDto dto = dao.login(id, pw);
			if(dto.getUser_id() != null) {
				if(dto.getActive().equals("Y") && dto.getSns() == null) {
					session.setAttribute("dto", dto);
					session.setMaxInactiveInterval(60*60); //세션 유지 시간 - 1시간
					
					dispatch("index.jsp", request, response);
	
				}else {
					jsResponse("로그인실패", request.getContextPath()+"/login/login.jsp", response);
				}
			}else {
				jsResponse("아이디와 비밀번호를 확인해주세요.", request.getContextPath()+"/login/login.jsp", response);
			}
		}else if(command.equals("logout")) {
		
			
			session.removeAttribute("dto");
			dispatch("index.jsp", request, response);

		}else if(command.equals("naverLogin")) {
			String id = request.getParameter("id");
			String pw = "naver";
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			String nickname = request.getParameter("nickname");
			String gender = request.getParameter("gender");			
			String user_img = randomPic();
			
			UserDto dto = new UserDto();
			
			dto = dao.login(id, pw);
			
			if(dto.getUser_id() != null) {
				System.out.println("success!!");
				session.setAttribute("dto", dto);
				session.setMaxInactiveInterval(60*60); //세션 유지 시간 - 1시간
				
			}else {				
				dto.setUser_id(id);
				dto.setPasswd(pw);
				dto.setName(name);
				dto.setNickname(nickname);
				dto.setU_national("");
				dto.setGender(gender);
				dto.setEmail(email);
				dto.setAge(0);
				dto.setPhone("");
				dto.setAddress("");
				dto.setUser_img(user_img);
				dto.setSns("naver"); //네이버 구별값
				
				int res = dao.register(dto);
				
				if(res>0) {
					dto = dao.login(id, pw);
					if(dto.getUser_id() != null) {
						System.out.println("success!!!!!");
						session.setAttribute("dto", dto);
						session.setMaxInactiveInterval(60*60); //세션 유지 시간 - 1시간
						
					}
				}
			}
			
			dispatch("index.jsp", request, response);
			
		}else if(command.equals("registform")) {
			dispatch("login/registform.jsp", request, response);
		
		}else if(command.equals("idchk")) {
			
			String id = request.getParameter("id");
			String res = dao.idChk(id);
			
			boolean idnotused = true;
			
			if(res != null) { //중복아이디 존재
				idnotused = false;
			}
			response.sendRedirect("login/idchk.jsp?idnotused=" + idnotused);

		}else if(command.equals("regist")) {

			
			String user_id = request.getParameter("user_id");
			String passwd = request.getParameter("passwd");
			String name = request.getParameter("name");
			String nickname = request.getParameter("nickname");
			String nation = request.getParameter("nation");
			String gender = request.getParameter("gender");
			String email = request.getParameter("email")+"@"+request.getParameter("dot");
			int age = Integer.parseInt(request.getParameter("age"));
			String phone = request.getParameter("phone");
			String user_img = randomPic();
			
			//주소 Api를 통한 주소값받기
			String postcode = request.getParameter("postcode");
			String roadAddr = request.getParameter("roadAddress");
			String detailAddr = request.getParameter("detailAddress");
			String addr = postcode+" "+roadAddr+" "+detailAddr;
			
			UserDto dto = new UserDto();
			dto.setUser_id(user_id);
			dto.setPasswd(passwd);
			dto.setName(name);
			dto.setNickname(nickname);
			dto.setU_national(nation);
			dto.setGender(gender);
			dto.setEmail(email);
			dto.setAge(age);
			dto.setPhone(phone);
			dto.setAddress(addr);
			dto.setUser_img(user_img);
			dto.setSns(null);
			int res = dao.register(dto);
			
			jsResponse("회원가입성공!", request.getContextPath()+"/index.jsp", response);

		}

	}

	public String randomPic() {
		int rNum = (int)(Math.random()*10 + 1);
		StringBuilder name = new StringBuilder("user");
		name.append(rNum);
		return name.toString();
	}
	
	private void jsResponse(String msg, String url, HttpServletResponse response) throws IOException{
		String s = "<script type='text/javascript'>" +
					"alert('"+msg+"');" +
					"location.href='"+url+"';" +
					"</script>";
		
		PrintWriter out = response.getWriter();
		out.print(s);
	}

	public void dispatch(String url, HttpServletRequest request, HttpServletResponse reponse) throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher(url);
		dispatcher.forward(request, reponse);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
