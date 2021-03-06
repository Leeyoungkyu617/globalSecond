package project.spring.admin.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.spring.admin.dao.AdminDAO;
import project.spring.admin.dao.AdminDAOImpl;

@Service
public class AdminServiceImpl implements AdminService{

	@Autowired
	private AdminDAO adminDAO = null;
	
	@Override
	public int insertItem() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateItem() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteItem() {
		// TODO Auto-generated method stub
		return 0;
	}

	
	// 멤버 전체 가져오기
	@Override
	public List memberLIst(int start, int end)throws SQLException {
		
		List list =	 adminDAO.memberList(start, end);

		
		return list;
	}
	
	// 검색 멤버
	@Override
	public List memberLIst(int start, int end, Map map) throws SQLException {
		List list = adminDAO.memberList(start, end, map);
		return list;
	}

	// 멤버 개수 가져오기
	@Override
	public int memberCount() throws SQLException {
		int count = adminDAO.memberCount();
		
		return count;
	}

	@Override
	public int insertItem(Object obj) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateItem(Object obj) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteItem(Object obj) {
		
		int i = adminDAO.deleteItem(obj);
		return i;
	}

	@Override
	public int drinkCount() throws SQLException {
		int i = adminDAO.drinkCount();
		return i;
	}

	@Override
	public List drinkList(int start, int end) throws SQLException {
		List list = adminDAO.drinkList(start, end);
		return list;
	}

	@Override
	public int approveDrink(String dkCode, String check) throws SQLException {
		int i = adminDAO.approveDrink(dkCode, check);
		return i;
	}

	@Override
	public int memberCount(Map map) throws SQLException {
		int count = adminDAO.memberCount(map);
		return count;
	}




	
	
}
