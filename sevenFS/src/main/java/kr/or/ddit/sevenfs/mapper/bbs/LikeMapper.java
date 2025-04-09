package kr.or.ddit.sevenfs.mapper.bbs;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface LikeMapper {

	public boolean existsLike(Map<String, Object> param);
	public int insertLike(Map<String, Object> param);
	public int deleteLike(Map<String, Object> param);
	public int countLikes(Map<String, Object> param);


}
