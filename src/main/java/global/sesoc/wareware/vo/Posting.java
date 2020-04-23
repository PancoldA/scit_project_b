package global.sesoc.wareware.vo;

import lombok.Data;

@Data
public class Posting {
	private int posting_id;
	private String posting_title;
	private int posting_active;
	private String posting_company;
	private String posting_location;
	private int posting_career_code;
	private int posting_education_code;
	private String posting_type;
	private String posting_keyword;
	private String posting_job_category;
	private String posting_url;
}
