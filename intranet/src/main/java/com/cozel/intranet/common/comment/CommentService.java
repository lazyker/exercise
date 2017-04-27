package com.cozel.intranet.common.comment;

import java.util.List;
import java.util.Map;

public interface CommentService {

    List<Map<String, Object>> getCommentList(Map<String, Object> param);
    
    void setComment(Map<String, Object> param);
    
    void modComment(Map<String, Object> param);
    
    void delComment(Map<String, Object> param);
    
}
