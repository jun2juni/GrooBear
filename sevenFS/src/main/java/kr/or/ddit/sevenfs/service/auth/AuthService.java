package kr.or.ddit.sevenfs.service.auth;

public interface AuthService {
    public void saveRefreshToken(String emplNo, String refreshToken);

    public void deleteRefreshToken(String emplNo);
}
