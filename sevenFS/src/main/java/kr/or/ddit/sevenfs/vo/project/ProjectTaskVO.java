package kr.or.ddit.sevenfs.vo.project;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.concurrent.TimeUnit;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import kr.or.ddit.sevenfs.vo.AttachFileVO;
import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class ProjectTaskVO {

    private long taskNo;
    private long prjctNo;
    private String taskNm;
    private String taskCn;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date taskBeginDt;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date taskEndDt;

    private int progrsrt;
    private long atchFileNo;
    private Long upperTaskNo;

    private String chargerEmpno;
    private String chargerEmpNm;
    private String role;
    private String priort;
    private String taskGrad;
    private String taskSttus;

    private Integer taskDaycnt;
    private Integer depth;
    private String parentTaskNm;
    private String tempParentIndex;

    private List<MultipartFile> files;
    private List<AttachFileVO> attachFileList;

    // 💡 간트 연동용 getter
    public String getText() {
        return this.taskNm;
    }

    public String getStart_date() {
        return (taskBeginDt != null) ? new SimpleDateFormat("yyyy-MM-dd").format(taskBeginDt) : null;
    }

    public String getEnd_date() {
        return (taskEndDt != null) ? new SimpleDateFormat("yyyy-MM-dd").format(taskEndDt) : null;
    }

    public int getDuration() {
        if (taskBeginDt != null && taskEndDt != null) {
            long diff = taskEndDt.getTime() - taskBeginDt.getTime();
            return (int) TimeUnit.DAYS.convert(diff, TimeUnit.MILLISECONDS) + 1;
        }
        return 1;
    }

    public String getStatus() {
        return taskSttus;
    }

    public int getParent() {
        return (upperTaskNo != null) ? Math.toIntExact(upperTaskNo) : 0;
    }

    // ⚠ setter 생략 가능 (MyBatis는 getter만 있어도 동작)
}
