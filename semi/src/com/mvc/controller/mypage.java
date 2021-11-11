package com.mvc.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mvc.dao.Dao;
import com.mvc.dao.DaoImpl;
import com.mvc.dao.mypage.MypageDao;
import com.mvc.dao.mypage.MypageDaoImpl;
import com.mvc.dto.HeartDto;
import com.mvc.dto.PromiseDto;
import com.mvc.dto.UserDto;
import com.mvc.dto.blogDto;
import com.mvc.dto.blogHeartDto;

@WebServlet("/mypage.do")
public class mypage extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		MypageDao m_dao = new MypageDaoImpl();
		Dao	u_dao = new DaoImpl();

		HttpSession session = request.getSession();
		UserDto user = (UserDto) session.getAttribute("dto");
		//user.setUser_id("ILNAM");//일남 
		//System.out.println("로그인 아이디 : " + user.getUser_id());
		
		String command = request.getParameter("command");
		System.out.println("["+command+"]");
		
		if(command.equals("mypage")) {
			
			if (user == null || user.getUser_id().trim().equals("")) {
				System.out.println("로그인확인!!!");
				jsResponse("로그인이 필요합니다", request.getContextPath()+"/login/login.jsp", response);
			} else {
				//내여행 리스트
				List<blogDto> travel_list =  m_dao.selectTravel(user.getUser_id());
				request.setAttribute("travel_list", travel_list);
				
				//내가 찜한 블로그
				List<blogHeartDto> wishedB_list = m_dao.selectWishedBlog(user.getUser_id());
				request.setAttribute("wishedB_list", wishedB_list);
				
				//내가 찜한 여행지
				List<HeartDto> wished_list =  m_dao.selectWished(user.getUser_id());
				request.setAttribute("wished_list", wished_list);
				
				//동행 리스트
				List<PromiseDto> companion_list = m_dao.selectCompanion(user.getUser_id());
				request.setAttribute("companion_list", companion_list);
				
				dispatch("user/mypage.jsp", request, response);
			}
		}else if(command.equals("myTravel")){
			if (user == null || user.getUser_id().trim().equals("")) {
				System.out.println("로그인확인!!!");
				jsResponse("로그인이 필요합니다", request.getContextPath()+"/login/login.jsp", response);

			} else {
				//내여행 리스트
				List<blogDto> travel_list =  m_dao.selectTravel(user.getUser_id());
				request.setAttribute("travel_list", travel_list);
				dispatch("user/my_travel.jsp", request, response);
			}
		}else if(command.equals("wishedTravel")) {
			if (user == null || user.getUser_id().trim().equals("")) {
				System.out.println("로그인확인!!!");
				jsResponse("로그인이 필요합니다", request.getContextPath()+"/login/login.jsp", response);

			} else {
				//내가 찜한 여행지 + 일정
				List<HeartDto> wished_list =  m_dao.selectWished(user.getUser_id());
				request.setAttribute("wished_list", wished_list);
				dispatch("user/save_travel.jsp", request, response);
			}
			
		}else if(command.equals("wishedBlog")) {
			if (user == null || user.getUser_id().trim().equals("")) {
				System.out.println("로그인확인!!!");
				jsResponse("로그인이 필요합니다", request.getContextPath()+"/login/login.jsp", response);

			} else {
				List<blogHeartDto> wishedB_list = m_dao.selectWishedBlog(user.getUser_id());
				request.setAttribute("wishedB_list", wishedB_list);
				dispatch("user/save_blog.jsp", request, response);
			}
			
		}else if(command.equals("myCompanion")) {
			if (user == null || user.getUser_id().trim().equals("")) {
				System.out.println("로그인확인!!!");
				jsResponse("로그인이 필요합니다", request.getContextPath()+"/login/login.jsp", response);
			} else {
				//동행 리스트
				List<PromiseDto> companion_list = m_dao.selectCompanion(user.getUser_id());
				request.setAttribute("companion_list", companion_list);
				dispatch("user/my_companion.jsp", request, response);
			}
		}else if(command.equals("infoUpdate")) {
			dispatch("user/info_update.jsp", request, response);
		}else if(command.equals("updateUser")) {
			String user_id = request.getParameter("user_id");
			String passwd = request.getParameter("pw_check");
			String name = request.getParameter("name");
			String nickname = request.getParameter("nickname");
			String nation = request.getParameter("nation");
			String gender = request.getParameter("gender");
			String email = request.getParameter("email")+"@"+request.getParameter("dot");
			int age = Integer.parseInt(request.getParameter("age"));
			String phone = request.getParameter("phone");
			
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
			
			int res = u_dao.info_update(dto);

			session.removeAttribute("dto"); //세션삭제
			
			session.setAttribute("dto", dto); //세션 다시 등록
			session.setMaxInactiveInterval(60*60); //세션 유지 시간 - 1시간
			jsResponse("정보수정성공", "user/mypage.jsp", response);
		}else if(command.equals("deleteUser")){
			String user_id = request.getParameter("user_id");
			int res = u_dao.deleteUser(user_id);
			if(res>0) {
				dispatch("user/unregister_2.jsp", request, response);
			}else {
				jsResponse("회원탈퇴실패", "user/mypage.jsp", response);
			}
			
		}
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
