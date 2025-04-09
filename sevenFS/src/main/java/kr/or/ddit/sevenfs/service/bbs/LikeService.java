package kr.or.ddit.sevenfs.service.bbs;

public interface LikeService {

	public boolean toggleLike(int bbsSn, int bbsCtgryNo, String emplNo);
	
	public int countLikes(int bbsSn, int bbsCtgryNo);
    
	public boolean existsLike(int bbsSn, int bbsCtgryNo, String emplNo);

}
