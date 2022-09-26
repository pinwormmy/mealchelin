package kh.project4.mealchelin.board;

import java.util.Date;
import java.util.Map;
import lombok.Data;


@Data
public class CommentVO {

	private Integer rno;
	private Integer pid;
	private String mId;
	private String content;
	private Date regDate;
	private Date updatedate;
	//added
	private String[] files;

	public void validate(Map<String, Boolean> errors) {
		if (content == null || content.trim().isEmpty()) {
			errors.put(content, Boolean.TRUE);
		}
	}

}
