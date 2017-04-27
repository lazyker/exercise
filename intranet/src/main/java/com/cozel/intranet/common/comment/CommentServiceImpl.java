package com.cozel.intranet.common.comment;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service(value = "CommentService")
public class CommentServiceImpl implements CommentService {

	@Autowired
	private CommentDao commentDao;

	@Override
	public List<Map<String, Object>> getCommentList(Map<String, Object> param) {
		return commentDao.getCommentList(param);
	}

	@Override
	public void setComment(Map<String, Object> param) {
		commentDao.setComment(param);
	}

	@Override
	public void modComment(Map<String, Object> param) {
		commentDao.modComment(param);
	}

	@Override
	public void delComment(Map<String, Object> param) {
		commentDao.delComment(param);
	}

}
