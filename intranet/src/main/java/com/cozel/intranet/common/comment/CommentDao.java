package com.cozel.intranet.common.comment;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.cozel.intranet.common.abstractDao.AbstractDao;

@Repository
public class CommentDao extends AbstractDao{

    @SuppressWarnings("unchecked")
    public List<Map<String,Object>> getCommentList(Map<String, Object> param) {
        return (List<Map<String, Object>>)selectList("comment.getCommentList", param);
    }
    
    public void setComment(Map<String, Object> param) {
        insert("comment.setComment", param);
    }
    
    public void modComment(Map<String, Object> param) {
        update("comment.modComment", param);
    }
    
    public void delComment(Map<String, Object> param) {
    	update("comment.delComment", param);
    }

}
