package kr.or.ddit.sevenfs.mapper;

import kr.or.ddit.sevenfs.vo.AttachFileVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface AttachFileMapper {
    public long getAttachFileNo();

    int getAttachFileSn(long attachFileNo);

    public List<AttachFileVO> getFileAttachList(long attachFileNo);

    public int insertFileList(List<AttachFileVO> attachFileVOList);

    public int removeFileList(AttachFileVO attachFileVO);

    List<AttachFileVO> getFileAttachListToDownload(List<Long> attachFileNoList);
}
