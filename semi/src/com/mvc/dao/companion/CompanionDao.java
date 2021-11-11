package com.mvc.dao.companion;

import java.sql.Connection;
import java.util.List;

import com.mvc.dto.AskConnect;
import com.mvc.dto.MessageDto;
import com.mvc.dto.PromiseDto;

public interface CompanionDao {
	//connectionList()메서드 SQL문 ACTIVE = Y
	//getDeleteList()메서드 SQL문 ACTIVE = N
	//1. 연결된 회원 리스트 가져오기
	String queryOne = " SELECT DISTINCT SEN_ID FROM M_MESSAGE JOIN CHAT_LIST USING(CHAT_SERIAL) WHERE REC_ID = ? AND ACTIVE = ? ";
	//2. 연결된 회원과의 최신 메시지 가져오기
	String queryTwo = " SELECT SEN_ID, REC_ID, MESSAGE, USER_IMG, NAME FROM (SELECT * FROM M_MESSAGE WHERE SEN_ID IN(?, ?) "
			+ " AND REC_ID IN(?, ?) ORDER BY M_TIME DESC) JOIN T_USER ON (? = USER_ID) WHERE ROWNUM = 1 ";
	
	//getMessage()메서드 SQL문
	String getMessage = " SELECT SEN_ID, MESSAGE, M_TIME, CHAT_SERIAL, USER_IMG, NAME FROM M_MESSAGE JOIN T_USER ON(SEN_ID = USER_ID) WHERE REC_ID = ? AND SEN_ID = ? "
			+ "UNION ALL "
			+ "SELECT SEN_ID, MESSAGE, M_TIME, CHAT_SERIAL, USER_IMG, NAME FROM M_MESSAGE JOIN T_USER ON(SEN_ID = USER_ID) WHERE REC_ID = ? AND SEN_ID = ? "
			+ "ORDER BY M_TIME ";
	
	//sendMessage()메서드 SQL문
	String sendMessage = " INSERT INTO M_MESSAGE VALUES("
			+ "MESSAGE_SEQ.NEXTVAL, ?, ?, ?, ?, SYSDATE"
			+ ")" ;
	
	
	//연결 신청 리스트
	//블로그 디테일 페이지에서 동행신청을 하면 -> db에 저장되고 -> 해당 리스트를 가져와서 뿌려줘야함
	String askConnectList = " SELECT SEN_ID, COMMENT_ASK, ASK_DATE, USER_IMG, NAME FROM ASK_CONNECT JOIN T_USER ON(SEN_ID = USER_ID) WHERE PERMIT = 'D' AND REC_ID = ? ORDER BY ASK_DATE DESC ";
	
	//불량회원 신고 시 채팅방 삭제된 메세지로 이동하는 쿼리문
	//REC_ID 로그인 되어있는 아이디, SEN_ID 신고당하는 아이디
	String reportUser = "UPDATE CHAT_LIST SET ACTIVE = 'N', DISABLED_DATE = SYSDATE WHERE CHAT_SERIAL = (SELECT DISTINCT CHAT_SERIAL FROM M_MESSAGE JOIN CHAT_LIST USING(CHAT_SERIAL) WHERE SEN_ID = ? AND REC_ID = ? AND ACTIVE='Y')";
	
	public List<MessageDto> connectionList(Connection con, String login_id);
	
	public List<MessageDto> getMessage(Connection con, String login_id, String connect_id);
	public int sendRecMessage(Connection con, String login_id, String con_id, String message, String chat_serial);
	public List<AskConnect> getAskConnect(String login_id);
	public boolean reportUser(Connection con, String login_id, String con_id);
	public List<MessageDto> getDeleteList(String login_id);
	
	/*
	 -- 1. ASK_CONNECT의 PERMIT 바꿔주고, CHAT_LIST 새로 생성, 채팅방 번호 부여
	 -- 2. MESSAGE에 INSERT 해주면 된다.
	 -- 3. 작업이 끝나면 화면단에 뿌려줘야함. 새로 추가해주자
	 --최신 시리얼번호 SELECT해오고 변수에 저장하고 그걸로 사용하자
	 */
	String first = " UPDATE ASK_CONNECT SET PERMIT = 'Y' WHERE SEN_ID = ? AND REC_ID = ? ";
	String second = " INSERT INTO CHAT_LIST VALUES(CHAT_SEQ.NEXTVAL,'Y', NULL) ";
	String third = " SELECT CHAT_SERIAL FROM (SELECT CHAT_SERIAL FROM CHAT_LIST ORDER BY CHAT_SERIAL DESC) WHERE ROWNUM = 1 ";
	String fourth = " INSERT INTO M_MESSAGE VALUES(MESSAGE_SEQ.NEXTVAL, ?, ?, ?, ?, SYSDATE) ";
	
