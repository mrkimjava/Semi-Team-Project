package com.mvc.biz.companion;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import com.mvc.dao.companion.CompanionDaoImpl;
import com.mvc.dto.MessageDto;
import com.mvc.dto.PromiseDto;

import common.JDBCTemplate;

public class CompanionBizImpl extends JDBCTemplate implements CompanionBiz{
	Connection con = getConnection();
	CompanionDaoImpl dao = new CompanionDaoImpl();
	
	@Override
	public boolean sendRecMessage(String login_id, String con_id, String message, String chat_serial) {
		int res = dao.sendRecMessage(con, login_id, con_id, message, chat_serial);
		
		if (res > 0) {
			commit(con);
		} else {
			rollback(con);
		}
		closeConn(con);
		return res>0?true:false;
	}
	
	@Override
	public boolean askPermit(String login_id, String con_id, String message) {
		boolean flag = false;
		
		flag = dao.askFirst(con, login_id, con_id);
		if (flag == false) {
			rollback(con);
			return flag;
		}
		flag = dao.askSecond(con);
		if (flag == false) {
			rollback(con);
			return flag;
		}
		int chat_serial = dao.askThird(con);
		flag = dao.askFourth(con, login_id, con_id, message, chat_serial);
		
		if (flag) {
			commit(con);
		} else {
			rollback(con);
			return flag;
		}
		closeConn(con);
		
		return flag;
	}

	@Override
	public boolean askDenied(String login_id, String con_id) {
		boolean flag = dao.askDenied(con, login_id, con_id);
		
		if (flag) {
			commit(con);
		} else {
			rollback(con);
		}
		closeConn(con);
		
		return flag;
	}

	@Override
	public boolean makePromise(String login_id, String con_id, String loc, String date, String message) {
		boolean flag = dao.makePromise(con, login_id, con_id, loc, date, message);
		
		if (flag) {
			commit(con);
		} else {
			rollback(con);
		}
		closeConn(con);
		return flag;
	}

	@Override
	public List<PromiseDto> getPromise(String login_id) {
		List<PromiseDto> list = dao.getPromise(con, login_id);
		closeConn(con);
		
		return list;
	}
	
	@Override
	public boolean promiseChoice(String login_id, String con_id, String loc, String permit, String comment, String chat_serial) {
		int res = 0;
		
		if (permit.equals("Y")) {
			res = dao.sendRecMessage(con, login_id, con_id, comment, chat_serial);
		} 
		res += dao.promiseChoice(con, login_id, con_id, loc, permit);
		
		if (res>0) {
			commit(con);
		} else {
			rollback(con);
		}
		closeConn(con);
		
		return res>0?true:false;
	}

	@Override
	public boolean reportUser(String login_id, String con_id) {
		boolean flag = dao.reportUser(con, login_id, con_id);
		
		if (flag) {
			commit(con);
		} else {
			rollback(con);
		}
		
		closeConn(con);
		
		return flag;
	}

	@Override
	public List<MessageDto> getMessage(String login_id, String connect_id) {
		List<MessageDto> list = dao.getMessage(con, login_id, connect_id);
		
		closeConn(con);
		return list;
	}

	@Override
	public List<MessageDto> connectionList(String login_id) {
		List<MessageDto> list = dao.connectionList(con, login_id);
		
		closeConn(con);
		return list;
	}

	@Override
	public boolean blogAskCompanion(String login_id, String con_id, String comment) {
		int res = dao.blogAskCompanion(con, login_id, con_id, comment);
		
		if (res > 0) {
			commit(con);
		} else {
			rollback(con);
		}
		closeConn(con);
		
		return res>0?true:false;
	}

	@Override
	public int completeDelete(String login_id, String con_id) {
		int chat_serial = dao.takeChatSerial(con, login_id, con_id);
		int res = dao.delMessage(con, chat_serial);
		
		if (res > 0) {
			commit(con);
			res = dao.delSerial(con, chat_serial);
			
			if (res > 0) {
				commit(con);
			} else {
				rollback(con);
			}
		} else {
			rollback(con);
		}
		closeConn(con);
		
		return res;
	}

	@Override
	public List<PromiseDto> getPromiseList(String login_id) {
		List<PromiseDto> list = dao.getPromiseList(con, login_id);
		closeConn(con);
		return list;
	}

	@Override
	public int sendDenyMessage(String login_id, String con_id, int chat_serial) {
		int res = dao.sendDenyMessage(con, login_id, con_id, chat_serial);
		
		if (res > 0) {
			commit(con);
		} else {
			rollback(con);
		}
		
		return res;
	}

	@Override
	public int ableCancel(String login_id) {
		int penalty = dao.getPenalty(con, login_id);
		System.out.println("login_id : "+login_id);
		System.out.println("penalty : "+penalty);
		closeConn(con);
		return penalty;
	}

	@Override
	public int deletePromise(String login_id, int penalty, String loc) {
		int res = 0;
		Connection con2 = getConnection();
		
		if (penalty == 3) {
			res = dao.deletePromise(con2, loc);
			if (res > 0) {
				commit(con2);
			} else {
				rollback(con2);
			}
			return res;
			
		} else {
			
			res = dao.upPenalty(con2, penalty, login_id);
			res += dao.deletePromise(con2, loc);
			if (res == 2) {
				commit(con2);
			} else {
				rollback(con2);
			}
		}
		closeConn(con2);
		return res;
	}

	@Override
	public boolean ableAskCompanion(String login_id, String con_id) {
		boolean flag = dao.ableConnection(con, login_id, con_id);
		closeConn(con);
		return flag;
	}
}
