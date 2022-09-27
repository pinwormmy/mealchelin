package kh.project4.mealchelin.board;

import java.util.Date;
import lombok.*;

@Data
public class CommunityVO {
	
	private Integer cNo;
	private String title;
	private String content;
	private String mId;
	private int mLevel;
	private Date regDate;
	
}