	public boolean askFirst(Connection con, String login_id, String con_id);
	public boolean askSecond(Connection con);
	public int askThird(Connection con);
	public boolean askFourth(Connection con, String login_id, String con_id, String message, int chat_serial);
	
	//연결신청 거부
	String askDenied = "UPDATE ASK_CONNECT SET PERMIT = 'N' WHERE REC_ID = ? AND SEN_ID = ?";
	public boolean askDenied(Connection con, String login_id, String con_id);
	
	//약속 신청
	//INSERT INTO M_PROMISE VALUES(PROMISE_SEQ.NEXTVAL, LOGIN_ID, SEN_ID, LOC, DATE, COMMENT, 'D');
	String makePromise = "INSERT INTO M_PROMISE VALUES(PROMISE_SEQ.NEXTVAL, ?, ?, ?, ?, ?, 'D')";
	public boolean makePromise(Connection con, String login_id, String sen_id, String loc, String date, String comment);
	
	//약속 리스트 가져오기
	String getPromise = "SELECT SEN_ID, P_LOC, P_TIME, P_COMMENT, USER_IMG, NAME FROM M_PROMISE JOIN T_USER ON(SEN_ID = USER_ID) WHERE REC_ID = ? AND PERMIT = 'D' ORDER BY P_SEQ DESC";
	public List<PromiseDto> getPromise(Connection con, String login_id);
	
	
	String promiseChoice = "UPDATE M_PROMISE SET PERMIT = ? WHERE REC_ID = ? AND SEN_ID = ? AND P_LOC = ?";
	public int promiseChoice(Connection con, String login_id, String con_id, String loc, String permit);
	
	//블로그 디테일 -> 동행 신청하기
	String blogAskCompanion = " INSERT INTO ASK_CONNECT VALUES(ASK_SEQ.NEXTVAL, ?, ?, ?, SYSDATE, 'D') ";
	public int blogAskCompanion(Connection con, String login_id, String con_id, String comment);
	
	//완전삭제 과정
	String takeChatSerial = " SELECT CHAT_SERIAL FROM M_MESSAGE "
			+ "WHERE REC_ID = ? AND SEN_ID = ? "
			+ "UNION "
			+ "SELECT CHAT_SERIAL FROM M_MESSAGE "
			+ "WHERE REC_ID = ? AND SEN_ID = ? ";
	String delMessage = " DELETE FROM M_MESSAGE WHERE CHAT_SERIAL = ? "; 
	String delSerial = " DELETE FROM CHAT_LIST WHERE CHAT_SERIAL = ? ";
	public int takeChatSerial(Connection con, String login_id, String con_id);
	public int delMessage(Connection con, int chat_serial);
	public int delSerial(Connection con, int chat_serial);
	
	//메신저-> 현재 성사된 약속목록 불러오기
	String getPromiseList = " SELECT SEN_ID,P_LOC,P_TIME,P_COMMENT,NAME,USER_IMG FROM M_PROMISE "
			+ "JOIN T_USER ON(SEN_ID = USER_ID) WHERE REC_ID = ? AND PERMIT = 'Y' "
			+ "UNION "
			+ "SELECT REC_ID,P_LOC,P_TIME,P_COMMENT,NAME,USER_IMG FROM M_PROMISE "
			+ "JOIN T_USER ON(REC_ID = USER_ID) WHERE SEN_ID = ? AND PERMIT = 'Y' "
			+ "ORDER BY P_TIME ";
	public List<PromiseDto> getPromiseList(Connection con, String login_id);
	
	//거절메세지 발송
	String sendDenyMessage = " INSERT INTO M_MESSAGE VALUES("
			+ "MESSAGE_SEQ.NEXTVAL, ?, ?, ?, ?, SYSDATE"
			+ ")" ;
	public int sendDenyMessage(Connection con, String login_id, String con_id, int chat_serial);
	
	
	//약속 강제 취소
	//1. 패널티 확인
	String getPenalty = " SELECT PENALTY FROM T_USER WHERE USER_ID = ? ";
	public int getPenalty(Connection con, String login_id);
	//2. 약속 삭제 및 패널티 +1
	String deletePromise = " DELETE FROM M_PROMISE WHERE P_LOC = ? ";
	String upPenalty = " UPDATE T_USER SET PENALTY = ? WHERE USER_ID = ? ";
	public int deletePromise(Connection con, String loc);
	public int upPenalty(Connection con, int penalty, String login_id);
	
	//동행 구하기 전 이미 연결되어있는지 확인
	String ableConnection = " SELECT ROWNUM, MESSAGE FROM M_MESSAGE WHERE SEN_ID = ? AND REC_ID = ? ";
	public boolean ableConnection(Connection con, String login_id, String con_id);
}