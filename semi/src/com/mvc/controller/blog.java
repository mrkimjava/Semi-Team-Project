package com.mvc.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.mvc.biz.BizImpl;
import com.mvc.dto.blogDto;
import com.mvc.dto.commentDto;

/**
 * Servlet implementation class Servlet
 */
@WebServlet("/blog.do")
public class blog extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public blog() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		 
		String command = request.getParameter("command");
		PrintWriter pw = response.getWriter();
		
		if(command.equals("bloglist")) {
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			
			ArrayList<blogDto> dtolist = new BizImpl().getBlogList();
			JSONArray jarray = new JSONArray();

			for(int i = 0; i < dtolist.size(); i++) {
				JSONObject json = new JSONObject();
				
				String createDate = format.format(dtolist.get(i).getBlog_create_date());
				json.put("createDate", createDate);
				String mindate = format.format(dtolist.get(i).getMindate());
				json.put("mindate", mindate);
				String maxdate = format.format(dtolist.get(i).getMaxdate());
				json.put("maxdate", maxdate);
				
				json.put("userid", dtolist.get(i).getUser_id());
				json.put("penalty", dtolist.get(i).getUser_penalty());
				json.put("blogseq", dtolist.get(i).getBlog_seq());
				json.put("title", dtolist.get(i).getTitle());
				json.put("content", dtolist.get(i).getContent());
				json.put("area", dtolist.get(i).getAreaname());
				json.put("path", dtolist.get(i).getThumbnailPath());
				json.put("blogheart", dtolist.get(i).getHeart_count());
				json.put("comment", dtolist.get(i).getComment());
				json.put("hits", dtolist.get(i).getHits());
				jarray.add(json);
			}
			System.out.println(jarray);
			PrintWriter out = response.getWriter();
			out.print(jarray.toJSONString());
		}
		
		else if(command.equals("selectone")) {
			System.out.println("넘겨받은 seq : " + request.getParameter("blogseq"));
			int blogseq = Integer.parseInt(request.getParameter("blogseq"));
			String userid = request.getParameter("user_id");
			
			blogDto bdto = new BizImpl().getblogOne(userid, blogseq);
			request.setAttribute("bdto", bdto);
			dispatch("/blog/blog_detail_sk.jsp", request, response);
			
		}
		
		else if(command.equals("delblog")) {
			
			int blogseq = Integer.parseInt(request.getParameter("blogseq"));
			String userid = request.getParameter("userid");
			
			int res = new BizImpl().delblog(userid, blogseq);
			if(res > 0) {
				response.sendRedirect(request.getContextPath() + "/blog/blog_main.jsp");
			}else {
				response.sendRedirect(request.getContextPath() + "/blog/blog_main.jsp");
			}
		}
		
		else if(command.equals("confirmblogheart")) {
			
			String sessionid = request.getParameter("sessionId");
			String blogid = request.getParameter("blogId");
			int blogseq = Integer.parseInt(request.getParameter("blogSeq"));
			boolean res = new BizImpl().confirmblogheart(sessionid, blogid, blogseq);
			pw.print(res);
		}
		
		else if(command.equals("addblogheart")) {
			
			String sessionid = request.getParameter("sessionId");
			String blogid = request.getParameter("blogId");
			int blogseq = Integer.parseInt(request.getParameter("blogSeq"));
			String title = request.getParameter("title");
			
			int res = new BizImpl().addblogheart(sessionid, blogid, blogseq, title);
			if(res > 0) {
				pw.print("success");
			}else {
				pw.print("fail");
			}
		}
		
		else if(command.equals("rmblogheart")) {
			
			String sessionid = request.getParameter("sessionId");
			String blogid = request.getParameter("blogId");
			int blogseq = Integer.parseInt(request.getParameter("blogSeq"));
			
			System.out.println(sessionid);
			System.out.println(blogid);
			System.out.println(blogseq);
			
			
			int res = new BizImpl().rmblogheart(sessionid, blogid, blogseq);
			if(res > 0) {
				pw.print("success");
			}else {
				pw.print("fail");
			}
			
		}
		
		else if(command.equals("comment")) {
			
			String blogid = request.getParameter("blogid");
			int blogseq = Integer.parseInt(request.getParameter("blogseq"));
			
			ArrayList<commentDto> list = new BizImpl().getcommentlist(blogid, blogseq);
			JSONArray jarray = new JSONArray();
			
			for(int i = 0; i < list.size(); i++) {
				JSONObject json = new JSONObject();
			
				json.put("blogid", list.get(i).getBlogid());
				json.put("blogseq", list.get(i).getBlogseq());
				json.put("commentdate", list.get(i).getCommentDate().toString());
				json.put("commentseq", list.get(i).getCommentseq());
				json.put("groupno", list.get(i).getGroupno());
				json.put("groupseq", list.get(i).getGroupseq());
				json.put("commentid", list.get(i).getCommentid());
				json.put("content", list.get(i).getContent());
				jarray.add(json);
			}
			System.out.println(jarray);
			PrintWriter out = response.getWriter();
			out.print(jarray.toJSONString());
		}
		
		else if(command.equals("addcomment")) {
			
			String blogid = request.getParameter("blogid");
			int blogseq = Integer.parseInt(request.getParameter("blogseq"));
			String commentid = request.getParameter("commentid");
			String content = request.getParameter("content");
			
			ArrayList<commentDto> list = new BizImpl().addcomment(blogid, blogseq, commentid, content);
			JSONArray jarray = new JSONArray();
			
			for(int i = 0; i < list.size(); i++) {
				JSONObject json = new JSONObject();
			
				json.put("blogid", list.get(i).getBlogid());
				json.put("blogseq", list.get(i).getBlogseq());
				json.put("commentdate", list.get(i).getCommentDate().toString());
				json.put("commentseq", list.get(i).getCommentseq());
				json.put("groupno", list.get(i).getGroupno());
				json.put("groupseq", list.get(i).getGroupseq());
				json.put("commentid", list.get(i).getCommentid());
				json.put("content", list.get(i).getContent());
				jarray.add(json);
			}
			System.out.println(jarray);
			PrintWriter out = response.getWriter();
			out.print(jarray.toJSONString());
			
		}
		
		else if(command.equals("delcomment")) {
			
			String blogid = request.getParameter("blogid");
			int blogseq = Integer.parseInt(request.getParameter("blogseq"));
			int commentseq = Integer.parseInt(request.getParameter("commentseq"));
			int groupno = Integer.parseInt(request.getParameter("groupno"));
			int groupseq = Integer.parseInt(request.getParameter("groupseq"));
			
			ArrayList<commentDto> list = new BizImpl().delcomment(blogid, blogseq, commentseq, groupno, groupseq);
			JSONArray jarray = new JSONArray();
			
			for(int i = 0; i < list.size(); i++) {
				JSONObject json = new JSONObject();
			
				json.put("blogid", list.get(i).getBlogid());
				json.put("blogseq", list.get(i).getBlogseq());
				json.put("commentdate", list.get(i).getCommentDate().toString());
				json.put("commentseq", list.get(i).getCommentseq());
				json.put("groupno", list.get(i).getGroupno());
				json.put("groupseq", list.get(i).getGroupseq());
				json.put("commentid", list.get(i).getCommentid());
				json.put("content", list.get(i).getContent());
				jarray.add(json);
			}
			System.out.println(jarray);
			PrintWriter out = response.getWriter();
			out.print(jarray.toJSONString());
			
		}
		
		else if(command.equals("addanswer")) {
			
			String blogid = request.getParameter("blogid");
			int blogseq = Integer.parseInt(request.getParameter("blogseq"));
			String commentid = request.getParameter("commentid");
			String answer = request.getParameter("answer");
			int groupno = Integer.parseInt(request.getParameter("groupno"));
			
			ArrayList<commentDto> list = new BizImpl().addanswer(blogid, blogseq, commentid, answer, groupno);
			JSONArray jarray = new JSONArray();
			
			for(int i = 0; i < list.size(); i++) {
				JSONObject json = new JSONObject();
			
				json.put("blogid", list.get(i).getBlogid());
				json.put("blogseq", list.get(i).getBlogseq());
				json.put("commentdate", list.get(i).getCommentDate().toString());
				json.put("commentseq", list.get(i).getCommentseq());
				json.put("groupno", list.get(i).getGroupno());
				json.put("groupseq", list.get(i).getGroupseq());
				json.put("commentid", list.get(i).getCommentid());
				json.put("content", list.get(i).getContent());
				jarray.add(json);
			}
			System.out.println(jarray);
			PrintWriter out = response.getWriter();
			out.print(jarray.toJSONString());
			
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

















