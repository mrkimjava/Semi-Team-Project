package com.mvc.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.mvc.biz.companion.CompanionBizImpl;
import com.mvc.dao.companion.CompanionDaoImpl;
import com.mvc.dto.AskConnect;
import com.mvc.dto.MessageDto;
import com.mvc.dto.PromiseDto;
import com.mvc.dto.UserDto;

@WebServlet("/message.do")
public class CompanionController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		HttpSession session = request.getSession();
		CompanionBizImpl biz = new CompanionBizImpl();
		UserDto login_id = (UserDto)session.getAttribute("dto");

		System.out.println("로그인 아이디 : " + login_id.getUser_id());
		
		if (login_id.getUser_id() == null || login_id.getUser_id().trim().equals("")) {
			jsResponse("#", "로그인을 해주세요.", response);
		}

		String command = request.getParameter("command");
		System.out.println("[command : " + command + "]");

		if (command.equals("message")) {
			List<MessageDto> list = biz.connectionList(login_id.getUser_id());
			
			List<MessageDto> conList = new ArrayList<>();
			for (int i = 0; i < list.size(); i++) {
				MessageDto dto = new MessageDto();
				if (list.get(i).getRec_id().equals(login_id.getUser_id())) {
					dto.setSen_id(list.get(i).getSen_id());
				} else if (list.get(i).getSen_id().equals(login_id.getUser_id())) {
					dto.setSen_id(list.get(i).getRec_id());
				}
				if (list.get(i).getMessage().length() > 27) {
					// 25자가 넘어가면...으로 넣어줘야함
					String temp2 = list.get(i).getMessage();
					String temp = list.get(i).getMessage().charAt(25) + "";
					String temp3 = temp2.substring(0, temp2.lastIndexOf(temp)) + ".....";
					dto.setMessage(temp3);
				} else {
					dto.setMessage(list.get(i).getMessage());
				}
				dto.setM_time(list.get(i).getM_time());
				dto.setSender_img(list.get(i).getSender_img());
				dto.setUser_name(list.get(i).getUser_name());
				conList.add(dto);
			}

			request.setAttribute("conList", conList);
			dispatch("companion/message.jsp", request, response);

		} else if (command.equals("askConnect")) {
			response.getWriter().write(jsonAsk(login_id.getUser_id()));

		} else if (command.equals("detailMessage")) {
			String sen_id = request.getParameter("sen_id");
			List<MessageDto> list = biz.getMessage(login_id.getUser_id(), sen_id);

			MessageDto dto = new MessageDto();
			dto.setChat_serial(list.get(0).getChat_serial());
			dto.setSen_id(sen_id);
			list.add(dto);

			request.setAttribute("detailList", list);
			dispatch("companion/messengerRoom.jsp", request, response);

		} else if (command.equals("sendMessage")) {
			String con_id = request.getParameter("con_id");
			String message = request.getParameter("message");
			String chat_serial = request.getParameter("chat_serial");

			biz.sendRecMessage(login_id.getUser_id(), con_id, message, chat_serial);

		} else if (command.equals("refresh")) {
			String con_id = request.getParameter("con_id");
			response.getWriter().write(jsonMessage(login_id.getUser_id(), con_id));

		} else if (command.equals("reportUser")) {
			String con_id = request.getParameter("con_id");
			boolean flag = biz.reportUser(login_id.getUser_id(), con_id);

			if (flag) {
				response.getWriter().write("통신완료");
			} else {
				response.getWriter().write("통신실패");
			}

		} else if (command.equals("deleteMessage")) {
			String con_id = request.getParameter("con_id");
			boolean flag = biz.reportUser(login_id.getUser_id(), con_id);

			if (flag) {
				response.getWriter().write("삭제완료");
			} else {
				response.getWriter().write("삭제실패");
			}
		} else if (command.equals("deleteMessageTab")) {
			response.getWriter().write(jsonList("delete" ,login_id.getUser_id()));
			
		} else if (command.equals("currentMessageTab")) {
			response.getWriter().write(jsonList("current", login_id.getUser_id()));
			
		} else if (command.equals("askPermit")) {
			String con_id = request.getParameter("id");
			String message = request.getParameter("message");
			boolean flag = biz.askPermit(login_id.getUser_id(), con_id, message);
			response.getWriter().write(flag?"성공":"실패");
			
		} else if (command.equals("askDenied")) {
			String con_id = request.getParameter("id");
			boolean flag = biz.askDenied(login_id.getUser_id(), con_id);
			response.getWriter().write(flag?"성공":"실패");
			
		} else if (command.equals("promise")) {
			String con_id = request.getParameter("con_id");
			String loc = request.getParameter("loc");
			String date = request.getParameter("date");
			String comment = request.getParameter("comment");
			boolean flag = biz.makePromise(login_id.getUser_id(), con_id, loc, date, comment);
			response.getWriter().write(flag?"성공":"실패");
			
		} else if (command.equals("getPromise")) {
			response.getWriter().write(jsonGetPromise(login_id.getUser_id()));
			
		} else if (command.equals("choicePromise")) {
			String con_id = request.getParameter("con_id");
			String loc = request.getParameter("loc");
			String permit = request.getParameter("permit");
			String chat_serial = request.getParameter("chat_serial");
			String comment = request.getParameter("comment");

			boolean flag = biz.promiseChoice(login_id.getUser_id(), con_id, loc, permit, comment, chat_serial);;
			
			response.getWriter().write(flag?"성공":"실패");
			
		} else if (command.equals("blogAsk")) {
			String con_id = request.getParameter("con_id");
			String comment = request.getParameter("comment");
			boolean able = biz.ableAskCompanion(login_id.getUser_id(), con_id);
			
			if (able) {
				boolean flag = blogAskCompanion(login_id.getUser_id(), con_id, comment);
				response.getWriter().write(flag?"성공":"실패");
			} else {
				response.getWriter().write("이미 연결된 회원입니다.");
			}
			
		} else if (command.equals("completeDelete")) {
			String con_id = request.getParameter("con_id");
			int res = biz.completeDelete(login_id.getUser_id(), con_id);
			response.getWriter().write(res>0?"성공":"실패");
			
		} else if (command.equals("promiseWithUs")) {
			response.getWriter().write(jsonGetPromiseList(login_id.getUser_id()));
			
		} else if (command.equals("denyMessage")) {
			String con_id = request.getParameter("con_id");
			int chat_serial = Integer.parseInt(request.getParameter("chat_serial"));
			int res = biz.sendDenyMessage(login_id.getUser_id(), con_id, chat_serial);
			response.getWriter().write(res>0?"성공":"실패");
			
		} else if (command.equals("cancelPromise")) {
			String loc = request.getParameter("loc");
			int penalty = biz.ableCancel(login_id.getUser_id());
			int res = 0;
			
			if (penalty == 3) {
				res = biz.deletePromise(login_id.getUser_id(), penalty, loc);
			} else {
				res = biz.deletePromise(login_id.getUser_id(), penalty+1, loc);
			}
			response.getWriter().write(res>0?"성공":"실패");
		}
	}
	
	public boolean blogAskCompanion(String login_id, String con_id, String comment) {
		CompanionBizImpl biz = new CompanionBizImpl();
		boolean flag = biz.blogAskCompanion(login_id, con_id, comment);
		
		return flag;
	}
	
	@SuppressWarnings("unchecked")
	public String jsonGetPromiseList(String login_id) {
		CompanionBizImpl biz = new CompanionBizImpl();
		List<PromiseDto> list = biz.getPromiseList(login_id);
		JSONObject json = new JSONObject();

		for (int i = 0; i < list.size(); i++) {
			JSONArray array = new JSONArray();
			array.add(list.get(i).getSen_id());
			array.add(list.get(i).getP_loc());
			array.add(list.get(i).getP_time());
			array.add(list.get(i).getP_comment());
			array.add(list.get(i).getUser_img());
			array.add(list.get(i).getUser_name());

			json.put("result" + i, array);
		}
		return json.toJSONString();
		
	}
	
	@SuppressWarnings("unchecked")
	public String jsonGetPromise(String login_id) {
		CompanionBizImpl biz = new CompanionBizImpl();
		List<PromiseDto> list = biz.getPromise(login_id);
		JSONObject json = new JSONObject();

		for (int i = 0; i < list.size(); i++) {
			JSONArray array = new JSONArray();
			array.add(list.get(i).getSen_id());
			array.add(list.get(i).getP_loc());
			array.add(list.get(i).getP_time());
			array.add(list.get(i).getP_comment());
			array.add(list.get(i).getUser_img());
			array.add(list.get(i).getUser_name());

			json.put("result" + i, array);
		}
		return json.toJSONString();
	}
	
	@SuppressWarnings("unchecked")
	public String jsonList(String command, String login_id) {
		CompanionDaoImpl dao = new CompanionDaoImpl();
		CompanionBizImpl biz = new CompanionBizImpl();
		
		if(command.equals("delete")) {
			List<MessageDto> list = dao.getDeleteList(login_id);
			
			List<MessageDto> deleteList = new ArrayList<>();
			for (int i = 0; i < list.size(); i++) {
				MessageDto dto = new MessageDto();
				if (list.get(i).getRec_id().equals(login_id)) {
					dto.setSen_id(list.get(i).getSen_id());
				} else if (list.get(i).getSen_id().equals(login_id)) {
					dto.setSen_id(list.get(i).getRec_id());
				}
				if (list.get(i).getMessage().length() > 27) {
					// 25자가 넘어가면...으로 넣어줘야함
					String temp2 = list.get(i).getMessage();
					String temp = list.get(i).getMessage().charAt(25) + "";
					String temp3 = temp2.substring(0, temp2.lastIndexOf(temp)) + ".....";
					dto.setMessage(temp3);
				} else {
					dto.setMessage(list.get(i).getMessage());
				}
				dto.setSender_img(list.get(i).getSender_img());
				dto.setUser_name(list.get(i).getUser_name());
				deleteList.add(dto);
			}
			JSONObject json = new JSONObject();
			
			for (int i = 0; i < deleteList.size(); i++) {
				JSONArray array = new JSONArray();
				array.add(deleteList.get(i).getSen_id());
				array.add(deleteList.get(i).getMessage());
				array.add(deleteList.get(i).getSender_img());
				array.add(deleteList.get(i).getUser_name());
				
				json.put("result" + i, array);
			}
			return json.toJSONString();
			
		} else {
			List<MessageDto> list = biz.connectionList(login_id);

			List<MessageDto> conList = new ArrayList<>();
			for (int i = 0; i < list.size(); i++) {
				MessageDto dto = new MessageDto();
				if (list.get(i).getRec_id().equals(login_id)) {
					dto.setSen_id(list.get(i).getSen_id());
				} else if (list.get(i).getSen_id().equals(login_id)) {
					dto.setSen_id(list.get(i).getRec_id());
				}
				if (list.get(i).getMessage().length() > 27) {
					// 25자가 넘어가면...으로 넣어줘야함
					String temp2 = list.get(i).getMessage();
					String temp = list.get(i).getMessage().charAt(25) + "";
					String temp3 = temp2.substring(0, temp2.lastIndexOf(temp)) + ".....";
					dto.setMessage(temp3);
				} else {
					dto.setMessage(list.get(i).getMessage());
					dto.setSender_img(list.get(i).getSender_img());
					dto.setUser_name(list.get(i).getUser_name());
				}
				conList.add(dto);
			}
			JSONObject json = new JSONObject();
			
			for (int i = 0; i < conList.size(); i++) {
				JSONArray array = new JSONArray();
				array.add(conList.get(i).getSen_id());
				array.add(conList.get(i).getMessage());
				array.add(conList.get(i).getSender_img());
				array.add(conList.get(i).getUser_name());
				
				json.put("result" + i, array);
			}
			return json.toJSONString();
		}
	}

	@SuppressWarnings("unchecked")
	public String jsonMessage(String login_id, String con_id) {
		CompanionBizImpl biz = new CompanionBizImpl();
		
		List<MessageDto> list = biz.getMessage(login_id, con_id);
		JSONArray array = new JSONArray();
		
		for (int i = 0; i < list.size(); i++) {
			JSONObject object = new JSONObject();
			object.put("sen_id", list.get(i).getSen_id());
			object.put("message", list.get(i).getMessage());
			object.put("time", list.get(i).getM_time().toString());
			object.put("user_img", list.get(i).getSender_img());
			object.put("user_name", list.get(i).getUser_name());
			array.add(object);
		}
		return array.toJSONString();
	}

	@SuppressWarnings("unchecked")
	public String jsonAsk(String login_id) {
		CompanionDaoImpl dao = new CompanionDaoImpl();
		List<AskConnect> list = dao.getAskConnect(login_id);

		JSONObject json = new JSONObject();

		for (int i = 0; i < list.size(); i++) {
			JSONArray array = new JSONArray();
			array.add(list.get(i).getSen_id());
			array.add(list.get(i).getComment_ask());
			array.add(list.get(i).getAsk_date().toString());
			array.add(list.get(i).getUser_img());
			array.add(list.get(i).getUser_name());

			json.put("result" + i, array);
		}
		return json.toJSONString();
	}

	public void jsResponse(String url, String message, HttpServletResponse response) throws IOException {
		String script = "<script type='text/javascript'> " + "alert('" + message + "'); " + "location.href = '" + url
				+ "';" + "</script>";
		PrintWriter writer = response.getWriter();
		writer.print(script);
	}
	
	public void dispatch(String url, HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher dispatch = request.getRequestDispatcher(url);
		dispatch.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
