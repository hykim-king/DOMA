package com.acorn.doma.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.acorn.doma.cmn.WorkDiv;
import com.acorn.doma.domain.Comment;
@Mapper
public interface CommentMapper extends WorkDiv<Comment> {

}
