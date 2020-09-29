package project.spring.myAct.service;

import java.util.List;

import project.spring.beans.CommonInterface;

public interface MyActService extends CommonInterface{

	public int myArticleCount(String memId);
	public List getMyArticle(int startRow, int endRow, String memId);
	public int likeArticleCount(String memId);
	public List myLikeArticle(int startRow, int endRow, String memId);
}